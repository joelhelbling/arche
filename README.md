# Arche

A library for Javascript-styled prototypal programming in Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'arche'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arche

## Usage

Create an Arche object:

```ruby
object = Arche::Type.new({ foo: "FOO" })

object[:bar] = "BAR"
object.bar #=> "BAR"
object.foo = "BAZ"
object[:foo] #=> "BAZ"
```

## Todo

* Arche objects should have prototypes (of course!)
* handle scoping of Procs as functions
* handle accessing of functions as values (vs for execution)
* implement .to_h
* add some nifty shorthands (Kernel module?) for low ceremony creating of Arche objects and functions

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
