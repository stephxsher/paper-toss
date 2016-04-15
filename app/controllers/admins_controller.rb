class AdminsController < ApplicationController

  def show
    @company = set_company
    @coworkers = current_user.coworkers
    @conversation = Conversation.new
    @question = Question.new
    @custom_questions = Question.where(company_id:@company.id)
  end

  private

  def set_company
    current_user.company
  end

end
