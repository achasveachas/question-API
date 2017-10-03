class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :authorize

  private

  def authorize
    @tenant = Tenant.find_by(api_key: params[:headers][:Authorization]&.split(" ")&.last)
    if !@tenant
      render json: {
        errors: ["Incorrect API Key"]
      }, status: 401
    end
  end
end
