class Observable
  def self.empty
    Observable.new
  end

  def self.just(*items)
    Observable.new
  end

  def self.create(source)
  end

  def do_on_next(on_next)
  end

  def do_on_complete(on_complete)
  end

  def do_on_error(on_error)
  end

  def subscribe(observer = nil)
  end
end
