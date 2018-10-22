# coding: utf-8

require 'io/console'

# The module used to manipulate console i/o on a low level.
module MiniTerm

  def self.open
    @term_open = true
  end

  def self.close
    @term_open = false
  end

end
