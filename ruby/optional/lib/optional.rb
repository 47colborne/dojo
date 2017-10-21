class Optional
  def self.of(value)
    raise 'Cant be nil' if value.nil?
    new(value)
  end

  def self.empty
    new(nil)
  end

  def initialize(value)
    @value = value
  end

  def get
    @value
  end

  def present?
    @value != nil
  end

  def if_present
    yield @value if present?
  end

  def map
    Optional.of(yield @value)
  end
end
