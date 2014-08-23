# duck_by_contract

Duck-typed interfaces for ruby.

## What is it really?

It's a way to ensure that paramters respond to specific messages before heavy-lifting is done in a method.

## How do I use it?

To use it simple have your class extend `DuckByContract` (when the gem is required/installed).

Then call `duck_type` in the body of your class, giving it a hash where the key is the name of the method that you want to explicitely interface and the paramter is an array of arrays of method names (or just an array if the method only accepts parameter).

If you need more info, see the examples below.

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
