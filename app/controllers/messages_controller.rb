class MessagesController < ApplicationController
  def index
    @nickname = params[:nickname]
    pool = Pool.new
    pool.save
    @pool = Pool.last
    
    gon.api_key = ENV['API_KEY']
  end
end
