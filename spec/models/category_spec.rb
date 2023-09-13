require 'rails_helper'

describe Category, type: :model do
  before :each do
    @user = User.create(name: 'Ruby Guy', email: 'ruby_guy@ruby.com', password: 'pass_123',
                        password_confirmation: 'pass_123')
  end
  it 'should be invalid without the icon' do
    category = Category.create(name: 'Ruby Guy', icon: nil, user_id: @user.id)
    expect(category).to_not be_valid
  end
  it 'should be valid' do
    category = Category.create(name: 'Ruby Guy', icon: 'icon', user_id: @user.id)
    expect(category).to be_valid
  end
end
