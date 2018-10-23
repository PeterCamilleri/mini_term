# coding: utf-8

# Common Terminal Info. (Common Code)
module MiniTerm

  @term_open = false

  # Is the mini_term open just now?
  def self.term_open?
    @term_open
  end

  # Make sure that mini_term is closed on exit.
  at_exit do
    if MiniTerm.term_open?
      MiniTerm.close
      puts "Force MiniTerm.close"
    end
  end

  # What is the terminal width in characters?
  def self.width
    term_info[1]
  end

  # What is the terminal height in rows?
  def self.height
    term_info[0]
  end

end
