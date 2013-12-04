class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])

    if current_user
      @contribution = @project.contributions.build
    end
  end

  def edit
    
    @project = Project.find(params[:id])
    if @project.validate_owner(current_user)
      # redirect_to edit_project_path
    else
      redirect_to projects_path, :alert => "You must be the owner to edit a project."
    end
    
  end

  def update
    @project = Project.find(params[:id])
    
      if @project.update_attributes(project_params)
        redirect_to projects_path
      else
        render :edit
      end
    
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

  private
  def project_params
    params.require(:project).permit(:name, :description, :goal, :deadline, :user_id)
  end

end

