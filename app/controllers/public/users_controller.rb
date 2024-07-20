class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to public_user_path(@user), notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  def unsubscribe
    # @user = User.find_by(name: params[:name])
  end

  def withdraw
    current_user.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_img, :self_introduction)
  end
end
