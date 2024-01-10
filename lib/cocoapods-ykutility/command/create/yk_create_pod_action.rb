# frozen_string_literal: true
module YKPod
  require 'fileutils'
  require 'cocoapods'

  class YKCreate
    require 'cocoapods-ykutility/command/create/yk_create_pod_config'
    require 'cocoapods-ykutility/tools/yk_log_tool'
    require 'find'
    include YKPod::YKLogTool

    require 'cocoapods-ykutility/gem_version'
    require 'cocoapods-ykutility/command/create/yk_exchange_tool'
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
      @register_pod_path = File.join(CocoapodsYkPodUtility::YK_POD_BUSINESS_REGISTER_PATH, @config.language)

      time_str = Time.now.strftime("%Y/%m/%d")
      year_str = Time.now.strftime("%Y")
      # 关键字替换
      @keyMap = {
        "YKRPC_POD_NAME" => @config.prefix_name,
        "YKRPC_AUTHOR_NAME" => @config.author,
        "YKRPC_AUTHOR_EMAIL" => @config.author_email,
        "YKRPC_CLASS_PREFIX" => @config.prefix,
        "YKRPC_CREATE_DATE" => time_str,
        "YKRPC_CREATE_YEAR" => year_str,
      }

    end

    def createAction()
      ykNotice "create pod execute: \n name: #{@config.name} \n language: #{@config.language} \n with_demo: #{@config.with_demo} \n path: #{@config.path} \n author: #{@config.author}\n author_email: #{@config.author_email}"
      code = create_path
      exit!(code) unless code == 0

      code = create_pod()
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
      prepare_business_pod_files(pod_dir_cache)

      # 改文件夹
      file_arr = updateFileDirs(pod_dir_cache, 'YKRPC_POD_NAME',@config.prefix_name)

      # 替换 YKRPC_POD_NAME YKRPC_AUTHOR_NAME YKRPC_AUTHOR_EMAIL  YKRPC_CREATE_DATE   YKRPC_CREATE_YEAR
      updateFiles(file_arr, @keyMap)

      FileUtils.copy_entry(pod_dir_cache, pod_dir_dest)
      FileUtils.rm_r(pod_dir_cache)
      return 0
    end

    def prepare_business_pod_files(pod_dir_cache)
      return unless @config.with_register == true
      FileUtils.copy_entry(@register_pod_path, pod_dir_cache)
      # 添加私有依赖
      spec_file_path = File.join(pod_dir_cache, "YKRPC_POD_NAME.podspec")

      # 在倒数第二行插入新语句
      # s.dependency "YKRouterComponent"
      #   s.dependency "YKModuleServiceComponent.swift" #swift 服务中间件， 如果是纯oc组件，请注释此中间件
      de_router = "spec.dependency \"YKRouterComponent\"\n"
      de_service = "spec.dependency \"YKModuleServiceComponent"
      if @config.language == "swift"
        de_service += ".swift\" #swift 服务中间件\n"
      else
        de_service += "\" #oc 服务中间件\n"
      end

      lines = File.readlines(spec_file_path)
      lines.insert(-2, de_router)
      lines.insert(-2, de_service)
      File.open(spec_file_path, 'w') { |file| file.puts(lines.join) }
    end

    def create_example()
      ykNotice "create example"
      example_dir_cache = File.join(@project_dir_dest, "Example_cache")

      FileUtils.copy_entry(@template_example_path, example_dir_cache)
      prepare_business_pod_source(example_dir_cache)

      # 改文件夹
      file_arr = updateFileDirs(example_dir_cache, 'YKRPC_POD_NAME', @config.prefix_name)

      # 替换 YKRPC_POD_NAME YKRPC_AUTHOR_NAME YKRPC_AUTHOR_EMAIL  YKRPC_CREATE_DATE   YKRPC_CREATE_YEAR
      updateFiles(file_arr, @keyMap)

      FileUtils.copy_entry(example_dir_cache, @example_dir_dest)
      FileUtils.rm_r(example_dir_cache)

      return 0
    end


    def prepare_business_pod_source(example_dir_cache)
      return unless @config.with_register == true
      pod_file_cache = File.join(example_dir_cache, "podfile")


      # 在第二行插入新语句
      source_pri = "http://gitlab.y" + "ea" + "hk" + "a.com/App/iOS/YeahkaNativeComSpecsIndex.git"
      lines = File.readlines(pod_file_cache)
      lines.insert(2, "source \"#{source_pri}\"\n")
      File.open(pod_file_cache, 'w') { |file| file.puts(lines.join) }
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
