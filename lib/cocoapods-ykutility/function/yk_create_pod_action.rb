# frozen_string_literal: true
module YKPod
  require 'fileutils'
  require 'cocoapods'

  class YKCreate
    require 'cocoapods-ykutility/function/yk_create_pod_config'
    require 'cocoapods-ykutility/function/yk_log_tool'
    require 'find'
    include YKPod::YKLogTool

    require 'cocoapods-ykutility/gem_version'
    require 'cocoapods-ykutility/function/yk_exchange_tool'
    include YKPod::YKExchangeTool

    def initialize(conf)

      @config = YKPod::YKCreatePodConfig
      @config = conf

      # name = conf.start_with?(conf.prefix) ? name : conf.prefix + name
      # @config.name = name

      @project_dir_dest = File.join(@config.path, @config.prefix_name)
      @example_dir_dest = File.join(@project_dir_dest, "Example")

      @template_pod_path = File.join(CocoapodsYkPodUtility::YK_POD_TEMPLATE_PATH, @config.language)
      @template_example_path = File.join(CocoapodsYkPodUtility::YK_POD_TEMPLATE_PATH, "example")

      time_str = Time.now.strftime("%Y/%m/%d")
      year_str = Time.now.strftime("%Y")
      # 关键字替换
      @keyMap = {
        "YKRPC_POD_NAME" => @config.prefix_name,
        "YKPRC_AUTHOR_NAME" => @config.author,
        "YKPRC_AUTHOR_EMAIL" => @config.author_email,
        "YKPRC_CREATE_DATE" => time_str,
        "YKPRC_CREATE_YEAR" => year_str,
      }

    end

    def createAction()
      ykNotice "create pod execute: \n name: #{@config.name} \n language: #{@config.language} \n with_demo: #{@config.with_demo} \n path: #{@config.path} \n author: #{@config.author}\n author_email: #{@config.author_email}"
      code = create_path
      exit!(code) unless code == 0

      code = create_pod
      exit!(code) unless code == 0

      if @config.with_demo
        code = create_example
        exit!(code) unless code == 0

        pod_install
      end

    end

    private

    def create_path()
      ykNotice "模板路径：#{@template_pod_path}"
      return ykError("文件已存在: #{@project_dir_dest}") if File.exist?(@project_dir_dest)

      FileUtils.mkdir(@project_dir_dest)
      return 0
    end

    def create_pod()
      ykNotice "create pod"
      pod_dir_cache = File.join(@project_dir_dest, "#{@config.prefix_name}_cache")
      pod_dir_dest = File.join(@project_dir_dest)
      FileUtils.copy_entry(@template_pod_path, pod_dir_cache)

      # 改文件夹
      file_arr = updateFileDirs(pod_dir_cache, 'YKRPC_POD_NAME',@config.prefix_name)

      # 替换 YKRPC_POD_NAME YKPRC_AUTHOR_NAME YKPRC_AUTHOR_EMAIL  YKPRC_CREATE_DATE   YKPRC_CREATE_YEAR
      updateFiles(file_arr, @keyMap)

      FileUtils.copy_entry(pod_dir_cache, pod_dir_dest)
      FileUtils.rm_r(pod_dir_cache)
      return 0
    end

    def create_example()
      ykNotice "create example"
      example_dir_cache = File.join(@project_dir_dest, "Example_cache")

      FileUtils.copy_entry(@template_example_path, example_dir_cache)

      # 改文件夹
      file_arr = updateFileDirs(example_dir_cache, 'YKRPC_POD_NAME', @config.prefix_name)

      # 替换 YKRPC_POD_NAME YKPRC_AUTHOR_NAME YKPRC_AUTHOR_EMAIL  YKPRC_CREATE_DATE   YKPRC_CREATE_YEAR
      updateFiles(file_arr, @keyMap)

      FileUtils.copy_entry(example_dir_cache, @example_dir_dest)
      FileUtils.rm_r(example_dir_cache)

      return 0
    end

    def pod_install
      ykNotice "open project"
      Dir.chdir(@example_dir_dest) do
      system('pod install')
      system('pod install')
      system('open -a /Applications/Xcode.app ./*.xcworkspace')
      end
    end


  end
end
