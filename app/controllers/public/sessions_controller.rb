class Public::SessionsController < Devise::SessionsController
  before_action :user_status, only: [:create]

  def after_sign_in_path_for(resource)
    user_path(resource)  # ログイン後にユーザーのマイページに移動
  end

  def after_sign_out_path_for(resource)
    root_path  # ログアウト後にトップページに移動
  end
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "ゲストでログインしました"
  end
  

  private

  def user_status
    user = User.find_by(email: params[:user][:email])
    return if user.nil?
    return unless user.valid_password?(params[:user][:password])

    if user.is_active
      create
    else
      redirect_to new_user_registration_path
    end
  end
end
