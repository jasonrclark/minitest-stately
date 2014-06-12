module Minitest
  module Stately
    class Reporter < Minitest::Reporter
      def initialize(options={})
        super(options.delete(:io) || $stdout, options)
      end

      def record(result)
        Minitest::Stately.watcher.record(result)
      end

      def report
        io.puts(Minitest::Stately.watcher.report)
      end
    end
  end
end
