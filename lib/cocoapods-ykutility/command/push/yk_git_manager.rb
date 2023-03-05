# frozen_string_literal: true

module YKUtitlityGitModule
  require 'git'
  class YKGitManager

    def initialize(dest_tag, dir)
      @dir = dir
      @tag = dest_tag

      Dir.chdir(dir) do
        @git = Git.open(Dir.pwd)
      end
    end

    def execute
      delete_dest_tag(@tag.to_s) # 删除原有tag
      create_dest_tag(@tag.to_s) #新建tag
    end

    private
    def create_dest_tag(dest_tag)
      status = @git.status
      Git::Status
      staus
    end

    def delete_dest_tag(dest_tag)
      # 此处需要防止本地有tag, 而远端不存在， 所以此处做如下操作
      # 1. 检查本地tag
      # 2. 删除本地tag
      # 3. 拉取远端tag
      # 4. 删除本地和远端tag
      existed_arr = @git.tags.find_all do |one|
        one.name == dest_tag
      end
      @git.delete_tag(dest_tag) unless existed_arr.blank?

      @git.fetch('origin',:tags => true )
      existed_arr = @git.tags.find_all do |one|
        one.name == dest_tag
      end

      @git.delete_tag(dest_tag) unless existed_arr.blank? unless existed_arr.blank?
      @git.push('origin', dest_tag, :delete => true) unless existed_arr.blank?
    end
  end
end
