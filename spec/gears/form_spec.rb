require 'helper'
require 'pry'

class ExampleForm < Gears::Form
  field :name, String,  presence: true
  field :age,  Integer
end

describe ExampleForm do
  context 'when unbound' do
    let(:form) { ExampleForm.new }

    it 'is not bound' do
      form.should_not be_bound
    end

    it 'is not valid' do
      form.should_not be_valid
    end

  end

  context 'when bound' do
    let(:form) { ExampleForm.new name: 'James', age: 26 }

    it 'is bound' do
      form.should be_bound
    end

    it 'can be valid' do
      form.should be_valid
    end

    it 'returns bound values' do
      form.name.should == 'James'
    end

    it 'validates name' do
      form.name = ''
      form.should_not be_valid
    end

    it 'coerces age' do
      form.age = '27'
      form.age.should be 27
    end

    it 'fails on uncoercible ages' do
      form.age = 'invalid'
      form.should_not be_valid
    end

    it 'allows uncoerced nils' do
      form.age = nil
      form.should be_valid
    end

    pending 'write tests for `save!` method'
  end
end