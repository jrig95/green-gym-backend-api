class ApplicationController < ActionController::API
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

   protected

  def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up) do |user|
    user.permit(:first_name, :last_name, :email, :password, :user_company, :user_gender, :user_fitness_level, :user_passions, :user_total_calories, :user_points, :admin)
  end
end

end
