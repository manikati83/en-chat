class NicksController < ApplicationController
  def new
  end

  def create
    nickname = params[:nick][:nickname]
    redirect_to chat_path(nickname: nickname)
  end
end
