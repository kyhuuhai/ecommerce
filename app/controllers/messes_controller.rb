class MessesController < ApplicationController
  def create
    @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
    @mess = @conversation.messes.create(mess_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def mess_params
    params.require(:mess).permit(:user_id, :body)
  end
end
