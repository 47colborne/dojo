require 'pry'

class OpenestStruct < Object

  def initialize(args = {})
    @data = args
    initialize_methods
  end

  def method_missing(symbol, *args, &block)
    if is_setter?(symbol)
      getter = symbol.to_s[0..-2].to_sym
      define_getter(getter)
      define_setter(symbol, args[0])
    end
  end

  def is_setter? symbol
    symbol.to_s[-1] == "="
  end

  private

  def initialize_methods
    @data.each do |key, value|

      define_getter(key)

      setter_name = key.to_s + '='
      define_setter(setter_name)

    end
  end

  def define_getter(symbol)
    define_singleton_method(symbol) { @data[symbol] }
  end

  def define_setter(symbol, default_value = nil)
    key = symbol[0..-2].to_sym
    define_singleton_method(symbol) { |value| @data[key] = value }
    @data[key] = default_value if default_value
  end

end