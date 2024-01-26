# frozen_string_literal: true

module YKPod
  class YKCreatePodConfig
    attr_accessor :name, :language, :with_demo, :with_register, :author, :author_email, :prefix, :path

    def initialize
      @name = ''
      @language = ''
      @with_demo = true
      @with_register = false

      user_name = open('|git config --global user.name').gets
      user_name = user_name.blank? ? 'xxximac' : user_name
      user_email = open('|git config --global user.email').gets
      user_email = user_email.blank? ? 'xxx@xxx.com' : user_email
      @author = user_name.strip.gsub('.', '')
      @author_email = user_email.strip
      @prefix = 'ST'
      @path = File.expand_path(Dir.getwd.to_s)
    end

    def prefix_name
      name.start_with?(prefix) ? name : prefix + name
    end
  end
end
