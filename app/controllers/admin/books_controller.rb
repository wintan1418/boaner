module Admin
  class BooksController < BaseController
    before_action :set_book, only: [ :show, :edit, :update, :destroy ]

    def index
      @books = Book.order(created_at: :desc)
    end

    def show
      redirect_to edit_admin_book_path(@book)
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to admin_books_path, notice: "Book created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @book.update(book_params)
        redirect_to admin_books_path, notice: "Book updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @book.destroy
      redirect_to admin_books_path, notice: "Book deleted."
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :description, :buy_url, :published_year, :cover)
    end
  end
end
