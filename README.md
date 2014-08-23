# duck_by_contract

Duck-typed interfaces for ruby.

A way to ensure that values passed to methods have expected behaviors.

Basic usage example:
```
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
