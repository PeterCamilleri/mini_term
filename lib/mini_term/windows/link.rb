# coding: utf-8

# Link Ruby to the Windows API calls needed by MiniTerm
module MiniTerm

  # The magic numbers for the handles.
  STDIN_ID = -10
  STDOUT_ID = -11

  # MiniTerm needs to retrieve standard handles.
  get_handle_proc = Win32API.new("kernel32", "GetStdHandle", ['L'], 'L')

  define_singleton_method(:get_handle) do |handle_index|
    get_handle_proc.call(handle_index)
  end

  # Well, stdout's handle in particular.
  def self.stdout_handle
    get_handle(STDOUT_ID)
  end

  # Well, stdin's handle in particular.
  def self.stdin_handle
    get_handle(STDIN_ID)
  end

  # MiniTerm needs to get the current stdin mode
  get_mode_proc = Win32API.new("kernel32", "GetConsoleMode", ['L', 'P'], 'I')

  define_singleton_method(:get_console_mode) do |buffer|
    get_mode_proc.call(stdin_handle, buffer)
  end

  # MiniTerm needs to set the current stdin mode
  set_mode_proc = Win32API.new("kernel32", "SetConsoleMode", ['L', 'L'], 'I')

  define_singleton_method(:set_console_mode) do |new_mode|
    set_mode_proc.call(stdin_handle, new_mode)
  end

  # MiniTerm needs to retrieve screen info.
  get_screen_info_proc = Win32API.new("kernel32",
                                      "GetConsoleScreenBufferInfo",
                                      ['L','P'], 'L')

  define_singleton_method(:get_screen_info) do |buffer|
    get_screen_info_proc.call(stdout_handle, buffer)
  end

  # MiniTerm needs to move the cursor about.
  set_cursor_posn_proc = Win32API.new("kernel32",
                                      "SetConsoleCursorPosition",
                                      ['L','L'], 'L')

  define_singleton_method(:set_cursor_posn) do |position|
    set_cursor_posn_proc.call(stdout_handle, position)
  end

  # MiniTerm needs to know if any keystrokes are waiting.
  getch_proc = Win32API.new("msvcrt", "_getch", [], 'I')
  define_singleton_method(:getch) { getch_proc.call.chr }

  # MiniTerm needs to get a single character in raw mode.
  kbhit_proc = Win32API.new("msvcrt", "_kbhit", [], 'I')
  define_singleton_method(:kbhit) { kbhit_proc.call }

  # MiniTerm needs to make some noise.
  beep_proc  = Win32API.new("user32", "MessageBeep", ['L'], '0')
  define_singleton_method(:beep) { beep_proc.call(0); self }

end
