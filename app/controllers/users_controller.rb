class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @profile_image = @user.get_profile_image
    @books = @user.books
    render :show
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
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

  private

  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user
      redirect_to root_path
    end
  end

end
