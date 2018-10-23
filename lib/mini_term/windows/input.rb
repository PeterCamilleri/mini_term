# coding: utf-8

# Get input from the user in raw mode. (Windows Specific Code)
module MiniTerm

  # The sleep interval waiting for a key to be pressed.
  WAIT_SLEEP = 0.02

  # Get user input uncooked, with no echo or buffering.
  def self.begin_raw_input
    @raw_input = true
  end

  # Done with raw mode for now.
  def self.end_raw_input
    @raw_input = false
  end

end
