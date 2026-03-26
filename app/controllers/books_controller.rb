class BooksController < ApplicationController
  def index
    @books = Book.order(published_year: :desc)
  end
end
