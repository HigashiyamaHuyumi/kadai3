class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    #@post_images = @user.post_images.page(params[:page])
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id]) #ユーザーの取得
    @user.update(user_params) #ユーザーのアップデート
    redirect_to user_path(@user) #ユーザーの詳細ページへのパス
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
