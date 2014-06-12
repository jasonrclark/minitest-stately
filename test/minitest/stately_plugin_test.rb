require 'minitest/autorun'
require 'minitest/stately_plugin'

$boo = 0
Minitest::Stately.watch("$boo") do
  $boo
end

Minitest::Stately.run do
  $clear_me = nil
end

class Minitest::StatelyPluginTest < Minitest::Test
  def test_defined
    assert_nil $clear_me
    $boo += 1
    $clear_me = true
  end

  def test_again
    assert_nil $clear_me
    $boo += 1
    $clear_me = true
  end
end
