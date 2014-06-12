require 'minitest/autorun'
require 'minitest/stately/watcher'

module Minitest
  module Stately
    class WatcherTest < Minitest::Test
      def setup
        @watcher = Watcher.new
      end

      def test_watcher_no_change
        @boo = 1
        @watcher.watch("@boo") do
          @boo
        end

        @watcher.record(self)
        assert_empty @watcher.report
      end

      def test_watcher_change_from_initial_default
        @boo = 1
        @watcher.watch("@boo") do
          @boo
        end

        @boo += 1
        @watcher.record(self)

        assert_changes(name, 1, 2)
      end

      def test_multiple_changes
        @boo = 1
        @watcher.watch("@boo") do
          @boo
        end

        @boo += 1
        @watcher.record(self)

        @boo += 1
        @watcher.record(self)

        assert_changes(name, 1, 2)
        assert_changes(name, 2, 3)
      end

      def test_run
        @boo = 1
        @watcher.run do
          @boo = nil
        end

        @watcher.record(self)
        assert_nil @boo
      end

      def assert_changes(name, old, new)
        assert_includes @watcher.report, name
        assert_includes @watcher.report, "'#{old}' to '#{new}'"
      end
    end
  end
end
