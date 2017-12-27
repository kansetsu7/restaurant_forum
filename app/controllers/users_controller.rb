class UsersController < ApplicationController
  before_action :set_user ,only: [:show, :edit, :update]

  def show
    
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
    params.require(:user).permit(:name, :intro, :avatar)
  end

end
