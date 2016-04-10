class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    convo_id = Conversation.between(params[:sender_id],params[:recipient_id]).first.id
    @conversation = Conversation.find(convo_id)
    @question = (Question.all - @conversation.questions).sample
    @conversation.questions << @question
   
    @path = conversation_path(@conversation)
  end

  private

  def question_params
    params.require(:question).permit(:text,:subject)
  end
end
