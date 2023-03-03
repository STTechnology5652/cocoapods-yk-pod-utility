# frozen_string_literal: true

module YKPod

  class YKCreatePodConfig
    attr_accessor :name, :language, :with_demo, :author, :author_email, :prefix, :path

    def initialize()
      @name = ""
      @language = ""
      @with_demo = true
      @author = open("|git config --global user.name").gets.strip.gsub('.', '')
      @author_email = open("|git config --global user.email").gets.strip
      @prefix = "YK"
      @path = File.expand_path(Dir.getwd.to_s)
    end

    def prefix_name
      return name.start_with?(prefix) ? name : prefix + name
    end
  end
end 
