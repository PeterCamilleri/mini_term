# coding: utf-8

# Link Ruby to the Windows API calls needed by MiniTerm
module MiniTerm

  # The magic handle number for standard out.
  STD_OUTPUT_HANDLE = -11

  # MiniTerm needs to retrieve standard handles.
  get_handle_proc = Win32API.new("kernel32", "GetStdHandle", ['L'], 'L')

  define_singleton_method(:get_handle) do |handle_index|
    get_handle_proc.call(handle_index)
  end

  @_out_handle = get_handle(STD_OUTPUT_HANDLE)

  # MiniTerm needs to retrieve screen info.
  get_screen_info_proc = Win32API.new("kernel32",
                                      "GetConsoleScreenBufferInfo",
                                      ['L','P'], 'L')

  define_singleton_method(:get_screen_info) do |buffer|
    get_screen_info_proc.call(@_out_handle, buffer)
  end


end
