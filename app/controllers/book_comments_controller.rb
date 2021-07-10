class BookCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@book = Book.find(params[:book_id])
		@book_comment = current_user.book_comments.new(book_comment_params)
		@book_comment.book_id = @book.id
		if @book_comment.save
  	  #redirect_to book_path(@book.id)
 	 	  # createアクションとdestroyアクションのredirect_toを削除します。
      # redirect_toを指定してしまうと画面遷移が行われてしまい、非同期通信が行われなくなってしまうためです。

		else
			@user = @book.user
			@newbook = Book.new
		  render 'books/show'
		end
	end

	def destroy
		@book = Book.find(params[:book_id])
		@comment = BookComment.find(params[:id])
		@newcomment = BookComment.new
		@comment.destroy
  # 	book_comment = @book.book_comments.find(params[:id])
		# book_comment.destroy
	#redirect_to request.referer
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
