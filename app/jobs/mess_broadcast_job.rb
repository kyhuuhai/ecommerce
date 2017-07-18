class MessBroadcastJob < ApplicationJob
  queue_as :default

  def perform(mess)
    sender = mess.user
    recipient = mess.conversation.opposed_user(sender)

    broadcast_to_sender(sender, mess)
    broadcast_to_recipient(recipient, mess)
  end

  private

  def broadcast_to_sender(user, mess)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      mess: render_mess(mess, user),
      conversation_id: mess.conversation_id
    )
  end

  def broadcast_to_recipient(user, mess)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      window: render_window(mess.conversation, user),
      mess: render_mess(mess, user),
      conversation_id: mess.conversation_id
    )
  end

  def render_mess(mess, user)
    ApplicationController.render(
      partial: 'messes/mess',
      locals: { mess: mess, user: user }
    )
  end

  def render_window(conversation, user)
    ApplicationController.render(
      partial: 'conversations/conversation',
      locals: { conversation: conversation, user: user }
    )
  end
end
