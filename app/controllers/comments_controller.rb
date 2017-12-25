class CommentsController < ApplicationController
  before_action :set_restaurant ,only: [:create, :destroy]
  before_action :set_comment ,only: [:destroy]

  def create
    @comment = @restaurant.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    if current_user.admin?
      flash[:notice] = "Comment by \"#{@comment.user.email.split('@')[0]}\" was successfully deleted"
      @comment.destroy
      redirect_to restaurant_path(@restaurant)
    else
      flash[:alert] = 'Not allow!'
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
