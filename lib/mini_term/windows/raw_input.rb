# coding: utf-8

# Get input from the user in raw mode. (Windows Specific Code)
module MiniTerm

  # The sleep interval waiting for a key to be pressed.
  WAIT_SLEEP = 0.02

  # Get user input uncooked, with no echo or buffering.
  def self.begin_raw_input
    @saved_mode = get_term_mode

    # Clear the ENABLE_LINE_INPUT and ENABLE_PROCESSED_INPUT flags.
    # See https://docs.microsoft.com/en-us/windows/console/setconsolemode
    set_term_mode(@saved_mode & 0xFFFFFFFC)
    @raw_input = true
  end

  # Done with raw mode for now.
  def self.end_raw_input
    set_term_mode(@saved_mode)
    @raw_input = false
  end

  # Is there a character waiting?
  def self.has_raw_char?
    kbhit != 0
  end

  # Get a uncooked character keystroke.
  def self.get_raw_char
    while (kbhit == 0)
      sleep(WAIT_SLEEP)
    end

    getch
  end

end
