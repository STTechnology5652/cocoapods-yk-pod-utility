# frozen_string_literal: true

require 'git'
module Git
  class Base
    def is_clean
      cmd = "git status --short"
      @cmd_out_put = []
      IO.popen(cmd) do |f|
        line = f.gets
        @cmd_out_put << line unless line.blank?
      end

      @cmd_out_put.blank?
    end
  end
end

module YKUtitlityGitModule
  class YKGitManager
    require 'git'
    require 'cocoapods-ykutility/tools/yk_log_tool'
    include YKPod::YKLogTool

    def initialize(dir)
      @dir = dir

      Dir.chdir(dir) do
        @git = Git.open(Dir.pwd)
      end
    end

    def prepare
      is_clean = @git.is_clean
      if is_clean == false
        ykNotice("work tree dirty, work finish") unless is_clean
        return false
      end
      return true
    end

    def commit_for_api(commit_message)
      begin
        @git.add(:all => true)
        @git.commit(commit_message)
        @git.push('origin', @git.current_branch)
      rescue Git::FailedError => e
        puts(e.to_s)
      end
    end

    def update_tag(dest_tag)
      delete_dest_tag(dest_tag.to_s) # 删除原有tag
      create_dest_tag(dest_tag.to_s) # 新建tag
    end

    private

    def create_dest_tag(dest_tag)
      return false unless prepare == true

      puts "start create tag"
      @git.add_tag(dest_tag, :m => "\"#{dest_tag}\" -- auto created with api document, by 'cocoapods-ykutility'")
      @git.push('origin', dest_tag)
    end

    def delete_dest_tag(dest_tag)
      # 此处需要防止本地有tag, 而远端不存在， 所以此处做如下操作
      # 1. 检查本地tag
      # 2. 删除本地tag
      # 3. 拉取远端tag
      # 4. 删除本地和远端tag

      begin
        exist_tag = @git.tag(dest_tag)
      rescue Git::GitTagNameDoesNotExist => e
      end

      ykNotice("tag [#{dest_tag}] existed, we delete it on local and remote \"origin\"") unless exist_tag.blank?
      begin
        @git.delete_tag(dest_tag) unless exist_tag.blank?
        @git.push('origin', dest_tag, :delete => true) unless exist_tag.blank?
      rescue Git::FailedError => e
      end
    end
  end
end
