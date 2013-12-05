class UserSessionsController < ApplicationController

  def new
    # @user = User.new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me_token])

    if user
      redirect_back_or_to(:projects, notice: 'Login successful')
    else
      flash.now.alert = "Login failed"
      render action: "new"
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: 'Logged out!'
  end

end
