# coding: utf-8

# Common Terminal Info
module MiniTerm

  @term_open = false

  # Is the mini_term open just now?
  def self.term_open?
    @term_open
  end

  # Make sure that mini_term is closed on exit.
  at_exit { MiniTerm.close if MiniTerm.term_open? }

end
