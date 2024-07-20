class Admin::SessionsController < Devise::SessionsController
  # ログイン後にリダイレクトするパス
  def after_sign_in_path_for(resource)
    admin_root_path
  end

  # ログアウト後にリダイレクトするパス
  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path
  end
end
