require 'minitest/autorun'
require 'minitest/stately_plugin'

$boo = 0
Minitest::Stately.watch("$boo") do
  $boo
end

class Minitest::StatelyPluginTest < Minitest::Test
  def test_defined
    $boo += 1
    assert defined?(Minitest::Stately)
  end

  def test_again
    $boo += 1
  end

  def test_no_change
  end
end
