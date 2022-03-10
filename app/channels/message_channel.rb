class MessageChannel < ApplicationCable::Channel
  def subscribed
    #接続
    stream_from "message_channel"
  end

  def unsubscribed
    #切断
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(message)
    ActionCable.server.broadcast 'message_channel', message: message['message'], user: message['user'], user_id: message['user_id']
  end
end
