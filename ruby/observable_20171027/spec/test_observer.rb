class TestObserver
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

  def has_error?(error)
    @errors.include?(error)
  end
end
