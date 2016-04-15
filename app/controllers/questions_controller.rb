class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    #creates new question from admin
    if params[:question].present?
      question = Question.create(question_params)
      question.company_id = current_user.company.id
      question.save
      redirect_to admin_path(current_user)
    else
    #tosses new question into the chat
      convo_id = Conversation.between(params[:sender_id],params[:recipient_id]).first.id
      @conversation = Conversation.find(convo_id)
      @question = (Question.all - @conversation.questions).sample
      @conversation.questions << @question
     
      @path = conversation_path(@conversation)
    end
  end

  def update
    question = Question.find(params[:id])
    question.update(question_params)
    redirect_to admin_path(current_user)
  end

  private

  def question_params
    params.require(:question).permit(:text,:subject)
  end
end
