class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user, {only:[:edit]}

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = User.find(params[:id]).books
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user)
    else 
        render :edit
    end
  end


  
  def authenticate_user
    user = User.find(params[:id])
    if user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end
# current_user.id==現在、ログイン中のID
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
