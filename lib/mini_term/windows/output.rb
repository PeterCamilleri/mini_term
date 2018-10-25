# coding: utf-8

module MiniTerm

  # Put some text onto the screen.
  def self.print(text)
    STDOUT.print(text)
    self
  end

end
