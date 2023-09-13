require 'rails_helper'

describe Category, type: :model do
  before :each do
    @user = User.create(name: 'Ruby Guy', email: 'ruby_guy@ruby.com', password: 'pass_123', password_confirmation: 'pass_123')
  end
  it 'should be valid' do
    category = Record.create(name: 'Ruby Guy', amount: 5, user_id: @user.id)
    expect(category).to be_valid
  end
  it 'should not be valid if amount is less than 1' do
    category = Record.create(name: 'Ruby Guy', amount: 0, user_id: @user.id)
    expect(category).to_not be_valid
  end
end
