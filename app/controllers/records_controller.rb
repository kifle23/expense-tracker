class RecordsController < ApplicationController
  before_action :authenticate_user!
  def index
    @category = current_user.categories.find(params[:category_id])
    @records = @category.records.order(created_at: :desc)
  end

  def new
    @category = current_user.categories.find(params[:category_id])
    @record = @category.records.new
  end

  def create
    @category = current_user.categories.find(params[:category_id])
    @record = current_user.records.new(record_params)
    @record.category_ids = params[:record][:category_ids] || [] 
  
    if @record.save
      flash.now[:notice] = "#{@record.name} created successfully!"
      redirect_to category_records_path(@category)
    else
      flash.now[:alert] = @record.errors.full_messages.first
      render :new
    end
  end

  private

  def record_params
    params.require(:record).permit(:name, :amount)
  end
end
