# coding: utf-8

# MiniTerm needs to put text on the screen!
module MiniTerm

  # Put some text onto the screen.
  def self.print(text)
    STDOUT.print(text)
    self
  end

end
