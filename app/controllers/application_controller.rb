class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :authorize, :increment_counter

  private

  def authorize
    @tenant = Tenant.find_by(api_key: params[:authorization])
    if !@tenant
      render json: {
        errors: ["Incorrect API Key"]
      }, status: 401
    end
  end

  def increment_counter
    @tenant.update_attribute(:counter, @tenant.counter + 1)
  end
end
