class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
    # redirect_to request.referer
    # createアクションとdestroyアクションのredirect_toを削除します。
    # redirect_toを指定してしまうと画面遷移が行われてしまい、非同期通信が行われなくなってしまうためです。
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    # redirect_to request.referer
  end
end
