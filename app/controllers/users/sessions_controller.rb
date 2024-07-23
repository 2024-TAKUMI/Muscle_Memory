class Users::SessionsController < Devise::SessionsController
  # ログイン後にリダイレクトするパス
  def after_sign_in_path_for(resource)
    root_path
  end

  # ログアウト後にリダイレクトするパス
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def create
    super do |resource|
      flash[:notice] = "おかえりなさい　#{resource.name}様"
    end
  end
end
