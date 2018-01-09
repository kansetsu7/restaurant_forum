class FriendshipsController < ApplicationController
  before_action :friendship_params ,only: [:create]
  before_action :set_friendship ,only: [:destroy]

  def create
    @friendship = current_user.friendships.build(friendship_params)
    if @friendship.save
      flash[:notice] = 'Successfully friended!'
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    
  end

  private

  def friendship_params
    params.permit(:friend_id)
  end

  def set_friendship
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
  end

end
