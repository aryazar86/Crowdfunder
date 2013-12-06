class UsersController < ApplicationController
  before_filter :require_login, :except => [:new, :create, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to projects_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @comment = @user.comments.build

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to projects_path
    else
      render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :remember_me_token, :bio, :avatar)
  end
end
