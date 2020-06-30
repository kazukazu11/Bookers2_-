class BookCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@book = Book.find(params[:book_id])
		@book_comment = BookComment.new(book_comment_params)
		@book_comment.book_id = @book.id
		@book_comment.user_id = current_user.id
		if @book_comment.save
			flash[:success] = "Comment was successfully created."
		else
			@book_comments = BookComment.where(book_id: @book.id)
    		render '/books/show'
		end
	end

	def destroy
		@book_comment = BookComment.find(params[:book_id])
		@book = @book_comment.book
		if @book_comment.user_id != current_user.id
			# 遷移前のURLを取得
			redirect_to request.referer
		end
		@book_comment.destroy
	end
	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
