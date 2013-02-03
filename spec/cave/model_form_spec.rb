require 'helper'

class Profile < OpenStruct
  def create! attrs; end
  def update_attributes attrs; end
end

class ExampleModelForm < Cave::ModelForm
  model Profile

  field :name, String
end

describe ExampleModelForm do

  it 'checks instance against model' do
    expect { ExampleModelForm.new 1 }.to raise_error TypeError
  end

  context 'when new' do
    subject { ExampleModelForm.new name: 'James' }

    it 'creates' do
      Profile.should_receive :create!
      subject.save!
    end
  end

  context 'pre-existing' do
    let(:instance) { Profile.new name: 'James' }
    subject { ExampleModelForm.new instance, name: 'Jim' }

    it 'updates' do
      instance.should_receive(:update_attributes).with(name: 'Jim')
      subject.save!
    end

    it 'does not create' do
      Profile.should_not_receive :create!
      subject.save!
    end
  end

end