require_relative '../lib/mini_term>>>'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'


class MiniTermTest < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_that_it_has_a_version_number
    refute_nil ::MiniTerm::VERSION
    assert(::MiniTerm::VERSION.is_a?(String))
    assert(/\A\d+\.\d+\.\d+/ =~ ::MiniTerm::VERSION)
  end

end
