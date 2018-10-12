# coding: utf-8

require 'rbconfig'

require_relative "mini_term/version"

# A simple, portable terminal interface object.
class MiniTerm
  host_os = RbConfig::CONFIG['host_os']

  #What operating platform is in effect?
  TERM_PLATFORM =
    case host_os
    when /mswin|msys|mingw|bccwin|wince|emc/
      :windows
    when /cygwin/
      :cygwin
    when /darwin|mac os/
      :macosx
    when /linux/
      :linux
    when /solaris|bsd/
      :unix
    else
      raise "Unknown os: #{host_os.inspect}"
    end

  TERM_TYPE = (TERM_PLATFORM == :windows) ? :windows : :ansi

  #Is Java present in the environment?
  TERM_JAVA = RUBY_PLATFORM =~ /java/
end
