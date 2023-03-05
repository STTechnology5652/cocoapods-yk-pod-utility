# frozen_string_literal: true

module YKApi
  class YkApiParser

    require 'cocoapods-ykutility/tools/yk_log_tool'
    include YKPod::YKLogTool

    def initialize(objc_header_file_list, swift_file_list, output_dir)
      @objc_header_files = objc_header_file_list
      @swift_file_list = swift_file_list
      @output_dir = output_dir
      @json_cache = File.join(output_dir, "json_files_tem")
      FileUtils.rm_r(@json_cache) if File.exist?(@json_cache)
      FileUtils.mkdir(@json_cache)
    end

    def analysis
      json_arr_objc = parse_objc
      json_arr_swift = parse_swift
      create_api(json_arr_objc, json_arr_swift)
    end

    private
    def parse_objc
      ykNotice("#{self.class} --> #{__method__}")
      # sourcekitten doc --objc NSBundle+YKInternational.h  -- -x objective-c -isysroot $(xcrun --show-sdk-path --sdk iphonesimulator)  -fmodules > 123
      cache_arr = []
      @objc_header_files.each do |one|
        cache_path = File.join(@json_cache, one.basename)
        cmd = "sourcekitten doc --single-file --objc \"#{one}\"  -- -x objective-c -isysroot $(xcrun --show-sdk-path --sdk iphonesimulator)  -fmodules > \"#{cache_path}\""
        ykMessage("cmd: #{cmd}")
        code = system(cmd)
        cache_arr.append("\"#{cache_path}\"")
      end

      cache_arr
    end

    def parse_swift
        ykNotice("#{self.class} --> #{__method__}")
        # sourcekitten doc --single-file $input_file -- -j4 $input_file >> $temp_outout

        cache_arr = []
        @swift_file_list.each do |one|
          cache_path = File.join(@json_cache, one.basename)
          cmd = "sourcekitten doc --single-file \"#{one}\" -- -j4 \"#{one}\" > \"#{cache_path}\""
          ykNotice("cmd: #{cmd}")
          code = system(cmd)
          cache_arr.append("\"#{cache_path}\"")
        end

        cache_arr
    end

    def create_api(json_objc_arr, json_swift_arr)
      json_all = json_objc_arr + json_swift_arr

      json_all.map
      cmd = "jazzy --min-acl public --sourcekitten-sourcefile #{json_all.join(",")}"
      cmd << " -o \"#{@output_dir}\""
      ykMessage("cmd: \n#{cmd}")
      cmd_result =system(cmd)
      cmd_result
    end

  end
end
