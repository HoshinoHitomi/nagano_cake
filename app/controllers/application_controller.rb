class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)

      case resource

      when Admin
        admin_root_path

      when Customer
        items_path
      end
    end
    
  protected

  def configure_permitted_parameters
    added_attrs = [
      :last_name, :first_name, :last_name_kana, :fitst_name_kana, :postal_code, :address, :telephone_number, :email, :password, :password_confirmation, :remember_me
      ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
