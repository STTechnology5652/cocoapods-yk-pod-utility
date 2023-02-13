# frozen_string_literal: true
require 'cocoapods-yk-pod-utility/command/createTemplete/yk_create_pod_action'
module Pod

  class YKUtility < Command
    class Create < YKUtility
      self.summary = 'Creates a new Pod'

      self.description = <<-DESC
          依据标准化模版，创建组件
      DESC

      self.arguments = [
        CLAide::Argument.new('NAME', true),
      ]

      def self.options
        [
          [ '--language=LANGUAGE', 'Language  [ ObjC / Swift ]'],
          [ '--no-demo', 'Without a demo application with your library'],
          ['--prefix=YK', 'Class prefix'],
          ['--pod-path=PATH', 'Pod created at path'],
        ].concat(super)
      end

      def initialize(argv)
        @name = argv.shift_argument

        @language = argv.option('language', "swift").downcase
        @language = @language == "objc" ? @language : "swift"
        @with_demo = !argv.flag?('no-demo', false )
        @prefix = argv.option('prefix')
        @path = argv.option('pod-path', Dir.getwd.to_s)
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
        case @language
        when "objc"

        when "swift"

        else

        end
        YKPod::YKCreate.new(@name, @language, @with_demo, @prefix, File.expand_path(@path)).createAction()

      end

    end

  end
end