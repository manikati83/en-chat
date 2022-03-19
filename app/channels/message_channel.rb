class MessageChannel < ApplicationCable::Channel
  
  def subscribed()
    #接続
    stream_from "message_channel"
    member = Pool.where(id: current_user.id).first
    member.update_attributes(online: true)
    ActionCable.server.broadcast 'message_channel', come_user: current_user.name, come_user_id: current_user.id
  end

  def unsubscribed()
    #切断
    # Any cleanup needed when channel is unsubscribed
    ActionCable.server.broadcast 'message_channel', out_user: current_user.name, out_user_id: current_user.id
    member = Pool.where(id: current_user.id).first
    member.update_attributes(online: false)
  end

  def speak(message)
    ActionCable.server.broadcast 'message_channel', message: message['message'], user: message['user'], user_id: message['user_id']
  end
  
  
end
