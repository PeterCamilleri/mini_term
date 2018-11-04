# coding: utf-8

# Common control character definitions. (Common Code)
module MiniTerm

  BELL = "\x07"
  LINE_FEED = "\x0A"
  CARRIAGE_RETURN = "\x0D"
  ESCAPE = "\x1B"

  # These are mostly used in Windows maps.
  PREFIX_00 = 0x00.chr
  PREFIX_E0 = 0xE0.chr

end
