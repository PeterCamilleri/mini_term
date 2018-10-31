# MiniTerm

The MiniTerm gem is a simple bit of code that seeks to smooth over the bumps
and pot holes encountered when interacting with the console terminal to create
console based CLI applications. More than most it seeks to eliminate worries
about the nasty cross-platform issues encountered between Windows, Linux, and
MAC OSX systems.

This code started out its life buried deep within the code of the mini readline
gem where it helped that gem do its job. A while ago it was realized that the
services provided where invaluable for a much wider range of development. I was
increasingly frustrated by my need to "go-around" mini readline to get at some
of its lower level features. When that happens it is a clear sign that a gem is
doing too much and has too many responsibilities.

That's why the low level terminal functionality was split out into the mini
term gem contained in this code repository. At the same time, the lessons
learned from the earlier version of the code have been applied to make this
code better and also not any more incompatible than needed. Since mini readline
was the only "user" of the old code, moving out in some new directions should
not pose a migration issue except for me.

WIP

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

WIP

#### Exceptions:

The mini term gem uses the following exception classes:

    Exception              # From Ruby.
      StandardError        # From Ruby.
        MiniTermError      # The abstract base exception for mini term.
          MiniTermWTF      # An internal error happened. This shouldn't happen.
          MiniTermNoMap    # No map can be found for the current terminal type.
          MiniTermKME      # A keyboard mapping error was detected.

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
