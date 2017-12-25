class CommentsController < ApplicationController
  before_action :set_restaurant ,only: [:create]

  def create
    @comment = @restaurant.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to restaurant_path(@restaurant)

  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end
