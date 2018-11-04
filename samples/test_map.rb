# A sample test map for use with the mapped_key_test program.

MiniTerm.add_map(:windows) do |map|

  # Make local copies of the prefixes for brevity.
  x00 = MiniTerm::PREFIX_00
  xe0 = MiniTerm::PREFIX_E0

  #The Escape key
  map["\e"]    = :cancel

  #End of Input
  map["\x1A"]  = :end_of_input

end
