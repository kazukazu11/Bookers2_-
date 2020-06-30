class FavoritesController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		favorite = Favorite.new(user_id: current_user.id)
		favorite.book_id = @book.id
		favorite.save
	end

	def destroy
		@book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: @book.id)
		favorite.destroy
	end
end