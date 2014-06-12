require 'minitest/autorun'
require 'minitest/stately/watcher'

module Minitest
  class Stately
    class WatcherTest < Minitest::Test
      def setup
        @watcher = Watcher.new
      end

      def test_watcher_no_change
        @watcher.watch("the truth") do
          true
        end

        @watcher.record(self)
        assert_empty @watcher.report
      end

      def test_watcher_change
        @watcher.watch("@boo") do
          @boo
        end

        @boo = 1
        @watcher.record(self)

        @boo += 1
        @watcher.record(self)

        assert_changes(name, 1, 2)
      end

      def test_multiple_changes
        @watcher.watch("@boo") do
          @boo
        end

        @boo = 1
        @watcher.record(self)

        @boo += 1
        @watcher.record(self)

        @boo += 1
        @watcher.record(self)

        assert_changes(name, 1, 2)
        assert_changes(name, 2, 3)
      end

      def assert_changes(name, old, new)
        assert_includes @watcher.report, name
        assert_includes @watcher.report, "'#{old}' to '#{new}'"
      end
    end
  end
end
