class CommentsController < ApplicationController
  def create
    @message = Comment.new(message_params)
    @message.save
  end

  private
  def message_params
    params_item_id = params.permit(:item_id)
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params_item_id[:item_id])
  end
end
