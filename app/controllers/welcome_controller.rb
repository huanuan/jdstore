class WelcomeController < ApplicationController
  def index
   flash[:warning] = "剁手党请绕路！"
  end

end
