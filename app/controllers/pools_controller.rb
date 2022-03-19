class PoolsController < ApplicationController
  def new
    @pool = Pool.new
  end

  def create
    @pool = Pool.new(pool_params)
    if @pool.save
      cookies.signed[:user_id] = @pool.id
      redirect_to chat_path
    else
      flash.now[:danger] = '入室できませんでした。'
      render :new
    end
  end
  
  
  private
  def pool_params
    params.require(:pool).permit(:name)
  end
end
