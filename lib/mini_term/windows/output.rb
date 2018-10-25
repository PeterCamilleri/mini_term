# coding: utf-8

# MiniTerm needs to put text on the screen! (Windows Specific Code)
module MiniTerm

  # Put some text onto the screen.
  def self.print(text)
    STDOUT.print(text)
    self
  end

  # See link.rb for the beep method.

end
