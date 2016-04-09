class PagesController < ApplicationController 
  def home
    @new = User.new
    redirect_to new_user_session_path
  end


end