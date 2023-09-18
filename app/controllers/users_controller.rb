class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @profile_image = @user.get_profile_image
    @books = @user.books
    @new_book = Book.new
    render :show
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
    @current_user = current_user
  end

  def index
    @new_book = Book.new
    @users = User.all
    @current_user = current_user
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id]) #ユーザーの取得
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = 'You have updated user successfully.'
    else
      render 'edit'
    end
  end

  def book
    other_user_id = params[:user_id]  # 他のユーザーの情報を取得する
    @user = User.find(other_user_id) # 他のユーザーの情報を取得して @user に代入
    @books = @user.books  # 他のユーザーの本の情報を取得する方法
    @profile_image = @user.get_profile_image  # 他のユーザーのプロフィール画像を取得する方法
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end

end
