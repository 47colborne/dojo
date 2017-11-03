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

      test_observer.expect_to_have_values(1, 2, 3)
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

      test_observer.expect_to_have_values(1, 2, 3)
      expect(test_observer).to be_complete
    end

    it 'returns an observable that can emit values asynchronously' do
      source_thread = nil

      source = Proc.new do |emitter|
        source_thread = Thread.start do
          threads = []

          3.times do |n|
            threads << Thread.start { emitter.on_next(n + 1) }
          end

          threads.each { |t| t.join } # wait until all values have been emitted
          emitter.on_complete
        end
      end

      Observable.create(source)
          .subscribe(test_observer)

      source_thread.join
      expect(test_observer.values).to contain_exactly(1, 2, 3)
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

  describe '#do_on_complete' do
    it 'is called when complete' do
      service = double(:service, do_something: nil)
      expect(service).to receive(:do_something).with(1)
      expect(service).to receive(:do_something).with(2)

      Observable.just(1, 2, 3)
          .do_on_complete(-> { service.do_something(1) })
          .do_on_complete(-> { service.do_something(2) })
          .subscribe
    end
  end

  describe '#do_on_error' do
    it 'is called when error occurs' do
      source = Proc.new do |emitter|
        begin
          x = 1 / 0
          emitter.on_next(x)
          emitter.on_complete
        rescue => e
          emitter.on_error(e)
        end
      end

      service = double(:service, do_something: nil)
      expect(service).to receive(:do_something).twice.with(an_instance_of(ZeroDivisionError))

      Observable.create(source)
          .do_on_error(->(e) { service.do_something(e) })
          .do_on_error(->(e) { service.do_something(e) })
          .subscribe
    end
  end

  describe '#subscribe' do
    it 'can subscribe an observer' do
      Observable.just(1)
          .subscribe(test_observer)

      expect(test_observer).to have_values(1)
      expect(test_observer).to be_complete
    end

    it 'can subscribe with callbacks' do
      i = 1
      Observable.just(1)
          .do_on_next(->(n) { i += n })
          .do_on_complete(-> { i += 10 })
          .subscribe

      expect(i).to eq(12)
    end

    it 'can subscribe with callbacks and an observer' do
      i = 1
      Observable.just(1)
          .do_on_next(->(n) { i += n })
          .do_on_complete(-> { i += 10 })
          .subscribe(test_observer)

      expect(i).to eq(12)
      expect(test_observer).to have_values(1)
    end
  end

  describe '#map' do
    it 'applies a function to observed values' do
      Observable.just(1, 2, 3)
          .map(->(n) { n * 2 })
          .map(->(n) { n + 1 })
          .subscribe(test_observer)

      test_observer.expect_to_have_values(3, 5, 7)
      expect(test_observer).to be_complete
    end

    it 'emits error raised by mapper' do
      Observable.just(1, 2, 3)
          .map(->(n) { n / 0 })
          .subscribe(test_observer)

      expect(test_observer).to have_error(ZeroDivisionError)
      expect(test_observer).to be_complete
    end
  end

  describe '#flat_map' do
    it 'applies a function to observed values that returns an observable and merges it' do
      Observable.just(1, 3, 5)
          .flat_map(->(n) { Observable.just(n, n + 1) })
          .subscribe(test_observer)

      test_observer.expect_to_have_values(1, 2, 3, 4, 5, 6)
    end
  end
end
