# coding: utf-8

# Get size info about the console window. (Windows Specific Code)
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

  # Get the current terminal mode.
  def self.get_term_mode
    raw_buffer = 0.chr * 8
    get_console_mode(raw_buffer)
    raw_buffer[0,4].unpack('L')[0]
  end

  # Get the current terminal mode.
  def self.set_term_mode(new_mode)
    set_console_mode(new_mode)
  end

  # Get the current row of the cursor.
  def self.get_cursor_row
    raw_buffer = 0.chr * 24
    get_screen_info(raw_buffer)
    (raw_buffer[6,2].unpack('S'))[0]
  end

end
