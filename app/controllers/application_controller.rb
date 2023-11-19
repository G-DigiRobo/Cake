class ApplicationController < ActionController::Base
   protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :telephone_number])
  end
end
