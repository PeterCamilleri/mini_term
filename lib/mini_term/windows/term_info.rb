# coding: utf-8

# Get size info about the console window.
module MiniTerm

  # Get term_info [rows, cols]
  def self.term_info
    raw_buffer = 0.chr * 24
    get_screen_info(raw_buffer)

    width = (raw_buffer[0,2].unpack('S'))[0]
    _left, top, _right, bottom = raw_buffer[10,8].unpack('SSSS')

    [bottom - top + 1, width]
  end

private

  # Get the current row of the cursor.
  def self.get_cursor_row
    raw_buffer = 0.chr * 24
    get_screen_info(raw_buffer)
    (raw_buffer[6,2].unpack('S'))[0]
  end

end
