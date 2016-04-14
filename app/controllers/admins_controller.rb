class AdminsController < ApplicationController

  def show
    @company = set_company
    @coworkers = current_user.coworkers
    @conversation = Conversation.new
  end


  private

  def set_company
    current_user.company
  end

end
