class Admin::SessionsController < Devise::SessionsController
  protected

  # ログイン後にリダイレクトするパス
  def after_sign_in_path_for(resource)
    admin_dashboard_path
  end

  # ログアウト後にリダイレクトするパス
  def after_sign_out_path_for(resource)
    new_admin_session_path
  end
end
