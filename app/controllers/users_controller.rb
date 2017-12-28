class UsersController < ApplicationController
  before_action :set_user ,only: [:show, :edit, :update]

  def show
    @commented_restaurants = @user.restaurants.distinct
    puts "====commented_restaurants===="
    puts @commented_restaurants
    puts "====commented_restaurants===="
  end

  def edit
    
  end

  def update
    if @user != current_user
      flash.now[:alert] = 'Not able to edit other\'s profile!'
      redirect_to :back
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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # if user didn't specify their name, set email name as default
    set_user
    puts "----here: \n#{params[:user][:name]}\nend----"
    if params[:user][:name] == ""
      params[:user][:name] = @user.email.split('@')[0]
    end
      puts "name = #{params[:user][:name]}"
    return params.require(:user).permit(:name, :intro, :avatar)
  end

end
