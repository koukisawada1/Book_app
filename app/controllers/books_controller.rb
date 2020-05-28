class BooksController < ApplicationController
	before_action :authenticate_user!

	def create
        @user = current_user
        @books = Book.all
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
            flash[:notice] = "You have creatad book successfully."
            redirect_to book_path(@book.id)
        else
            render "books/index"
        end
    end

    def index
        @user = current_user
        @book = Book.new
        @books = Book.all
    end

    def show
        @post_book = Book.find(params[:id])
        @user = @post_book.user
        @comments = @post_book.post_comments
        @book = Book.new
        @books = Book.all
        @post_comment = PostComment.new
    end

    def edit
        @book = Book.find(params[:id])
        if @book.user != current_user
            redirect_to books_path, notice: "不正なアクセスです"
        end
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "You have updated user successfully."
            redirect_to book_path(@book.id)
        else
            render :edit
        end
    end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end

    private
     def book_params
        params.require(:book).permit(:title, :body)
     end

end
