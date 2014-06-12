require 'minitest/stately/reporter'
require 'minitest/stately/watcher'

module Minitest
  class Stately
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
  end

  def self.plugin_stately_init(options)
    self.reporter.reporters << Minitest::Stately::Reporter.new
  end
end
