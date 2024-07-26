module Public
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :correct_user, only: [:edit, :update, :destroy]

    def show
      @posts = @user.posts
    end

    def edit
    end

    def update
      if @user.update(user_params)
        flash[:notice] = "ユーザー情報が更新されました。"
        redirect_to user_path(@user)
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      flash[:notice] = "アカウントが削除されました。"
      redirect_to new_user_registration_path
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :profile_img, :self_introduction) # self_introductionを追加
    end

    def correct_user
      unless @user == current_user
        flash[:alert] = "他のユーザーの情報を編集・削除することはできません。"
        redirect_to user_path(current_user) # ログインユーザーのマイページに遷移
      end
    end
  end
end
