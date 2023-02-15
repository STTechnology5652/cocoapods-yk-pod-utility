# frozen_string_literal: true

module YKPod
  module YKLogTool
    def ykWarning(message)
      puts "\n[⚠️] #{message}".yellow
      return 0
    end

    def ykNotice(message)
      puts "\033[0;34m\n[❕] #{message}\e[0m"
      return 0
    end

    def ykError(message)
      puts "\n[❌] #{message}".red
      return 1
    end
  end

end
