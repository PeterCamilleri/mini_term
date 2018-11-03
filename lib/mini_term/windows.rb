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
require_relative 'windows/raw_input'
require_relative 'windows/output'

module MiniTerm

  # What options are supported in this Windows?
  VALID_OPTIONS = [:quiet, :strict, :pass_ctrl_s, :pass_ctrl_c]

end
