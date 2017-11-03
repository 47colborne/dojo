require_relative 'observable'

class ObservableMap < Observable
  def initialize(source, mapper)
    @source = source
    @mapper = mapper
  end

  def subscribe(observer = nil)
    @source.subscribe(MapObserver.new(observer, @mapper))
  end

  class MapObserver
    def initialize(actual, mapper)
      @actual = actual
      @mapper = mapper
    end

    def do_on_next(value)
      @actual.do_on_next(@mapper.call(value))
    rescue => e
      @actual.do_on_error(e)
    end

    def do_on_error(error)
      @actual.do_on_error(error)
    end

    def do_on_complete
      @actual.do_on_complete
    end
  end
end
