class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end

  def by_category
    @category_choice = Category.find(params[:category_choice].to_i)
    @projects = @category_choice.projects
    @category_sum = 0

    @projects.each {|p| @category_sum +=  p.total_contributions}


    # @category_count = @category_choice.projects.contributions.count

    @category_choice
    respond_to do |format|
      format.js {}
      format.html { redirect_to projects_path }
    end

  end

  def show
    @project = Project.find(params[:id])

    if current_user
      @contribution = @project.contributions.build
      @comment = @project.comments.build
    end
  end

  def edit
    @project = Project.find(params[:id])
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
    params.require(:project).permit(:name, :description, :goal, :deadline, :category_id)
  end

end

