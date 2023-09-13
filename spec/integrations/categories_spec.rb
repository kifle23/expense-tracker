require 'rails_helper'

describe 'Testing categories views', type: :feature do
  describe 'categories#index' do
    before(:each) do
      user = User.create! name: 'Ruby Guy', email: 'ruby_guy@ruby.com', password: 'pass_123'
      user.categories.create(name: 'Rails', icon: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80')

      visit new_user_session_path
      fill_in 'Email', with: 'ruby_guy@ruby.com'
      fill_in 'Password', with: 'pass_123'
      click_button 'Log in'
      visit categories_path
    end

    it 'should have add categories button' do
      expect(page).to have_content 'Add a new Category'
    end

    it 'should have Rails category' do
      expect(page).to have_content 'Rails'
    end
  end
end
