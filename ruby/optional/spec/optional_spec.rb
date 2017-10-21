require 'spec_helper.rb'

describe Optional do
  describe '.of' do
    context 'when value is not nil' do
      it 'should return an optional wrapping the value given' do
        optional = Optional.of(1)
        expect(optional.get).to eq(1)
      end
    end

    context 'when value is nil' do
      it 'should raise an exception' do
        expect { Optional.of(nil) }.to raise_error(RuntimeError)
      end
    end
  end

  describe '.empty' do

  end

  describe '#get' do
    context 'when empty' do
      it 'should return nil' do
        expect(Optional.empty.get).to be_nil
      end
    end

    context 'when not empty' do
      it 'should return the value' do
        value = 1
        expect(Optional.of(value).get).to eq(value)
      end
    end
  end

  describe '#present?' do
    context 'when empty' do
      it 'should return false' do
        expect(Optional.empty.present?).to eq(false)
      end
    end

    context 'when not empty' do
      it 'should return the true' do
        value = 1
        expect(Optional.of(value).present?).to eq(true)
      end
    end
  end

  describe '#if_present' do
    context 'when empty' do
      it 'should not run the provided code' do
        number = 0
        Optional.empty.if_present { number + 1 }
        expect(number).to eq(0)
      end
    end

    context 'when not empty' do
      it 'should run the provided code and return a value' do
        service = double('Service', run: nil, stop: 2)
        expect(service).to receive(:run).with(1)
        Optional.of(1).if_present { |x| service.run(x) }
      end
    end
  end

  describe '#map' do
    it 'should return an optional if the optional present' do
      returned = Optional.of(1).map{ |x| x.to_s }
      expect(returned.class).to eq(Optional)
      expect(returned.get).to eq('1')
    end
  end
end
