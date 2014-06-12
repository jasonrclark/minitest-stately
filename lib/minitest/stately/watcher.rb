module Minitest
  class Stately
    class Watcher
      def initialize
        @watch   = []
        @results = {}
        @report  = []
      end

      def watch(&blk)
        @watch << blk
      end

      def record(result)
        @watch.each do |blk|
          value = blk.call
          if @results.include?(blk) && @results[blk] != value
            @report << "#{result.class.name}\##{result.name}: was '#{@results[blk]}', changed to '#{value}'"
          end
          @results[blk] = value
        end
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
