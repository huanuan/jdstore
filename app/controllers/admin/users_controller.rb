class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_is_admin
  layout "users_admin"

    def index
      @users = User.all
    end

    def require_is_admin
      if !current_user.admin?
         flash[:alert] = 'You are not admin'
         redirect_to root_path
      end
    end

    def admin
      @user = User.find(params[:id])
      @user.admin!

      redirect_to :back
    end

    def user
      @user = User.find(params[:id])
      @user.user!

      redirect_to :back
    end

    def destroy

      @user = User.find(params[:id])

      @user.destroy

      redirect_to admin_users_path
    end


    private

    def user_params
     params.require(:user).permit(:email, :is_hidden)
    end
end
