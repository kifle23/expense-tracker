require 'rails_helper'

describe User, type: :model do
  it 'should be invalid without an email' do
    user = User.create(name: 'Ruby Guy', email: nil, password: 'pass_123', password_confirmation: 'pass_123')
    expect(user).to_not be_valid
  end
  it 'should be valid' do
    user = User.create(name: 'Ruby Guy', email: 'ruby_guy@ruby.com', password: 'pass_123',
                       password_confirmation: 'pass_123')
    expect(user).to be_valid
  end
end
