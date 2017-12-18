class CategoriesController < ApplicationController
  before_action :set_category ,only: [:show]

  def show
    @categories = Category.all
    @restaurants = @category.restaurants.page(params[:page]).per(9)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

end
