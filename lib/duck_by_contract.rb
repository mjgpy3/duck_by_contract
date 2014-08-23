module DuckByContract

  def duck_type(type_hash)
    duck_type_with_default(type_hash) do
      raise NotADuck
    end
  end

  def duck_type_with_default(type_hash)
    method_name = type_hash.keys.first
    old_method = instance_method(method_name)
    methods = type_hash.values.first
    methods = [methods] unless methods.first.is_a?(Array)

    define_method method_name do |*args|
      args.zip(methods).each do |value, expected_methods|
        return yield(*args) if Array(expected_methods).any? { |m| !value.methods.include?(m) }
      end
      old_method.bind(self).call(*args)
    end
  end

  class NotADuck < RuntimeError
  end

end
