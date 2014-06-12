module Minitest
  module Stately
    class Watcher
      def initialize
        @watch   = {}
        @run     = []

        @results = {}
        @report  = []
      end

      def watch(name, &blk)
        @watch[name]  = blk
        @results[blk] = blk.call
      end

      def run(&blk)
        @run << blk
      end

      def record(result)
        record_changes(result)
        run_blocks()
      end

      def record_changes(result)
        @watch.each do |name, blk|
          value = blk.call
          if value_changed?(blk, value)
            @report << message(result, name, blk, value)
          end
          @results[blk] = value
        end
      end

      def run_blocks()
        @run.each do |blk|
          blk.call
        end
      end

      def value_changed?(blk, value)
        @results[blk] != value
      end

      def message(result, name, blk, value)
        "#{result.class.name}\##{result.name}: #{name} changed from '#{@results[blk]}' to '#{value}'"
      end

      HEADER = <<-EOS

******************************
Minitest::Stately Changes!!!
******************************
EOS

      def report
        return "" if @report.empty?

        HEADER + @report.join("\n") + "\n\n"
      end
    end
  end
end
