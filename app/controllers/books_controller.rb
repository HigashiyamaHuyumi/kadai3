class BooksController < ApplicationController
  
  def create #データを追加（保存）する
    @book = Book.new(book_params)
    if @book.save
     flash[:notice] ='You have created book successfully.'
     redirect_to book_path(@book.id)
    else
     @books = Book.all
     render :index
    end
  end

  def index #データの一覧を表示する
   @book = Book.new
   @books = Book.all
  end

  def show #データの内容（詳細）を表示する
    @book = Book.find(params[:id])
  end

  def edit #データを更新するためのフォームを表示する
    @book = Book.find(params[:id])
    flash[:notice] ='Book was successfully updated.'
    render :edit
  end

  def update #データを更新する
   @book = Book.find(params[:id])
   
    if  @book.update(book_params)
     flash[:notice] ='Book was successfully updated.'
     redirect_to book_path(@book.id)
    else
     render :edit
    end
  end

  def destroy #データを削除する
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    flash[:notice] ='Book was successfully destroyed.' 
    redirect_to "/books" # 投稿一覧画面へリダイレクト
  end

  private

  def book_params
    params.permit(:title, :opinion)
  end
end