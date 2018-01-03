class RestaurantsController < ApplicationController
  before_action :set_restaurant ,only: [:show, :dashboard, :favorite, :unfavorite, :like, :unlike]
  def index
    @restaurants = Restaurant.order('name ' + sort_direction).page(params[:page]).per(9)
    @categories = Category.all
    @current_direction = sort_direction
  end

  def show
    @comment = Comment.new
  end

  def feed
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def dashboard
  end

  def favorite
    @restaurant.favorites.create!(user: current_user)
    change_favorites_count(true)
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    favorite = Favorite.where(restaurant: @restaurant, user: current_user)
    favorite.destroy_all
    change_favorites_count(false)
    redirect_back(fallback_location: root_path)
  end

  def like
    # @restaurant.likes.create!(user: current_user) #same as below
    Like.create!(restaurant: @restaurant, user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    like = Like.where(restaurant: @restaurant, user: current_user)
    like.destroy_all
    redirect_back(fallback_location: root_path)
  end


  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def change_favorites_count(is_add)
    variation = is_add ? 1 : -1
    @restaurant.update_attribute(:favorites_count, @restaurant.favorites_count + variation)
  end

end
