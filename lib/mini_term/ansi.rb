# coding: utf-8

require 'io/console'

# A simple, portable terminal interface object. (ANSI Specific Code)
module MiniTerm

  def self.open
    @term_open = true
  end

  def self.close
    @term_open = false
  end

end
