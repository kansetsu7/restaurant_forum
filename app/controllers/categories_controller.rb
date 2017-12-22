class CategoriesController < ApplicationController
  before_action :set_category ,only: [:show]
  helper_method :get_id

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

  def get_id
    params[:id]
  end

end
