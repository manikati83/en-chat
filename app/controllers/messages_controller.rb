class MessagesController < ApplicationController
  def index
    @pools = Pool.all
    @nickname = params[:nickname]
    pool = Pool.create(name: @nickname)
    pool.save
    @pool = Pool.last
    
    gon.qrw_dfeoxjhummk876r = ENV['API_KEY']
    
    if logged_in?
      @word = current_user.words.build
    end
  end
end
