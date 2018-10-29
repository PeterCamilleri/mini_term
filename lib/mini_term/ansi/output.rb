# coding: utf-8

# MiniTerm needs to put text on the screen! (ANSI Specific Code)
module MiniTerm

  # Put some text onto the screen.
  def self.print(text)
    STDOUT.print(text)
    self
  end

  # Sound a beep
  def self.beep
    STDERR.write(BELL)
    STDERR.flush
    self
  end

  # Clear the screen and home the cursor
  def self.clear_screen
    STDOUT.print("\e[f\e[2J")
    self
  end

end
