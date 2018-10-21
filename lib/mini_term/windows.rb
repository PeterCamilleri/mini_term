# coding: utf-8

#Get appropriate access to Windows API calls
if MiniTerm.java?
  require 'win32api'
else
  require_relative 'windows/win_32_api'
end

require_relative 'windows/term_info'

# The class used to manipulate console i/o on a low level.
class MiniTerm

  def initialize
  end

end
