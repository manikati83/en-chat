class PoolsController < ApplicationController
  def new
    @pool = Pool.new
    if cookies.signed[:user_id]
      user = Pool.find_by(id: cookies.signed[:user_id])
      @name = user.name
    end
  end

  def create
    if cookies.signed[:user_id]
      @pool = Pool.find_by(id: cookies.signed[:user_id])
      name = pool_params
      if @pool.name != name[:name]
        @pool.update(name: name[:name])
      end
      redirect_to chat_path
    else
      @pool = Pool.new(pool_params)
      if @pool.save
        cookies.signed[:user_id] = @pool.id
        redirect_to chat_path
      else
        flash.now[:danger] = '入室できませんでした。'
        render :new
      end
    end
  end
  
  
  private
  def pool_params
    params.require(:pool).permit(:name)
  end
end
