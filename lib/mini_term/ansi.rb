# coding: utf-8

require 'io/console'
require 'io/wait'

require_relative 'ansi/term_info'
require_relative 'ansi/set_posn'
require_relative 'ansi/raw_input'
require_relative 'ansi/output'

module MiniTerm

  # What options are supported in this ANSI mode?
  VALID_OPTIONS = [:quiet, :strict].freeze

end
