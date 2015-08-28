require 'spec_helper.rb'

describe OpenestStruct do

  let(:model) { OpenestStruct.new }

  describe '#initialize' do
    it 'should define all the methods passed in with the arguments' do
      subject = OpenestStruct.new(first_name: "Scott")
      expect(subject.methods(false)).to include(:first_name, :first_name=)
    end
  end

  it 'should initalize a method with proc passed in' do
      model.sum = -> (value1, value2) { value1 + value2 }
      expect(model.sum(1, 10)).to eq(11)
  end

  it 'should be able to write to any attribute' do
    model.title = "Yroo Struct"
    expect(model.title).to eq("Yroo Struct")
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

  it 'should define the writer explicitly' do
    model.title = "Yroo Struct"
    expect(model.methods(false)).to include(:title=)
  end

  describe '#is_setter?' do
    it 'should be able to tell if the missing method is a setter' do
      expect(model.is_setter?(:title=)).to be_truthy
    end

    it 'should be able to tell if the missing method is not a setter' do
      expect(model.is_setter?(:title)).to be_falsey
    end
  end

end