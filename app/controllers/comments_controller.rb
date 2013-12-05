class CommentsController < ApplicationController
  before_filter :load_commentable
  before_filter :require_login, :only => [:edit, :create, :show, :update, :destroy]

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to url_for(@commentable), notice: "Comment added successfully!"
    else
      render 'projects/show', alert: "There was an error with your comment."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:note, :commentable_id, :commentable_type, :user_id)
  end

  def load_commentable
    @commentable = params[:comment][:commentable_type]
                    .constantize
                    .find(params[:comment][:commentable_id])
  end
end
