class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin
  before_action :set_category ,only: [:update, :destroy]
  # before_action :set_category_to_default, only: [:destroy]

  def index
    @categories = Category.all
    if params[:id]
      set_category
    else
      @category = Category.new
    end
    
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "category \"#{@category.name}\" was successfully created"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      flash.now[:alert] = 'category was failed to create'
      render :index
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice] = "category \"#{@category.name}\" was successfully updated"
    else
      flash.now[:alert] = 'category was failed to update'
      @categories = Category.all
      render :index
    end
  end

  def destroy
    @category.destroy
    if @category.errors.any?
      flash[:alert] = "Failed!\n#{@category.errors.full_messages.to_sentence}"
    else
      flash[:alert] = 'category was successfully deleted'
    end
    redirect_to admin_categories_path
    # .errors.full_messages.to_sentence
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  # def set_category_to_default
  #   n_associated = @category.restaurants.size
  #   @category.restaurants.each do |restaurant|
  #     restaurant.update_attribute(:category_id, 1)
  #   end
  # end
end
