require 'helper'

class ExampleForm < Cave::Form
  field :name, String,  presence: true
  field :age,  Integer
end

describe ExampleForm do
  context 'when unbound' do
    subject { ExampleForm.new }

    it { should_not be_bound }
    it { should_not be_valid }
  end

  context 'when bound' do
    subject { ExampleForm.bind name: 'James', age: 26 }

    it { should be_bound }
    its(:name) { should == 'James' }

    it 'validates name' do
      subject.name = ''
      subject.should_not be_valid
    end

    it 'coerces age' do
      subject.age = '27'
      subject.age.should be 27
    end

    it 'fails on uncoercible ages' do
      subject.age = 'invalid'
      subject.should_not be_valid
    end

    it 'allows uncoerced nils' do
      subject.age = nil
      subject.should be_valid
    end
  end

  context 'when bound with no data' do
    subject { ExampleForm.bind }

    it { should be_bound }
  end

  context 'when valid' do
    subject { ExampleForm.bind name: 'James', age: 26 }

    it { should be_valid }

    it 'has no errors' do
      subject.valid?
      subject.errors.should be_empty
    end

    it 'can be saved' do
      subject.should_receive :persist!
      subject.save!
    end
  end

  context 'when invalid' do
    let(:form) { ExampleForm.bind }

    it 'has errors' do
      subject.valid?
      subject.errors.should be_present
    end

    it 'cannot be saved' do
      subject.save.should be_false
    end

    it 'raises an error when save!d' do
      expect { subject.save! }.to raise_error Cave::ValidationError
    end
  end
end