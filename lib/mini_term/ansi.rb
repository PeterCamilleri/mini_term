# coding: utf-8

require 'io/console'

require_relative 'ansi/term_info'
require_relative 'ansi/raw_input'

# A simple, portable terminal interface object. (ANSI Specific Code)
module MiniTerm

  def self.open
    @term_open = true
  end

  def self.close
    end_raw_input if raw?
    @term_open = false
  end

end
