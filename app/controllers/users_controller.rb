class UsersController < ApplicationController
  def index
    if current_user 
    else
      redirect_to new_user_path
    end
  end

  
  def show
    @user = User.find(params[:id])
    @boards = current_user.boards.all
    @board = current_user.boards.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password))
    if @user.save
      session[:user_id] = @user.id.to_s
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    if current_user && current_user.id == User.find(params[:id]).id
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params.require(:user).permit(:email, :password))
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    reset_session
    User.find(params[:id]).destroy
    redirect_to main_path
  end
end
