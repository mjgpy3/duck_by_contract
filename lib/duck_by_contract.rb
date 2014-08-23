module DuckByContract

  def duck_type(type_hash)
    method_name = type_hash.keys.first
    old_method = instance_method(method_name)
    methods = type_hash.values.first
    methods = [methods] unless methods.first.is_a?(Array)

    define_method method_name do |*args|
      p args
      p methods
      args.zip(methods).each do |value, expected_methods|
        raise NotADuck if Array(expected_methods).any? { |m| !value.methods.include?(m) }
      end
      old_method.bind(self).call(*args)
    end
  end

  class NotADuck < RuntimeError
  end

end
