class WordsController < ApplicationController
  before_action :require_user_logged_in, only: [:create, :destroy]
  def create
    @word = current_user.words.build
    @word_book = current_user.words.build
    @word_book.english = params[:english]
    @word_book.japanese = params[:japanese]
    if @word_book.save
      flash.now[:success] = "単語帳に保存しました。"
    else
      render chat_path
    end
  end

  def destroy
  end
  
  private
  
  def word_params
    params.require(:word).permit(:english, :japanese)
  end
end
