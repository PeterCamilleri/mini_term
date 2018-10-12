# coding: utf-8
# An IRB + mini_term test session.

require 'irb'

puts "Starting an IRB console with mini_term loaded."

if ARGV[0] == 'local'
  require_relative 'lib/mini_term'
  puts "mini_term loaded locally: #{MiniTerm::VERSION}"

  ARGV.shift
else
  require 'mini_term'
  puts "mini_term loaded from gem: #{MiniTerm::VERSION}"
end

IRB.start
