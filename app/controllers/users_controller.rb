class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :require_is_admin
  layout "users_admin"

    def index
      @users = User.where(:is_hidden => false).order("created_at DESC")
    end

    def show
      @user = User.find(params[:id])
    end

    private

    def user_params
     params.require(:job).permit(:email, :is_hidden)
    end
end
