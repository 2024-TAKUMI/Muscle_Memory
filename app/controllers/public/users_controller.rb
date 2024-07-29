module Public
  class UsersController < ApplicationController
    before_action :authenticate_user! # ログインしていないユーザーは弾く
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]

    def show
      if @user
        @posts = @user.posts
      else
        redirect_to root_path, alert: "ユーザーが見つかりませんでした。"
      end
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
      if params[:id] != 'sign_out'
        @user = User.find_by(id: params[:id])
        unless @user
          redirect_to root_path, alert: "ユーザーが見つかりませんでした。"
        end
      end
    end

    def user_params
      params.require(:user).permit(:name, :profile_img, :self_introduction)
    end

    def correct_user
      unless @user == current_user
        flash[:alert] = "他のユーザーの情報を編集・削除することはできません。"
        redirect_to user_path(current_user)
      end
    end
  end
end
