class MessageChannel < ApplicationCable::Channel
  
  def subscribed()
    #接続
    stream_from "message_channel"
  end

  def unsubscribed()
    #切断
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(message)
    ActionCable.server.broadcast 'message_channel', message: message['message'], user: message['user'], user_id: message['user_id']
  end
  
  def come_in(user)
    ActionCable.server.broadcast 'message_channel', come_user: user['user'], come_user_id: user['user_id']
  end
  
  def exit_room(user)
    pool = Pool.find_by(user['user_id'].to_i)
    unless pool.nil?
      pool.destroy()
    end
  end
end
