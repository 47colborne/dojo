class Observable
  def self.empty
    ObservableFromArray.new([])
  end

  def self.just(*items)
    ObservableFromArray.new(items)
  end

  def self.create(source)
    ObservableCreate.new(source)
  end

  def do_on_next(on_next)
    ObservableDoOnEach.new(self, on_next: on_next)
  end

  def do_on_complete(on_complete)
    ObservableDoOnEach.new(self, on_complete: on_complete)
  end

  def do_on_error(on_error)
    ObservableDoOnEach.new(self, on_error: on_error)
  end

  def map(mapper)
    ObservableMap.new(self, mapper)
  end

  def flat_map(mapper)
    ObservableFlatMap.new(self, mapper)
  end

  def subscribe(observer = nil)
    raise NotImplementedError, 'Observable sub-class must implement subscribe'
  end
end

require_relative 'observable_from_array'
require_relative 'observable_create'
require_relative 'observable_do_on_each'
require_relative 'observable_map'
require_relative 'observable_flat_map'
