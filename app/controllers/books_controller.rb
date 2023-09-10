class BooksController < ApplicationController

  def create #データを追加（保存）する
    @book = current_user.books.new(book_params)
    if @book.save
      flash[:notice] ='You have created book successfully.'
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def index # データの一覧を表示する
    @book = Book.new
    @user = current_user
    @books = @user.books
    @profile_image = @user.get_profile_image
  end

  def show #データの内容（詳細）を表示する
    @book = Book.find(params[:id])
    @user = @book.user # Bookに関連付けられたUserを取得
    @profile_image = @user.get_profile_image
  end

  def edit #データを更新するためのフォームを表示する
    @book = Book.find(params[:id])
  end

  def update #データを更新する
   @book = Book.find(params[:id])
    if  @book.update(book_params)
     flash[:notice] ='You have updated book successfully.'
     redirect_to book_path(@book.id)
    else
     render :edit
    end
  end

  def destroy #データを削除する
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    flash[:notice] ='Book was successfully destroyed.'
    redirect_to books_path # 投稿一覧画面へリダイレクト
  end
  
  def other_users_books
    @other_users_books = Book.where.not(user_id: current_user.id)
  end

  private

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
  
end