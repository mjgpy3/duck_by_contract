module DuckByContract

  def duck_type(type_hash)
    method_name = type_hash.keys.first
    old_method = instance_method(method_name)

    define_method method_name do |*args|
      raise NotADuck unless args.first.respond_to?(:abs)
      old_method.bind(self).call(*args)
    end
  end

  class NotADuck < RuntimeError
  end

end
