require_relative '../lib/mini_term>>>'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'


class MiniTermTest < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_that_it_has_a_version_number
    refute_nil ::MiniTerm::VERSION
    assert(::MiniTerm::VERSION.frozen?)
    assert(::MiniTerm::VERSION.is_a?(String))
    assert(/\A\d+\.\d+\.\d+/ =~ ::MiniTerm::VERSION)
  end

  def test_that_it_has_a_description
    refute_nil ::MiniTerm::DESCRIPTION
    assert(::MiniTerm::DESCRIPTION.frozen?)
    assert(::MiniTerm::DESCRIPTION.is_a?(String))
  end

  def test_that_it_senses_the_op_sys
    assert([:windows, :cygwin, :macosx, :linux, :unix].include?(MiniTerm::TERM_PLATFORM))
    assert([:windows, :ansi].include?(MiniTerm::TERM_TYPE))
    assert(MiniTerm.windows? == !MiniTerm.ansi?)
  end

end
