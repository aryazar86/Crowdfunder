class ContributionsController < ApplicationController
  before_filter :load_project

  def show
    @contribution = Contribution.find(params[:id])
  end

  def create
    @contribution = @project.contributions.build(contribution_params)
    @contribution.user_id = current_user.id

    if @contribution.save
      redirect_to project_path(@project.id), notice: "Thank you for you contribution!"
    else
      redirect_to 'projects/show', alert: "An error has occurred"
    end

  end

  def destroy
    @contribution

  end

  private
  def contribution_params
    params.require(:contribution).permit(:amount, :project_id)

  end

  def load_project
    @project = Project.find(params[:project_id])
  end



end
