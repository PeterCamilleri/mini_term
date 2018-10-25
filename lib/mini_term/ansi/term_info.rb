# coding: utf-8

# Get size info about the console window. (ANSI Specific Code)
module MiniTerm

  # Get term_info [rows, cols]
  def self.term_info
    IO.console.winsize
  end

end
