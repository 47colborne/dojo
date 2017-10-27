require 'spec_helper.rb'
require_relative 'test_observer.rb'

describe Observable do
  let(:test_observer) { TestObserver.new }

  describe '.empty' do
    it 'emits nothing then completes' do
      Observable.empty
          .subscribe(test_observer)

      expect(test_observer).to be_empty
      expect(test_observer).to be_complete
    end
  end

  describe '.just' do
    it 'emits the given items then completes' do
      Observable.just(1, 2, 3)
          .subscribe(test_observer)

      expect(test_observer).to have_values(1, 2, 3)
      expect(test_observer).to be_complete
    end
  end

  describe '.create' do
    it 'returns an observable that can emit values' do
      source = Proc.new do |emitter|
        3.times { |n| emitter.on_next(n + 1) }
        emitter.on_complete
      end

      Observable.create(source)
          .subscribe(test_observer)

      expect(test_observer).to have_values(1, 2, 3)
      expect(test_observer).to be_complete
    end
  end

  describe '#do_on_next' do
    it 'is called for each value emitted' do
      service = double(:service, do_something: nil)
      expect(service).to receive(:do_something).once.ordered.with(1)
      expect(service).to receive(:do_something).once.ordered.with(2)
      expect(service).to receive(:do_something).once.ordered.with(3)

      Observable.just(1, 2, 3)
          .do_on_next(->(n) { service.do_something(n) })
          .subscribe
    end
  end
end
