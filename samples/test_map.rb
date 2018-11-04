# A sample test map for use with the mapped_key_test program.
# These demonstrate overriding the mappings built into the program.

MiniTerm.add_map(:windows) do |map|

  # Make local copies of the prefixes for brevity.
  x00 = MiniTerm::PREFIX_00
  xe0 = MiniTerm::PREFIX_E0

  #The Cancel key
  map["\e"]    = :cancel

  #End of Input
  map["\x1A"]  = :end_of_input

  $exit_info[:windows] = [:end_of_input, "Ctrl+z"]
end

MiniTerm.add_map(:ansi) do |map|

  #The Cancel key
  map["\f"]    = :cancel

  #End of Input
  map["\ez"] = :end_of_input

  $exit_info[:ansi] = [:end_of_input, "Alt+z"]
end
