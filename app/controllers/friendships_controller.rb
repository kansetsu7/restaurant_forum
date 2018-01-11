class FriendshipsController < ApplicationController
  before_action :friendship_params ,only: [:create]
  before_action :set_friendship ,only: [:destroy, :cancel]
  before_action :set_inverse_friendship ,only: [:create, :accept, :destroy]
  before_action :set_target_user ,only: [:create, :destroy, :accept, :cancel]

  def create
    if @inverse_friendship.nil? #target didn't sent request => you can friend them

      @friendship = current_user.friendships.build(friendship_params)
      if @friendship.save
        flash[:notice] = "Sent request to #{@target_user.name}"
      else
        flash[:alert] = @friendship.errors.full_messages.to_sentence
      end

    else #target already sent request => don't create, reload page!
      flash[:notice] = "#{@target_user.name} already sent request to you, reload page!"
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @friendship.nil?  && @inverse_friendship.nil? #target already unfriend current_user
      flash[:notice] = "#{@target_user.name} already unfriend to you, reload page!"

    elsif @friendship.nil? #still friend, current_user's id==friend_id in friend db
      @inverse_friendship.destroy
      flash[:alert] = "Unfriended #{@target_user.name}!"

    else #still friend, current_user's id==user_id in friend db
      @friendship.destroy
      flash[:alert] = "Unfriended #{@target_user.name}!"
    end
    redirect_back(fallback_location: root_path)
  end

  def accept
    puts "==accept=="
    if @inverse_friendship.nil? #target already cancel request => don't update, reload page!
      flash[:notice] = "#{@target_user.name} canceled their request, reload page!"
      redirect_back(fallback_location: root_path)

    else #request still exist => update
      if @inverse_friendship.update_attributes(confirmed: true)
        flash[:notice] = "Accept #{@target_user.name}'s request!"
      else
        flash[:alert] = @inverse_friendship.errors.full_messages.to_sentence
      end
      redirect_back(fallback_location: root_path)
    end
    
  end

  def cancel
    # puts "==cancel=="
    @friendship.destroy
    flash[:notice] = "Canceled request to #{@target_user.name}!"
    redirect_back(fallback_location: root_path)
  end

  private

  def friendship_params
    params.permit(:friend_id)
  end

  def set_friendship
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
  end

  def set_inverse_friendship
    @inverse_friendship = current_user.inverse_friendships.find_by(user_id: params[:id])
  end

  def set_target_user
    id = params[:id] || params[:friend_id]
    @target_user = User.find(id)
  end

end
