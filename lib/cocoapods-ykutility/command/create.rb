# frozen_string_literal: true
require 'cocoapods-ykutility/command/create/yk_create_pod_action'
require 'cocoapods-ykutility/gem_version'

module Pod
  class Command
    class Ykutility < Command

      require 'cocoapods-ykutility/command/create/yk_create_pod_config'
      class Create < Ykutility

        self.summary = 'Creates a new Pod'

        self.description = <<-DESC
          依据标准化模版，创建组件
        DESC

        self.arguments = [
          CLAide::Argument.new('NAME', true)
        ]

        def self.options
          [
            ['--language=LANGUAGE', 'Language  [ ObjC / Swift ]'],
            ['--no-demo', 'Without a demo application for your library'],
            ['--author=AUTHOR', 'Author'],
            ['--email=EMAIL', 'Email'],
            ['--prefix=PREFIX', 'Prefix header'],
            ['--pod-path=PATH', 'Pod created at path'],
            ['--business', 'With service/router register template'],
          ].concat(super)
        end

        def initialize(argv)
          @config = YKPod::YKCreatePodConfig.new()

          @config.name = argv.shift_argument
          @config.language = (["objc", "oc"].include? argv.option('language', "swift").downcase) ? "objc" : "swift"
          @config.with_demo = !argv.flag?('no-demo', false)
          @config.with_register = argv.flag?('business', false)
          author = argv.option('author', open("|git config --global user.name").gets)
          author = author.blank? ?  "defualt_author" :  author
          @config.author = author.strip.gsub('.', '')

          email = argv.option('email', open("|git config --global user.email").gets)
          email = email.blank? ?  "defualt_email" :  email
          @config.author_email = email.strip

          @config.prefix = argv.option('prefix', "ST")
          @config.path = File.expand_path(argv.option('pod-path', Dir.getwd.to_s))
          super
          @additional_args = argv.remainder!
        end

        def validate!
          super
          help! 'A name for the Pod is required.' unless @config.name
          help! 'The Pod name cannot contain spaces.' if @config.name =~ /\s/
          help! 'The Pod name cannot contain plusses.' if @config.name =~ /\+/
          help! "The Pod name cannot begin with a '.'" if @config.name[0, 1] == '.'
        end

        def run
          puts("create pod run")

          YKPod::YKCreate.new(@config).createAction()

        end

        # Runs the template configuration utilities.
        #
        # @return [void]
        #
        def print_info
          UI.puts "\nTo learn more about the template see `#{CocoapodsYkPodUtility::YK_POD_TEMPLATE_PATH}`."
        end

      end

    end
  end
end
