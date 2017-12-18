class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    set_restaurant
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
  
end
