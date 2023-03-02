# frozen_string_literal: true

module Pod
  class Command
    class Ykutility < Command
      class Push < Ykutility
        require 'cocoapods/command/repo/push'
        require 'cocoapods-ykutility/function/yk_log_tool'
        include YKPod::YKLogTool

        include Pod::Config::Mixin
        self.summary = 'Release a new pod version'

        self.description = <<-DESC
          组件发布新版本
        DESC

        attr_accessor :repo_push_cmd
        attr_accessor :argv_cache

        self.arguments = Pod::Command::Repo::Push.arguments

        def self.options
          Pod::Command::Repo::Push.options.concat(super)
        end

        def initialize(argv)
          # 如果有一部分参数是本类特有的，需要在此处优先取出

          argv_map = argv.remainder # 复制一份参数 用于 Pod::Command::Repo::Push
          # 复制一份参数 用于 Pod::Command::Repo::Lint
          argv_map = argv.remainder

          # 因为这部分参数是 本类 和 Pod::Command::Repo::Push 共有的， 所以本类用 argv 取参数， Pod::Command::Repo::Push使用 argv_map 取参数
          @repo = argv.shift_argument
          @podspec = argv.shift_argument
          @source = source_for_repo
          @source_urls = argv.option('sources', config.sources_manager.all.map(&:url).append(Pod::TrunkSource::TRUNK_REPO_URL).uniq.join(',')).split(',')

          argv_new = CLAide::ARGV.new(argv_map)
          @repo_push_cmd = Pod::Command::Repo::Push.new(argv_new)
          @source_file_grep_arr = []
          # 此处需要保证传给父类的是父类可以都有的参数，不然会因为出现父类处理不了的参数而报错，导致任务失败
          super(argv_new)
        end

        def validate! # 此处validate 是复制 Pod::Command::Repo::Push ， 因为如果直接用 self.repo_push_cmd.validate! 会导致提示显示的是 Pod::Command::Repo::Push  的使用说明
          super
          self.repo_push_cmd.validate!

          help! 'A spec-repo name or url is required.' unless @repo
          unless @source && @source.repo.directory?
            raise Informative,
                  "Unable to find the `#{@repo}` repo. " \
                  'If it has not yet been cloned, add it via `pod repo add`.'
          end
        end

        def run
          ykNotice "pod ykutility push running !"
          self.repo_push_cmd.run # 使用Pod::Command::Repo::Push，发布pod

          podspec_files.each do |one|
            valid = Validator.new(one, @source_urls)
            spec = valid.linter.spec
            file = spec.defined_in_file
            file_accessor = valid.file_accessor
            analysis_one_spec(spec)
            Pod::Specification
            puts("#{spec.name} -> source_file_grep_arr: #{@source_file_grep_arr}")

            Pod::Sandbox::FileAccessor.new([spec.parent])
          end

          # 解析podspec, 识别出 公共文件， tag
          # 根据公共文件，生成接口文档
          # 检查tag是否存在，删除已有tag, 删除远端已有tag
          # 添加接口文档，并提交，生成对应版本的tag,并对送到远端

        end

        private

        def analysis_one_spec(spec)
          public_headers_grep = spec.attributes_hash["public_header_files"]
          source_files = spec.attributes_hash["source_files"]
          podspec_file = spec.defined_in_file
          @source_file_grep_arr.append(source_files)
          puts "#{spec.name} -> public_header_files:#{public_headers_grep}"
          puts "#{spec.name} -> source_files:#{source_files}"

          sub_specs = spec.subspecs
          puts "#{spec.name} -> sub_spec_arr:#{sub_specs}"
          sub_specs.each do |oneSub|
            analysis_one_spec(oneSub)
          end
        end

        def podspec_files
          if @podspec
            path = Pathname(@podspec)
            raise Informative, "Couldn't find #{@podspec}" unless path.exist?
            [path]
          else
            files = Pathname.glob('*.podspec{,.json}')
            raise Informative, "Couldn't find any podspec files in current directory" if files.empty?
            files
          end
        end

        def source_for_repo
          self.config.sources_manager.source_with_name_or_url(@repo) unless @repo.nil?
        rescue
          nil
        end

      end
    end
  end
end