class StaticPagesController < ApplicationController
  def home
    @books = Book.paginate page: params[:page], per_page: Settings.per_page
  end

  def help
  end

  def about
  end
end
