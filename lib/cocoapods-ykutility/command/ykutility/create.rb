# frozen_string_literal: true
require 'cocoapods-ykutility/function/yk_create_pod_action'
require 'cocoapods-ykutility/gem_version'

module Pod
  class Command
    class Ykutility < Command

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
            ['--pod-path=PATH', 'Pod created at path'],
          ].concat(super)
        end

        def initialize(argv)
          @name = argv.shift_argument

          @language = argv.option('language', "swift").downcase
          @language = (["objc", "oc"].include? @language) ? "objc" : "swift"
          @with_demo = !argv.flag?('no-demo', false)
          @author = argv.option('author', open("|git config --global user.name").gets).strip.gsub('.', '')
          @author_email = argv.option('email', open("|git config --global user.email").gets).strip
          @path = File.expand_path(argv.option('pod-path', Dir.getwd.to_s))
          super
          @additional_args = argv.remainder!
        end

        def validate!
          super
          help! 'A name for the Pod is required.' unless @name
          help! 'The Pod name cannot contain spaces.' if @name =~ /\s/
          help! 'The Pod name cannot contain plusses.' if @name =~ /\+/
          help! "The Pod name cannot begin with a '.'" if @name[0, 1] == '.'
        end

        def run
          puts("create pod run")

          YKPod::YKCreate.new(@name, @language, @with_demo, @author, @author_email, @path).createAction()

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