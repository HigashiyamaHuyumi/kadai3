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
  end
  
  def index
    @user = current_user # current_user を設定
    @users = User.where.not(id: @user.id)
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
  
  def books
    other_user_id = params[:user_id]  # 他のユーザーの情報を取得する方法（例：URL パラメータからユーザー ID を取得）
    @user = User.find(other_user_id) # 他のユーザーの情報を取得して @user に代入
    @books = @user.books  # 他のユーザーの本の情報を取得する方法（例：User と Book のリレーションシップを使用
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
