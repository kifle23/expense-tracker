require 'rails_helper'

RSpec.describe 'Testing categories views', type: :feature do
  describe 'categories#index' do
    before(:each) do
      user = User.create! name: 'Ruby Guy', email: 'ruby_guy@ruby.com', password: 'pass_123'
      @category = Category.create(name: 'Rails',
                                  icon: 'https://images.unsplash.com/', user_id: user.id)

      visit new_user_session_path
      fill_in 'Email', with: 'ruby_guy@ruby.com'
      fill_in 'Password', with: 'pass_123'
      click_button 'Log in'
      visit categories_path
      click_link 'Rails'
    end

    it 'should have a Rails category' do
      expect(page).to have_content 'Rails'
    end

    it 'should have a Rails category' do
      click_link 'Create a new Record'
      fill_in 'Name', with: 'Compass'
      fill_in 'Amount', with: 360
      click_button 'Create Record'
      expect(page).to have_content 'Compass'
    end
  end
end
