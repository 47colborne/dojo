require 'pry'

class OpenestStruct < Object

  def initialize(args = {})
    @data = args
    __initialize_methods
  end

  def method_missing(symbol, *args, &block)
    if __is_setter?(symbol)
      getter = symbol.to_s[0..-2].to_sym
      @data[getter] = args[0]
      __define_getter(getter, args[0])
      __define_setter(symbol)
    end
  end

  def __is_setter? symbol
    symbol.to_s[-1] == "="
  end

  private

  def __initialize_methods
    @data.each do |key, value|
      __define_getter(key, value)
      setter_name = key.to_s + '='
      __define_setter(setter_name)

    end
  end

  def __define_getter(symbol, value)
    block = value.is_a?(Proc) ? value : -> { @data[symbol] }
    define_singleton_method(symbol, &block)
  end

  def __define_setter(symbol)
    key = symbol[0..-2].to_sym
    define_singleton_method(symbol) do |value|
      __define_getter(key, value)
      @data[key] = value
    end
  end

end
