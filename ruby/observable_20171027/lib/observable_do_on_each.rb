class ObservableDoOnEach < Observable
  EMPTY_ON_NEXT = ->(_v) {}
  EMPTY_ON_ERROR = ->(_e) {}
  EMPTY_ON_COMPLETE = ->() {}

  def initialize(source, on_next: EMPTY_ON_NEXT, on_error: EMPTY_ON_ERROR, on_complete: EMPTY_ON_COMPLETE)
    @source = source
    @on_next = on_next
    @on_error = on_error
    @on_complete = on_complete
  end

  def subscribe(actual = nil)
    @source.subscribe(DoOnEachObserver.new(actual, @on_next, @on_error, @on_complete))
  end

  class DoOnEachObserver
    def initialize(actual, on_next, on_error, on_complete)
      @actual = actual
      @on_next = on_next
      @on_error = on_error
      @on_complete = on_complete
    end

    def do_on_next(value)
      @on_next.call(value)
      @actual.do_on_next(value) if @actual
    end

    def do_on_error(error)
      @on_error.call(error)
      @actual.do_on_error(error) if @actual
    end

    def do_on_complete
      @on_complete.call
      @actual.do_on_complete if @actual
    end
  end
end
