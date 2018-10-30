# coding: utf-8

# Get input from the user in raw mode. (ANSI Specific Code)
module MiniTerm

  # Get user input uncooked, with no echo or buffering.
  def self.begin_raw_input
    @raw_input = true
    STDIN.raw!
  end

  # Done with raw mode for now.
  def self.end_raw_input
    STDIN.cooked!
    @raw_input = false
  end

  # Is there a character waiting?
  def self.has_raw_char?
    STDIN.ready?
  end

  #Get a uncooked character keystroke.
  def self.get_raw_char
    STDIN.getch
  end

end
