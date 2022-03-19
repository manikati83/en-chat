class MessagesController < ApplicationController
  #def index
  #  @pools = Pool.all
  #  @nickname = params[:nickname]
  #  pool = Pool.create(name: @nickname)
  #  pool.save
  #  @pool = Pool.last
    
  #  cookies[:user_id] = @pool.id
    
  #  gon.qrw_dfeoxjhummk876r = ENV['API_KEY']
    
  #  if logged_in?
  #    @word = current_user.words.build
  #  end
  #end
  
  
  def index
    @pool = Pool.find_by(id: cookies.signed[:user_id])
    @pools = Pool.where(online: true).or(Pool.where(id: @pool.id))
    
    if logged_in?
      @word = current_user.words.build
    end
    
    if @pool
      gon.qrw_dfeoxjhummk876r = ENV['API_KEY']
    else
      redirect_to new_pool_path
    end
  end
end
