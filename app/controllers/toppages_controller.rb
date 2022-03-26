class ToppagesController < ApplicationController
  def index
    @pool = Pool.new
    @members = Pool.where(online: true).count
    if cookies.signed[:user_id]
      user = Pool.find_by(id: cookies.signed[:user_id])
      @name = user.name
    end
  end
end
