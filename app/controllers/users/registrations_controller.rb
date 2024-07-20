class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      flash[:notice] = "ようこそ#{resource.name}様" if resource.persisted?
    end
  end
end
