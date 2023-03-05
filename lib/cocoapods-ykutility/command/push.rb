# frozen_string_literal: true

module Pod
  class Command
    class Ykutility < Command
      class Push < Ykutility
        require 'cocoapods/command/repo/push'
        require 'cocoapods-ykutility/tools/yk_log_tool'
        require 'cocoapods-ykutility/command/push/yk_api_analysis'
        require 'cocoapods-ykutility/command/push/yk_git_manager'

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
          argv_map = argv.remainder
          argv_new = CLAide::ARGV.new(argv.remainder)
          @repo_push_cmd = Pod::Command::Repo::Push.new(argv_new)

          # 因为这部分参数是 本类 和 Pod::Command::Repo::Push 共有的， 所以本类用 argv 取参数， Pod::Command::Repo::Push使用 argv_map 取参数
          @repo = argv.shift_argument
          @podspec = argv.shift_argument
          @source = source_for_repo
          @source_urls = argv.option('sources', config.sources_manager.all.map(&:url).append(Pod::TrunkSource::TRUNK_REPO_URL).uniq.join(',')).split(',')
          argv_extra = argv_new.remainder
          argv_extra.append("--help") if argv_map.include?("--help")
          super(CLAide::ARGV.new(argv_extra))
        end

        def validate! # 此处validate 是复制 Pod::Command::Repo::Push ， 因为如果直接用 self.repo_push_cmd.validate! 会导致提示显示的是 Pod::Command::Repo::Push  的使用说明
          super

          help! 'A spec-repo name or url is required.' unless @repo
          unless @source && @source.repo.directory?
            raise Informative,
                  "Unable to find the `#{@repo}` repo. " \
                  'If it has not yet been cloned, add it via `pod repo add`.'
          end
        end

        def run
          ykNotice "pod ykutility push running !"
          #self.repo_push_cmd.run # 使用Pod::Command::Repo::Push，发布pod

          ykNotice "pod ykutility analysis create document running !"
          api_analysis = YKApi::YkApiAnalysis.new(podspec_files, @source_urls)
          aanlysis_success = api_analysis.execute
          raise Informative, "Failed to analysis Component api: #{api_analysis.all_pod_names}" unless aanlysis_success == true
          # 解析podspec, 识别出 公共文件， tag
          # 根据公共文件，生成接口文档
          # 检查tag是否存在，删除已有tag, 删除远端已有tag
          # 添加接口文档，并提交，生成对应版本的tag,并对送到远端
          version = api_analysis.version
          gitmanager = YKUtitlityGitModule::YKGitManager.new(version, Dir.pwd)
          gitmanager.execute

        end

        private

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