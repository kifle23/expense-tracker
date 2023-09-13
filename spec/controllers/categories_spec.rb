require 'rails_helper'

describe CategoriesController, type: :controller do
  let(:user) { double('User') }
  let(:category) { double('Category') }

  before do
    allow(controller).to receive(:authenticate_user!)
    allow(controller).to receive(:current_user).and_return(user)
    allow(Category).to receive(:find).and_return(category)
  end

  describe 'GET #index' do
    context 'when the user is signed in' do
      before do
        allow(user).to receive(:categories).and_return([category])
      end

      it 'assigns the user categories to @categories' do
        get :index
        expect(assigns(:categories)).to eq([category])
      end
    end

    context 'when the user is not signed in' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(false)
      end

      it 'renders the splash template' do
        get :index
        expect(response).to render_template('splash')
      end
    end
  end

  describe 'GET #new' do
    it 'assigns a new category to @category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'POST #create' do
    let(:category_params) { { name: 'Vegetables' } }

    before do
      allow(user).to receive_message_chain(:categories, :new).and_return(category)
      allow(category).to receive(:save).and_return(save_result)
    end

    context 'when the category fails to save' do
      let(:save_result) { false }
      let(:error_message) { 'Name is required' }

      before do
        allow(category).to receive_message_chain(:errors, :full_messages).and_return([error_message])
      end

      it 'renders the new template' do
        post :create, params: { category: category_params }
        expect(response).to render_template(:new)
      end

      it 'sets a flash alert' do
        post :create, params: { category: category_params }
        expect(flash[:alert]).to eq(error_message)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      allow(controller).to receive(:user_signed_in?).and_return(true)
      allow(controller).to receive_message_chain(:current_user, :categories, :find).and_return(category)
      allow(category).to receive(:destroy).and_return(true)
    end

    it 'destroys the requested category' do
      expect(category).to receive(:destroy)
      delete :destroy, params: { id: 1 }
    end

    it 'redirects to the categories index' do
      delete :destroy, params: { id: 1 }
      expect(response).to redirect_to(categories_path)
    end

    it 'sets a flash notice' do
      delete :destroy, params: { id: 1 }
      expect(flash[:notice]).to eq('Category deleted successfully!')
    end
  end
end