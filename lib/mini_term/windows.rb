# coding: utf-8

#Get access to Windows API calls

if MiniTerm.java?
  require 'win32api'
else
  require_relative 'windows/win_32_api'
end

# The class used to manipulate console i/o on a low level.
class MiniTerm

  def initialize
  end

end
