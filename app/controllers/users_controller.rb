class UsersController < ApplicationController
  before_action :set_user ,only: [:show, :edit, :update]

  def index
    @users = User.all.page(params[:page]).per(12)
  end

  def show
    @commented_restaurants = @user.restaurants.distinct
    @favorited_restaurants = @user.favorited_restaurants
    @all_friends = current_user.all_friends
  end

  def edit
    
  end

  def update
    if @user != current_user
      flash.now[:alert] = 'Not able to edit other\'s profile!'
      redirect_back(fallback_location: root_path)
    end

    if @user.update(user_params)
      flash[:notice] = "User porfile was successfully update"
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = 'Update failed!'
      redirect_to user_path(current_user)
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
