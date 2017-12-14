class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

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
      flash.now[:alert] = "category was failed to create"
      @categories = Category.all
      render :index
    end
  end

  def update
    set_category
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice] = "category \"#{@category.name}\" was successfully updated"
    else
      flash.now[:alert] = "category was failed to update"
      @categories = Category.all
      render :index
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
