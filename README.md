# MiniTerm

The MiniTerm gem is a simple bit of code that seeks to smooth over the bumps
and pot holes encountered when interacting with the console terminal to create
console based CLI applications. This code started out buried deep within the
MiniReadline gem where it helped that gem do its job. A while ago it was
realized that the services provided where invaluable for a much wider range of
development.

That's why this functionality was split out into the mini term gem contained in
this code repository.

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
