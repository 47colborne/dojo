class TestObserver
  attr_reader :values, :errors

  def initialize
    @values = []
    @errors = []
    @complete = false
  end

  def do_on_next(value)
    @values << value
  end

  def do_on_complete
    @complete = true
  end

  def do_on_error(error)
    @errors << error
  end

  def empty?
    @values.empty?
  end

  def complete?
    @complete
  end

  def has_values?(*values)
    @values == values
  end

  def has_error?(error_class)
    @errors.any? { |error| error.class == error_class }
  end

  def expect_to_have_values(*values)
    raise "Expected values #{values.inspect}, actual: #{to_s}" unless has_values?(*values)
  end

  def to_s
    "[values: #{@values.inspect}, errors: #{@errors.inspect}, complete: #{@complete}]"
  end
end
