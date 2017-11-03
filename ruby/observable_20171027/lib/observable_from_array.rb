require_relative 'observable'

class ObservableFromArray < Observable
  def initialize(items)
    @items = items
  end

  def subscribe(observer)
    @items.each { |item| observer.do_on_next(item) }
    observer.do_on_complete
  end
end
