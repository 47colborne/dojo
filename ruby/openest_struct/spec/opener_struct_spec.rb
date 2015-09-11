require 'spec_helper.rb'

describe OpenestStruct do

  let(:model) { OpenestStruct.new }

  describe '#initialize' do
    it 'should define all the methods passed in with the arguments' do
      subject = OpenestStruct.new(first_name: "Scott")
      expect(subject.methods(false)).to include(:first_name, :first_name=)
    end
  end

  describe '#define_getter' do
    it 'should initalize a method with proc passed in' do
      model.sum = -> (value1, value2) { value1 + value2 }
      expect(model.sum(1, 10)).to eq(11)
    end

    it 'should re-defined the attribute getter' do
      subject.sum = 47
      subject.sum = -> (value1, value2) { value1 + value2 }
      expect(subject.sum(1, 9)).to eq(10)
      subject.sum = 47
      expect(subject.sum).to eq(47)
    end
    it 'should never raise method_missing for a getter' do
      expect{model.title}.to_not raise_error
    end

    it 'should return nil when attribute is not set' do
      expect(model.title).to be nil
    end

    it 'should define the reader as an explicit method' do
      model.title = "Yroo Struct"
      expect(model.methods(false)).to include(:title)
    end
  end

  describe '#is_setter?' do
    it 'should define the writer explicitly' do
      model.title = "Yroo Struct"
      expect(model.methods(false)).to include(:title=)
    end
    it 'should be able to write to any attribute' do
      model.title = "Yroo Struct"
      expect(model.title).to eq("Yroo Struct")
    end
    it 'should be able to tell if the missing method is a setter' do
      expect(model.__is_setter?(:title=)).to be_truthy
    end

    it 'should be able to tell if the missing method is not a setter' do
      expect(model.__is_setter?(:title)).to be_falsey
    end
  end

  it 'should be able to access other attribute' do
    subject.first_name = "Scott"
    subject.last_name = "Chu"
    subject.full_name = -> { first_name + " " + last_name }
    expect(subject.full_name).to eq('Scott Chu')
  end

  it 'should be able to call other methods' do
    subject.sum = -> (value1, value2) { value1 + value2 }
    subject.sum_plus_one = -> (value1, value2) {sum(value1, value2) + 1 }
    expect(subject.sum_plus_one(1,1)).to eq(3)
  end

  it 'should allow the setting of any attribute name' do
    subject.define_setter = 1
    expect(subject.define_setter).to eq(1)
  end
end

