class CommentsController < ApplicationController
  before_filter :load_project
  before_filter :ensure_logged_in, :only => [:edit, :create, :show, :update, :destroy]

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = @project.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to project_path(@project.id), notice: "Comment added successfully!"
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
    params.require(:comment).permit(:note, :project_id, :user_id)
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end
