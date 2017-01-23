# Yoxruby
A Simple Yo(https://www.justyo.co/) API wrapper.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yoxruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yoxruby

## Usage

### get API_TOKEN & ACCESS_TOKEN

API_TOKEN: https://dashboard.justyo.co/
click "View API key"

ACCESS_TOKEN: https://accesstoken.justyo.co/

### send yo
```
require "yoxruby"

client = Yoxruby::Client(API_TOKEN,ACCESS_TOKEN) #API_TOKEN is necessary

client.yo(username)
```

### get unread yo
```
require "yoxruby"

client = Yoxruby::Client(API_TOKEN,ACCESS_TOKEN) #ACCESS_TOKEN is necessary

client.unread
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/horoama/yoxruby.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

