class RestaurantsController < ApplicationController
  before_action :set_restaurant ,only: [:show]
  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
