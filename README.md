# MiniTerm

The MiniTerm gem is a simple bit of code that seeks to smooth over the bumps
and pot holes encountered when interacting with the console terminal to create
console based CLI applications. More than most it also seeks to eliminate
worries about the nasty cross-platform issues encountered between Windows,
Linux, and MAC OS-X systems.

This code started out its life buried deep within the code of the mini readline
gem where it helped that gem do its job. A while ago it was realized that the
services provided were invaluable for a much wider range of development. I was
increasingly frustrated by my need to "go-around" mini readline to get at some
of its lower level features. When that happens it is a clear sign that a gem is
doing too much and has too many responsibilities.

That's why the low level terminal functionality was split out into the mini
term gem contained in this code repository. At the same time, the lessons
learned from the earlier version of the code have been applied to make this
code better and also not any more incompatible than needed. Since mini readline
was the only "user" of the old code, moving out in some new directions should
not pose a migration issue except for me.

Finally, this gem would not be possible without the excellent insight into the
gnarly world of win_32_api, dl, and fiddle I gained reading and copying the
code in the [ConnorAtherton/rb-readline](https://github.com/ConnorAtherton/rb-readline)
project and gem. *Thank You!*

So, what hurdles do we expect the mini term gem to overcome? What cross-platform
issues vex us? After all, it's not as if Ruby ignores the issue of low-level
console access. It has the io/console and io/wait code libraries. They are
supposed to give low level access right?

And this is the point where the wheels start falling off.

* The io/console library has truly awful documentation. Many methods lack any
sort of description or meaningful parameter names. The developer is left to
reverse engineering the behavior of the code. The programming process borders
on the tribal. In this regard, io/wait is OK. Too bad it only plays a limited
role.

* The io/console library does not work correctly under Windows. And before we
hear a chorus of "Switch to Linux", the anti-windows squad are reminded that
this is a cross-platform tool, just like Ruby is supposed to be. The issue is
that raw mode is not so raw under windows. In fact it's so cooked that it more
resembles a chunk of charcoal! It just plain does not work. Fortunately there
is an answer. Ruby has access to the various APIs though the 'fiddle' gem.
This gem is used to emulate the deprecated 'win32api' gem.

* Under JRuby, the situation is even worse. The io/console facility is
incapable of manipulating the tty or console at all. A true non-starter. Only
here's where things take a twist for the weird. Under Windows, JRuby *does*
support the 'win32api' gem. It even works! I'm not at all sure how to support
JRuby under Linux or Mac OS-X.

* Working with Rubinius is perhaps the worst of all. Rubinius *still* does not
run under Windows. Until such time as I am able to develop under a supported
platform, or can collaborate with someone who can, this is a non-starter. Don't
stay tuned, don't hold your breath; This problem is *not* going away any time
soon.

#### So! What do we have?

This is a matrix of language versions and environments that have are tested or
have been tested at one time or another.

Ruby           | Win32   | Win64   | Cygwin  | Linux   | Mac
---------------|---------|---------|---------|---------|---------
ruby 2.1.6p336 | Yes?    | Yes??   | Yes??   | Yes??   | Yes??
ruby 2.2.3p173 | Yes??   | Yes??   | Yes?    | Yes??   | Yes??
ruby 2.3.3p222 | Yes??   | Yes     | Yes??   | Yes??   | Yes??
jruby 9.1.5.0  | Yes?    | Yes??   | Maybe?  | Maybe?  | Maybe?

This table will be updated as more information becomes available. Check the
[github  repository](https://github.com/PeterCamilleri/mini_term) for the
latest info.

Notes:
* Mini term uses keyword parameters so Ruby 2.0 or later is required. This is
why older versions of Ruby have been removed from this table.
* Yes? means that this combination was once tested with very similar code and
should be OK, we hope. Testing would be nice.
* Yes?? means that this combination *should* work but needs testing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mini_term'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mini_term

## Usage

The mini term can be used in a project with:

```ruby
require 'mini_term'
```

### Interface Summary

The following is a brief summary of the public interface of the MiniTerm module:

**Constants**

    VERSION       -- A version string of the form "9.9.9"
    DESCRIPTION   -- A descriptive string.
    VALID_OPTIONS -- An array of the supported option symbols.
    TERM_TYPE     -- Either :windows or :ansi
    TERM_PLATFORM -- One of :windows, :cygwin, :macosx, :linux, or :unix

**Methods**

    open(options), close, open?
    term_info, width, height, ansi?, windows?, java?
    set_posn(row: the_current_row, column:)
    raw {}, raw?, begin_raw_input, end_raw_input
    get_raw_char, has_raw_char? flush
    get_mapped_char, add_map(type) {}, map_types
    print(text), clear_screen


*MiniTerm.open* - Before it can be used, the mini term should be opened. This
is done with:

```ruby
MiniTerm.open(options)
```

The open method can take some optional arguments:

    pass_ctrl_c: true   # The control+c character is passed through to the application.
    pass_ctrl_c: false  # (Default) The control+c character is used by the OS.

    pass_ctrl_s: true   # The control+s character is passed through to the application.
    pass_ctrl_s: false  # (Default) The control+s character is used by the OS.

    quiet: true         # Suppress various warning messages.
    quiet: false        # (Default) Display warning message.

    strict: true        # Invalid options raise an exception.
    strict: false       # (Default) Invalid options cause no such fuss.


If an unsupported or invalid option is detected, a warning message is displayed
unless the quiet option is active. Alternatively, if the strict option is
enabled, the MiniTermStrict exception is raised in that case.

*MiniTerm.close* - The converse to open is close. It takes no arguments.

```ruby
MiniTerm.close
```

Rest assured that if your program should forget to close MiniTerm, the gem will
close itself automatically when your program exits. This ensures that the
terminal will not be left in a unworkable state. It will also tell you that it
had to "Force MiniTerm.close" unless it was opened with the quiet: true option.

*MiniTerm.terminfo, etc* - These methods return information about the current
MiniTerm operating environment.

```ruby
MiniTerm.terminfo   # Returns the console's number of [rows, columns]
MiniTerm.width      # Returns the console's number of columns.
MiniTerm.height     # Returns the console's number of rows.
MiniTerm.ansi?      # Is ANSI mode active?
MiniTerm.windows?   # Is Windows mode active?
MiniTerm.java?      # Is Java active?
```

*MiniTerm.set_posn* - This method is used to place the cursor anywhere on the
screen or anywhere in the current line.

```ruby
set_posn(row: the_current_row, column:)
```
Note: If the row parameter is omitted, the row remains on the current row. The
column parameter is always required.

*MiniTerm.raw, etc* - These methods controll the use of raw console input, one
of the major features provided by the MiniTerm gem. These methods are:

```ruby
MiniTerm.raw {|self|  }   # Execute the block with raw mode active.
MiniTerm.raw?             # Is raw mode active now?
```

*MiniTerm.get_raw_char, etc* - These methods deal with the keyboard in a raw
mode. They do not echo or wait for the user to press enter or any of those
other cooked mode things. Keyboard data in the raw!

```ruby
MiniTerm.get_raw_char     # Wait for a keystroke in raw mode.
MiniTerm.has_raw_char?    # Are there any keys waiting?
MiniTerm.flush            # Flush any keys in the buffer.
```

Note that the get_raw_char method needs to be run with raw mode in effect. See
the raw methods above for more on that. Also, in raw mode, some keys, especially
extended keys may be composed of more than one byte. These methods only return
one byte at a time.

*MiniTerm.get_mapped_char, etc* - A mapped character is one or more raw
characters that are mapped to an array containing a symbol and the characters
that pathed the mapping to that sysmbol. For example:

```ruby
[:go_left, "\e[D"]
```

The conversion process from a stream of raw bytes to commands is done with a
map. The method MiniTerm.add_map(type) {} takes one argument, the type, and a
block. The type is currently one of the two terminal types: :windows or :ansi.
The block also takes one argument, the newly created map. The code can then
define entries in the map as follows:

```ruby
MiniTerm.add_map(:ansi) do |map|
  map["\e[D"] = :go_left
  # etc etc etc
end
```

Now, the index for each entry represents a sort of path to the command. This
path must not be ambiguous. For example, the following will generate an error:

```ruby
MiniTerm.add_map(:ansi) do |map|
  map["\e"]   = :cancel
  map["\e[D"] = :go_left
  # etc etc etc
end
```

To understand this, imagine that this map were allowed. The user presses the
left arrow key. This generates the sequence "\e[D". The "\e" is received first
and mapped to a :cancel command by the first rule. Then the "[D" characters are
received and most likely inserted as these are printable characters. That is
not what is wanted because the left arrow key was mapped to the wrong actions.
This map is ambiguous mapping error is why MiniTerm signals a MiniTermKME error
when the map is created.

The method MiniTerm.map_types list the types for key maps that have been added.
In most cases this will be [:ansi, :windows]. A map should be defined for each
of the two term types, unless the application is only intended for one type.

#### Exceptions:

The mini term gem uses the following exception classes:

    Exception              # From Ruby.
      StandardError        # From Ruby.
        MiniTermError      # The abstract base exception for mini term.
          MiniTermKME      # A keyboard mapping error was detected.
          MiniTermNoMap    # No map can be found for the current terminal type.
          MiniTermNotRaw   # Raw mode is required for this operation.
          MiniTermStrict   # An exception raised due to strictness.
          MiniTermWTF      # An internal error happened. This shouldn't happen.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

OR...

* Make a suggestion by raising an
 [issue](https://github.com/PeterCamilleri/mini_term/issues)
. All ideas and comments are welcome.

## License

The gem is available as open source under the terms of the
[MIT License](./LICENSE.txt).

## Code of Conduct

Everyone interacting in the mini_term project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](./CODE_OF_CONDUCT.md).
