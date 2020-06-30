class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_book, {only:[:edit]}

	def create
		@user = current_user
		@book=Book.new(book_params)
  		@book.user_id=current_user.id
		@books = Book.all
		if @book.save
			flash[:notice] = "You have creatad book successfully."
			redirect_to book_path(@book.id)
		else
			render :index
		end
	end

	def index
		@book = Book.new
		@books = Book.all
		@user = current_user
	end

	def show
		@user = Book.find(params[:id]).user
		@book = Book.new
		@book_data = Book.find(params[:id])
		@book_comment = BookComment.new
		@book_comments = @book_data.book_comments
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to book_path(@book)
        else
            render :edit
        end
    end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end

    def authenticate_book
    	book = Book.find(params[:id])
    	if book.user_id != current_user.id
			redirect_to books_path
    	end
    end

	private
    def book_params
        params.require(:book).permit(:title, :body, :user_id)
    end
end
