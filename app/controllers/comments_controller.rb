class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      comment = {text: @comment.text, user: @comment.user.nickname, date: l(@comment.created_at)}
      ActionCable.server.broadcast 'comment_channel', content: comment
    end
  end

  private
  def comment_params
    params_item_id = params.permit(:item_id)
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params_item_id[:item_id])
  end
end
