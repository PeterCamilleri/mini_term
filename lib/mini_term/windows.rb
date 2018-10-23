# coding: utf-8

# Get appropriate access to Windows API calls
if MiniTerm.java?
  require 'win32api'
else
  require_relative 'windows/win_32_api'
end

require_relative 'windows/link'
require_relative 'windows/term_info'
require_relative 'windows/set_posn'
require_relative 'windows/input'

# A simple, portable terminal interface object. (Windows Specific Code)
module MiniTerm

  def self.open
    @term_open = true
  end

  def self.close
    @term_open = false
  end

end
