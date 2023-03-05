# frozen_string_literal: true

module YKApi
  class YkApiAnalysis
    require 'cocoapods-ykutility/tools/yk_log_tool'
    require 'cocoapods-ykutility/command/push/yk_api_parse'

    require 'cocoapods'

    include YKPod::YKLogTool

    attr_accessor :spec_list, :pod_names, :version
    def initialize(podspec_files, source_urls)
      @spec_files = podspec_files
      @source_urls = source_urls

      @public_headers = []
      @source_files = []
      @swift_files = []
      @pod_names = []
      @version = ""
    end

    def execute
      analysis_all_specs
      analysis_api
    end

    def all_pod_names
      "\"#{@pod_names.join(" ")}\""
    end

    private
    def analysis_all_specs()
      @spec_files.each do |one|
        valid = Pod::Validator.new(one, @source_urls)
        spec = valid.linter.spec
        @version = spec.version.to_s
        analysis_one_spec(spec)
      end

      ykMessage "all public header files:\n#{@public_headers.join("\n")}"
      ykMessage "all source code files:\n#{@source_files.join("\n")}"
      @swift_files = @source_files.find_all do |onePath|
        onePath.extname == ".swift"
      end
      ykMessage "all swift files:\n#{@swift_files}"
    end

    def analysis_one_spec(spec)
      path_list = Pod::Sandbox::PathList.new(spec.defined_in_file.dirname)
      file_accessor = Pod::Sandbox::FileAccessor.new(path_list, spec.consumer(Pod::Platform.ios))
      public_header_arr = file_accessor.public_headers
      ykMessage("#{spec.name} --> plubic_headers:\n#{public_header_arr.join("\n")}")
      @public_headers.concat(public_header_arr) unless public_header_arr.blank?
      @pod_names.append(spec.name)

      source_file_arr = file_accessor.source_files
      ykMessage("#{spec.name} --> source_files:\n#{source_file_arr.join("\n")}")
      @source_files.concat(source_file_arr) unless source_file_arr.blank?

      sub_spec_arr = spec.subspecs
      ykNotice "#{spec.name} has sub_specs: #{sub_spec_arr.join(",\t")}" unless sub_spec_arr.blank?
      sub_spec_arr.each do |oneSub|
        analysis_one_spec(oneSub)
      end
    end

    def analysis_api
      api_output_dir = File.join(Dir.pwd, "Api")
      if File.exist?(api_output_dir)
        FileUtils.rm_r(api_output_dir)
      end

      FileUtils.mkdir(api_output_dir)
      analysis_success = YKApi::YkApiParser.new(@public_headers, @swift_files, api_output_dir).analysis
      analysis_success
    end

  end
end
