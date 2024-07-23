class Public::SessionsController < Devise::SessionsController
  before_action :user_status, only: [:create]

  def after_sign_in_path_for(resource)
    public_root_path
  end

  def after_sign_out_path_for(resource)
    public_root_path
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