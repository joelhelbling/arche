require 'arche/primitives'

describe 'Arche::Primitives' do
  include Arche::Primitives

  describe '.isNaN' do
    context 'integer' do
      subject { 12 }
      specify { isNaN(subject).should == false }
    end
    context 'float' do
      subject { 1.5 }
      specify { isNaN(subject).should == false }
    end
    context 'string with only numbers' do
      subject { "123" }
      specify { isNaN(subject).should == false }
    end
    context 'string with mixed numbers and others' do
      subject { "100,000" }
      specify { isNaN(subject).should == true }
    end
    context 'strings of floats' do
      subject { "1.2" }
      specify { isNaN(subject).should == true }
    end
    context 'anything else' do
      subject { { foo: "bar" } }
      specify { isNaN(subject).should == true }
    end
  end

end

