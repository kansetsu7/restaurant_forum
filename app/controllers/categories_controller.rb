class CategoriesController < ApplicationController
  before_action :set_category ,only: [:show]

  def show
    @categories = Category.all
    @restaurants = @category.restaurants.order('name ' + sort_direction).page(params[:page]).per(9)
    @current_direction = sort_direction
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
