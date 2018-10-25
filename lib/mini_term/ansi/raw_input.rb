# coding: utf-8

# Get input from the user in raw mode. (ANSI Specific Code)
module MiniTerm

  # Get user input uncooked, with no echo or buffering.
  def self.begin_raw_input
    STDIN.raw!
    @raw_input = true
  end

  # Done with raw mode for now.
  def self.end_raw_input
    STDIN.cooked!
    @raw_input = false
  end

  #Get a uncooked character keystroke.
  def self.get_raw_char
    STDIN.getch
  end

end
