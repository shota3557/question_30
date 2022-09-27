class BlogsController < ApplicationController
  before_action :set_blog, only:[:show, :edit, :update, :destroy]
  #「only: 〜」を使うことで、発動条件を限定することができる

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end  

  def index
    @blogs = Blog.all
  end

  def edit #before_action(２行目)にid取得を共通化してる
    
  end  

  def update #before_action(２行目)にid取得を共通化してる
    if @blog.update(blog_params) #更新した時に条件を絞る
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render :edit 
    end     
  end  

  def new 
    @blog = Blog.new #viewにデータ渡すためのインスタンス変数を定義
  end  

  def create
    @blog = Blog.new(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end

  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end

  def show #idのブログのレコード取得し、そのブログの詳細画面見せろと命令
           #before_action(２行目)に共通化してる
  end  

  private #配下のメソッドはそのクラス内からしか呼び出せなくなる
  #（他のクラスからは呼び出せないようになる）

  def blog_params
    params.require(:blog).permit(:title, :content)
  end  

  def set_blog #privateの中に書く理由は他のアクションで使われないから
    @blog = Blog.find(params[:id])
  end  #アクションが実行される前に書いてることを記述（２行目に）

end
