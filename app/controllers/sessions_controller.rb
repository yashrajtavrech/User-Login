class SessionsController < ApplicationController
    skip_before_action :authorize, only: :create

    def create
        @user = User.find_by(username: params[:user][:username])

        if @user && @user&.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            render json: @user
        else
            render json: {message: "Something wents wrongs"}
        end
    end

    def destroy
        session.delete :user_id
        head :no_content
    end
end