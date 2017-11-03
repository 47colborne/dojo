require_relative 'observable'
require_relative 'create_emitter'

class ObservableCreate < Observable
  def initialize(source)
    @source = source
  end

  def subscribe(observer)
    emitter = CreateEmitter.new(observer)
    @source.call(emitter)
  end
end
