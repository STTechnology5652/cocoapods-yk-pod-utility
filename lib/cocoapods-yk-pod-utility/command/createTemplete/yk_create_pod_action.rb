# frozen_string_literal: true
module YKPod
  require 'fileutils'
  require 'cocoapods'

  class YKCreate
    require 'cocoapods-yk-pod-utility/command/yk_log_tool'
    require 'find'
    include YKPod::YKLogTool

    require 'cocoapods-yk-pod-utility/command/yk_exchange_tool'
    include YKPod::YKExchangeTool

    def initialize(name, language, with_demo, prefix, author, path)
      name = name.start_with?("YK") ? name : "YK" + name

      @name = name
      @language = language.downcase == "objc" ? "objc" : "swift"
      @with_demo = with_demo
      @prefix = prefix
      @author = author
      @path = path

      @project_dir = File.join(@path, @name)
      @template_pod_path = File.join(File.dirname(__FILE__), "template", @language)
      @template_example_path =  File.join(File.dirname(__FILE__), "template", "example")

      time_str = Time.now.strftime("%Y-%m-%d")
      year_str = Time.now.strftime("%Y")
      # 关键字替换
      @keyMap = {
        "YKRPC_POD_NAME" => @name,
        "YKPRC_AUTHOR_NAME" => @author,
        "YKPRC_AUTHOR_EMAIL" => @author,
        "YKPRC_CREATE_DATE" => time_str,
        "YKPRC_CREATE_YEAR" => year_str,
      }
    end

    def createAction()
      puts("create pod execute:", @name, @language, @with_demo, @prefix, @path)
      puts("execute")
      code = create_path
      exit!(code) unless code == 0

      code = create_pod
      exit!(code) unless code == 0

      code = create_example
      exit!(code) unless code == 0
    end

    private

    def create_path()
      ykNotice "模板路径：#{@template_pod_path}"
      return ykError("文件已存在: #{@project_dir}") if File.exist?(@project_dir)

      FileUtils.mkdir(@project_dir)
      return 0
    end

    def create_pod()
      ykNotice "create pod"
      pod_dir_cache = File.join(@project_dir, "#{@name}_cache")
      pod_dir_dest = File.join(@project_dir)
      FileUtils.copy_entry(@template_pod_path, pod_dir_cache)

      # 改文件夹
      file_arr = updateFileDirs(pod_dir_cache, 'YKRPC_POD_NAME', @name)

      # 替换 YKRPC_POD_NAME YKPRC_AUTHOR_NAME YKPRC_AUTHOR_EMAIL  YKPRC_CREATE_DATE   YKPRC_CREATE_YEAR
      updateFiles(file_arr, @keyMap)

      FileUtils.copy_entry(pod_dir_cache, pod_dir_dest)
      FileUtils.rm_r(pod_dir_cache)
      return 0
    end


    def create_example()
      ykNotice "create example"
      example_dir_cache = File.join(@project_dir, "example_cache")
      example_dir_dest = File.join(@project_dir, "example")
      FileUtils.copy_entry(@template_example_path, example_dir_cache)

      # 改文件夹
      file_arr = updateFileDirs(example_dir_cache, 'YKRPC_POD_NAME', @name)

      # 替换 YKRPC_POD_NAME YKPRC_AUTHOR_NAME YKPRC_AUTHOR_EMAIL  YKPRC_CREATE_DATE   YKPRC_CREATE_YEAR
      updateFiles(file_arr, @keyMap)

      FileUtils.copy_entry(example_dir_cache, example_dir_dest)
      FileUtils.rm_r(example_dir_cache)

      return 0
    end

  end
end
