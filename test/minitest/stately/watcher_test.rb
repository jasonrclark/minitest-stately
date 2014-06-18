require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "test_helper"))
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

      def test_multiple_watches_last_one_wins
        first  = 0
        second = 0

        @watcher.watch("hey") { first  += 1 }
        @watcher.watch("hey") { second += 1 }

        # Reset before we record so initial defaulting is wiped
        first  = 0
        second = 0
        @watcher.record(self)

        assert_equal(0, first)
        assert_equal(1, second)
      end

      def test_run
        @boo = 1
        @watcher.run do
          @boo = nil
        end

        @watcher.record(self)
        assert_nil @boo
      end

      def test_fail_if
        @watcher.fail_if("true") do
          true
        end

        result = Minitest::Mock.new
        result.expect(:flunk, nil, [String])
        @watcher.record(result)

        result.verify
      end

      def test_doesnt_fail
        @watcher.fail_if("won't fail") do
          false
        end

        result = Minitest::Mock.new
        @watcher.record(result)

        result.verify
      end

      def assert_changes(name, old, new)
        assert_includes @watcher.report, name
        assert_includes @watcher.report, "#{old.inspect} to #{new.inspect}"
      end
    end
  end
end
