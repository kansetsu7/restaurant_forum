class RestaurantsController < ApplicationController
  before_action :set_restaurant ,only: [:show]
  def index
    @restaurants = Restaurant.order('name ' + sort_direction).page(params[:page]).per(9)
    @categories = Category.all
    @current_direction = sort_direction
  end

  def show
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
