# frozen_string_literal: true

module YKPod
  class YKCreate

    def initialize(name, language, with_demo, prefix, path)
      name = name.start_with?("YK") ? name : "YK" + name

      @name = name
      @language = language
      @with_demo = with_demo
      @prefix = prefix
      @path = path
    end

    def createAction()
      puts("create pod execute:", @name, @language, @with_demo, @prefix, @path)
      puts("execute")
    end
  end
end
