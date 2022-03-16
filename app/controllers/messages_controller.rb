class MessagesController < ApplicationController
  def index
    @nickname = params[:nickname]
    pool = Pool.create(name: @nickname)
    pool.save
    @pool = Pool.last
    
    cookies[:user_id] = @pool.id
    
    gon.qrw_dfeoxjhummk876r = ENV['API_KEY']
    
    if logged_in?
      @word = current_user.words.build
    end
  end
end
