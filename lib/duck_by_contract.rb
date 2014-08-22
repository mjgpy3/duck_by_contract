module DuckByContract

  def duck_type(type_hash)
    method_name = type_hash.keys.first
    old_method = instance_method(method_name)
    duck_methods = type_hash.values.first

    define_method method_name do |*args|
      raise NotADuck if duck_methods.any? { |m| !args.first.methods.include?(m) }
      old_method.bind(self).call(*args)
    end
  end

  class NotADuck < RuntimeError
  end

end
