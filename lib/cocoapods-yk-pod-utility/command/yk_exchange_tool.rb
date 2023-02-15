# frozen_string_literal: true

module YKPod
  module YKExchangeTool
    require 'cocoapods-yk-pod-utility/command/yk_log_tool'
    include YKPod::YKLogTool
    def updateFileDirs(rootDir, keyWord, destWord)
      Dir.glob("#{rootDir}/**/**/**/**").each do |name|
        next if File.directory?(name) == false
        name_new = name.gsub(keyWord, destWord)
        FileUtils.mv(name, name_new) unless name_new == name
      end

      # 改文件名

      fileArr = []
      Dir.glob("#{rootDir}/**/**/**/**").each do |name|
        next if Dir.exists? name

        name_new = name.gsub(keyWord, destWord)
        FileUtils.mv(name, name_new) unless name_new == name
        fileArr.append(name_new)
      end

      return fileArr
    end

    def updateFiles(file_arr, key_map)
      file_arr.each do |one|
        onefile = File.read one
        key_map.each do |key, dest|
          if key.blank? or dest.blank?
            ykNotice "skip word: #{key} -> #{dest}"
            next
          end
          puts "#{key} --> #{dest}"
          onefile.gsub!(key, dest)
        end

        File.open(one, "w") { |file| file.puts onefile }
      end
    end

  end

end

