require 'helper'

class Profile
end

class ExampleModelForm < Gears::ModelForm
  model Profile
end

describe ExampleModelForm do

  context 'new instance' do
    let(:form) { ExampleModelForm.new name: 'James' }
  end

  context 'existing instance' do
    let(:instance) { Profile.new name: 'James' }
    let(:form) { ExampleModelForm.new instance, name: 'Jim' }
  end

  pending 'write ModelForm specs'
end