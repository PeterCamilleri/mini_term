# coding: utf-8

# Get input from the user in raw mode. (ANSI Specific Code)
module MiniTerm

  # Is there a character waiting?
  def self.has_raw_char?
    raw { STDIN.ready? }
  end

  #Get a uncooked character keystroke.
  def self.get_raw_char
    fail MiniTermNotRaw, "Not in raw mode." unless raw?
    STDIN.getch
  end

private

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

end
