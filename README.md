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
```

And access its data members (the way you can with Javascript):

```ruby
object[:bar] = "BAR"
object.bar #=> "BAR"
object.foo = "BAZ"
object[:foo] #=> "BAZ"
```

And data members which happen to be Arche::Functions can be both 
accessed and invoked!

```ruby
object.funky = Arche::Function.new { 4 + 7 }
object.funky.class #=> Arche::Function
object.funky! #=> 11
```

## Todo

* Arche objects should have prototypes (of course!)
* implement #to_h (and #from_h...?)
* add some nifty shorthands (Kernel module?) for low ceremony creating of Arche objects and functions

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
