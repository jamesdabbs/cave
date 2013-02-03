require 'helper'

class Confirmation < Cave::Form
  field :password, String,  presence: true, confirmation: true
  field :optional, Integer, confirmation: true
end

describe 'Field options - ' do
  context 'confirmation' do
    subject { Confirmation.bind password: '1234' }

    it 'requires the confirmation field' do
      subject.should_not be_valid
      subject.errors.messages.keys.should include :password_confirmation
    end

    it 'checks the confirmation field' do
      subject.bind password_confirmation: '1324'
      subject.should_not be_valid
      subject.errors.messages.keys.should include :password
    end

    it 'respects optional fields' do
      subject.bind password_confirmation: '1234'
      subject.should be_valid
    end
  end
end