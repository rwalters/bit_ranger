# BitRanger

Lightweight gem to facilitate using an integer field for tracking boolean settings or feature flags.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bit_ranger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bit_ranger

## Usage

Any object that has a `settings` and `settings=` methods can be passed into `BitRanger`. There is no `update` or SQL related functionality, so any saving to a database is up to the user.

### _toggle(object, flag)_

`BitRanger.toggle(user, <flag>)` will toggle that flag's value between true and false.

### _enable(object, flag)_ (idempotent)

`BitRanger.enable(user, <flag>)` will set that flag's value to true.

### _disable(object, flag)_ (idempotent)

`BitRanger.disable(user, <flag>)` will set that flag's value to false.

### _list(object)_ (idempotent)

`BitRanger.list(user)` will list the enabled flags for a user.

### _settings_ (idempotent)

`BitRanger.settings` will list all possible flags and the bits where they are stored.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rwalters/bit_ranger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BitRanger project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rwalters/bit_ranger/blob/master/CODE_OF_CONDUCT.md).
