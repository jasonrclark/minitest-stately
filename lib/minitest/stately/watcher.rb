module Minitest
  class Stately
    class Watcher
      def initialize
        @watch   = {}
        @results = {}
        @report  = []
      end

      def watch(name, &blk)
        @watch[name]  = blk
        @results[blk] = blk.call
      end

      def record(result)
        @watch.each do |name, blk|
          value = blk.call
          if @results.include?(blk) && @results[blk] != value
            @report << "#{result.class.name}\##{result.name}: #{name} changed from '#{@results[blk]}' to '#{value}'"
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
