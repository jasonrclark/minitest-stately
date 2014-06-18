require 'minitest/stately/after_teardown'
require 'minitest/stately/reporter'
require 'minitest/stately/watcher'

module Minitest
  module Stately
    @watcher = Watcher.new

    def self.watcher
      @watcher
    end

    def self.watch(name, &blk)
      @watcher.watch(name, &blk)
    end

    def self.run(&blk)
      @watcher.run(&blk)
    end

    def self.fail_if(name, &blk)
      @watcher.fail_if(name, &blk)
    end
  end

  class ::Minitest::Test
    include Minitest::Stately::AfterTeardown
  end

  def self.plugin_stately_init(options)
    self.reporter.reporters << Minitest::Stately::Reporter.new
  end
end
