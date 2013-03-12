require 'helper'
require 'pry'

class MetaForm < Cave::Form
  field :nick, String, 
    label:   'Nickname', 
    help:    'Please enter your nickname', 
    presence: true
end

describe Cave::Form::Builder do
  pending

  it 'renders field metadata' do
  end

  it 'renders errors' do
  end
end