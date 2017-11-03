class CreateEmitter
  def initialize(observer)
    @observer = observer
  end

  def on_next(value)
    @observer.do_on_next(value)
  end

  def on_error(e)
    @observer.do_on_error(e)
  end

  def on_complete
    @observer.do_on_complete
  end
end
