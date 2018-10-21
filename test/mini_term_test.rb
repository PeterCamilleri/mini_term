require_relative '../lib/mini_term>>>'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class MiniTermTest < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def mini_term
    term ||= MiniTerm.new
  end

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

  def test_character_defns
    assert_equal("\x07", MiniTerm::BELL)
    assert_equal("\x0A", MiniTerm::LINE_FEED)
    assert_equal("\x0D", MiniTerm::CARRIAGE_RETURN)
    assert_equal("\e", MiniTerm::ESCAPE)
    assert_equal(0xE0.chr, MiniTerm::PREFIX)
  end

  def test_that_it_senses_the_term_size
    assert(mini_term.term_info.is_a?(Array))
  end

end
