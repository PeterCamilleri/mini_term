require_relative '../lib/mini_term'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class MiniTermTest < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  MiniTerm.open(quiet: true, strict: true) unless MiniTerm.term_open?

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

  def test_that_it_is_open
    assert(::MiniTerm.term_open?)
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
    assert_equal(0x00.chr, MiniTerm::PREFIX_00)
    assert_equal(0xE0.chr, MiniTerm::PREFIX_E0)
  end

  def test_that_it_senses_the_term_size
    assert(MiniTerm.term_info.is_a?(Array))
    assert_equal(2, MiniTerm.term_info.length)
    assert(MiniTerm.width.is_a?(Integer))
    assert(MiniTerm.height.is_a?(Integer))
    assert(MiniTerm.width > 0)
    assert(MiniTerm.height > 0)
  end

  def test_cursor_control
     assert_equal(MiniTerm, MiniTerm.set_posn(column: 40))
  end

  def test_making_noise
     assert_equal(MiniTerm, MiniTerm.beep)
  end

  def test_the_mapper
    assert_equal(Class, MiniTerm::Mapper.class)

    MiniTerm.add_map(MiniTerm::TERM_TYPE) do |map|
      map[" ".."~"] = :insert_text
      map["\e[D"]   = :go_left
      map["\e[C"]   = :go_right
      map["\x0D"]   = :enter
    end

    t_i = "A\e[D\e[C\x0D\e[z".chars.each

    assert_equal([:insert_text, "A"], MiniTerm.get_mapped_char { t_i.next } )
    assert_equal([:go_left, "\e[D"], MiniTerm.get_mapped_char { t_i.next } )
    assert_equal([:go_right, "\e[C"], MiniTerm.get_mapped_char { t_i.next } )
    assert_equal([:enter, "\x0D"], MiniTerm.get_mapped_char { t_i.next } )
    assert_equal([:unmapped, "\e[z"], MiniTerm.get_mapped_char { t_i.next } )

    assert_raises do
      MiniTerm.add_map(:foo) do |map|
        map["AA1"]   = :a_a_1
        map["AA"]    = :a_a
      end
    end

    assert_raises do
      MiniTerm.add_map(:foo) do |map|
        map["A"]     = :a
        map["AA1"]   = :a_a_1
      end
    end

    MiniTerm.instance_variable_get(:@maps).clear

    assert_raises do
      MiniTerm.add_map(:foo) do |map|
        map["AA1"]   = :a_a_1
      end

      t_i = "A\e[D\e[C\x0D\e[z".chars.each
      MiniTerm.get_mapped_char { t_i.next }
    end

  end

  def test_putting_our_mark_on_the_screen
    assert_equal(MiniTerm, MiniTerm.print("OK"))
  end

  def test_flush
    assert_equal(MiniTerm, MiniTerm.flush)
  end
end
