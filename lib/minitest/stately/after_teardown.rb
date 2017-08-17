module Minitest
  module Stately
    module AfterTeardown
      def after_teardown
        super
        Minitest::Stately.watcher.record(self)
      end
    end
  end
end
