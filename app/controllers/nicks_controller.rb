class NicksController < ApplicationController
  def new
  end

  def create
    nickname = params[:nick][:nickname]
    if nickname != ""
      redirect_to chat_path(nickname: nickname)
    else
      flash.now[:danger] = '名前が入力されていません。'
      render :new
    end
  end
end
