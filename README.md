# Minitest::Stately
[![Gem Version](https://badge.fury.io/rb/minitest-stately.png)](http://badge.fury.io/rb/minitest-stately)
[![Build Status](https://api.travis-ci.org/jasonrclark/minitest-stately.png)](https://travis-ci.org/jasonrclark/minitest-stately)
[![Code Climate](https://codeclimate.com/github/jasonrclark/minitest-stately.png)](https://codeclimate.com/github/jasonrclark/hometown)
[![Coverage Status](https://coveralls.io/repos/jasonrclark/minitest-stately/badge.png)](https://coveralls.io/r/jasonrclark/hometown)

Find leaking state between tests

## Requirements
Minitest 5.x is required for Minitest::Stately to work properly.

Tests are run against MRI 1.9.3 through 2.1.2, JRuby 1.7 (latest) and head, and
Rubinius 2.x (latest).

Ruby 1.8.7 and REE are not supported. Sorry retro-Ruby fans!

## Installation

    $ gem install minitest-stately

## Usage

### Minitest::Stately.watch
Early in your test run (typically from `test_helper.rb`), set up the condition
blocks you want to watch for changes. The condition blocks run immediately to
set default values, and then after each test the blocks are executed again and
compared for changes. The name provided to watch is used strictly for output
in the final change report.

```
# Watch for freshly started threads
Minitest::Stately.watch("thread count") do
  Thread.list.count
end
```

If there are changes during the test run for a condition, you'll see output
like the following:

```
******************************
Minitest::Stately Changes!!!
******************************
Minitest::StatelyPluginTest#test_again: thread count changed from '1' to '2'
Minitest::StatelyPluginTest#test_defined: thread count changed from '2' to '3'
```


### Minitest::Stately.run
Minitest::Stately can also register `run` blocks to be executed after each
test. This can be useful for clearing out leaked state between all tests in a
suite.

```
Minitest::Stately.run do
  $silly_global_state = nil
end
```

## Contributing

1. Fork it ( https://github.com/jasonrclark/minitest-stately/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
