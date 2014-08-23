# duck_by_contract

[![Build Status](https://travis-ci.org/mjgpy3/duck_by_contract.svg?branch=master)](https://travis-ci.org/mjgpy3/duck_by_contract)

Duck-typed interfaces for ruby.

## What is it really?

It's a way to ensure that paramters respond to specific messages before heavy-lifting is done in a method.

## Why add the overhead?

2 reasons really:
 1. Some methods have a lot of heavy-lifting (e.g. database/network transactions). Sometimes these transactions can go through then be "broker" because a later statement calls a method that does not exist. This is a short circuit mechanism.
 2. Timid code (i.e. code including a lot of `#is_a?`, `#respond_to?`, `#nil?`, etc...) is ugly and causes methods to become bloated. This gem provides a way to ensure parameters have expected behaviors _without_ convolution, and it also provides a mechanism (`duck_type_with_default`) to provide default behavior when interface parameters are not met.

## How do I use it?

To use it simply have your class extend `DuckByContract` (when the gem is required/installed).

Then call `duck_type` in the body of your class, giving it a hash where the key is the name of the method that you want to explicitly interface and the parameter is an array of arrays of method names (or just an array if the method only accepts parameter).

The `duck_type_with_default` method can also be used to provide a block specifying how a method ought to behave if parameter's duck-types do not align

If you need more info, see the examples below.

## Default behavior example:
```
require 'duck_by_contract'

class Persistor
  extend DuckByContract

  def persist(readable, db)
    db.save(readable.read)
  end

  duck_type_with_default persist: [
    [:read], [:save]
  ] do |maybe_readable, maybe_db|
    raise "#{maybe_readable.inspect} or #{maybe_db.inspect} failed to meet its contract in #persist"
  end
end

saver = Persistor.new
saver.persist("42", Object.new)
# => RuntimeError: 42 or #<Object:0x92d5ad8> failed to meet it's contract in #persist
```

## Basic usage example:
```
require 'duck_by_contract'

class Horse
  extend DuckByContract

  def speak
    puts 'Nay!'
  end

  def speak_with_other(vocal_thing)
    puts 'I say:'
    speak
    puts 'Other says:'
    vocal_thing.speak
  end

  duck_type speak_with_other: [:speak]

end

class Cup; end

class Duck

  def speak
    puts "Quack!"
  end

end

ed = Horse.new
ugly = Duck.new
pint = Cup.new

ed.speak_with_other(ugly)
# =>
# I say:
# Nay!
# Other says:
# Quack!

ed.speak_with_other(pint)
# => Raises "DuckByContract::NotADuck"
```
