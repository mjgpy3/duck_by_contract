module DuckByContract

  def duck_type(type_hash)
    method_name = type_hash.keys.first
    old_method = instance_method(method_name)
    duck_methods = type_hash.values.first

    define_method method_name do |*args|
      raise NotADuck unless args.first.methods.include?(duck_methods.first)
      old_method.bind(self).call(*args)
    end
  end

  class NotADuck < RuntimeError
  end

end
