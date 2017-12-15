class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_admin
  before_action :set_restaurant ,only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @restaurants = Restaurant.order(sort_column + ' ' + sort_direction).page(params[:page]).per(10)
    @current_title = sort_column
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "restaurant was successfully created"
      redirect_to admin_restaurants_path
    else
      flash.now[:alert] = "restaurant was failed to create"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "restaurant \"#{@restaurant.name}\" was successfully update"
      redirect_to admin_restaurant_path(@restaurant)
    else
      render :edit
      flash[:alert] = "restaurant was failed to update"
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path
    flash[:alert] = "restaurant was deleted"
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description, :image, :category_id)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def sort_column
    # if there's no sort params then order by name
    Restaurant.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
