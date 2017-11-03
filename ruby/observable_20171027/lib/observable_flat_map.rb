require_relative 'observable'

class ObservableFlatMap < Observable
  def initialize(source, mapper)
    @source = source
    @mapper = mapper
  end

  def subscribe(observer = nil)
    @source.subscribe(FlatMapObserver.new(observer, @mapper))
  end

  class FlatMapObserver
    def initialize(actual, mapper)
      @actual = actual
      @mapper = mapper
    end

    def do_on_next(value)
      o = @mapper.call(value)
      o.subscribe(InnerObserver.new(@actual))
    end

    def do_on_error(error)
      @actual.do_on_error(error)
    end

    def do_on_complete
      @actual.do_on_complete
    end

    class InnerObserver
      def initialize(actual)
        @actual = actual
      end

      def do_on_next(value)
        @actual.do_on_next(value)
      end

      def do_on_complete
        @actual.do_on_complete
      end
    end
  end
end
