# coding: utf-8

# Give MiniTerm control of the cursor position. (ANSI Specific Code)
module MiniTerm

  # Set the row (optional) and column of the cursor.
  def self.set_posn(row: nil, column:)
    if row
      STDOUT.print("\e[#{row};#{column}f")
    else
      STDOUT.print("\e#{column}G")
    end

    self
  end

end
