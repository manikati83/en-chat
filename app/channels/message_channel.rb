class MessageChannel < ApplicationCable::Channel
  
  def subscribed()
    #接続
    member = Pool.where(id: current_user.id).first
    
    stream_from "message_channel"
  end

  def unsubscribed()
    #切断
    # Any cleanup needed when channel is unsubscribed
    member = Pool.where(id: current_user.id).first
    member.destroy()
  end

  def speak(message)
    ActionCable.server.broadcast 'message_channel', message: message['message'], user: message['user'], user_id: message['user_id']
  end
  
  def come_in(user)
    ActionCable.server.broadcast 'message_channel', come_user: user['user'], come_user_id: user['user_id']
  end
end
