# coding: utf-8

#Get access to Windows API calls

if MiniTerm.java?
  require 'win32api'
else
  require_relative 'windows/win_32_api'
end
