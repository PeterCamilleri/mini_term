# coding: utf-8

# Give MiniTerm control of the cursor position.
module MiniTerm

  # Set the row (optional) and column of the cursor.
  def self.set_posn(row: get_cursor_row, column:)
    set_cursor_posn(row * 65536 + column)
  end

end