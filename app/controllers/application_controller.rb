class ApplicationController < ActionController::API
    include ActionController::Cookies

    rescue_from ActiveRecord::RecordInvalid, with: :render_response

    before_action :authorize

    private

    def authorize
    byebug
       @current_user = User.find_by(id: session[:user_id])

       render json: { errors: ["Not Authorize"]}, status: :unauthorize unless @current_user
    end

    def render_response(exception)
        render json: { errors: exception.record.errors.full_message }, status: :unprocessable_entity
    end
end
