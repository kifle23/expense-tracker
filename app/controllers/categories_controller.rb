class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    if user_signed_in?
      @categories = current_user.categories.includes(:records)
    else
      render 'splash'
    end
  end

  def new
    @category = Category.new
  end

  def create
    @user = current_user
    @category = @user.categories.new(category_params)
    if @category.save
      flash[:notice] = "#{@category.name} created successfully!"
      redirect_to categories_path
    else
      flash[:alert] = @category.errors.full_messages.first
      render :new
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])
    if @category.destroy
      flash.now[:notice] = 'Category deleted successfully!'
      redirect_to categories_path
    else
      flash.now[:alert] = 'Something went wrong while deleting the category!'
      render :index
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
