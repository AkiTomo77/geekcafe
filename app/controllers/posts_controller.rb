class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  protect_from_forgery :except => [:create]

def index
  if params[:search] == nil
        @posts= Post.all
    elsif params[:search] == ''
        @posts= Post.all
    else
        @posts = Post.where("address LIKE ? ",'%' + params[:search] + '%')
  end

  @lectures = Lecture.all

  @tag = Tag.select("name", "id")
  tag_search = params[:tag_search]
 
  if tag_search != nil
        @posts = Tag.find_by(id: tag_search).posts
    else
        @posts = Post.all
  end

  if params[:tag_ids]
    @posts = []
    params[:tag_ids].each do |key, value|      
        @posts += Tag.find_by(name: key).posts if value == "1"
    end
    @posts.uniq!
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(6)
  end
  @posts = @posts.page(params[:page]).per(6)
end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    
    post.user_id = current_user.id
    
    if post.save!
      redirect_to :action => "index", notice: "失敗だ"
    else
      redirect_to :action => "new" , notice: "失敗だ"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = @post.comments.build
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to :action => "show", :id => post.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to action: :index
  end

  private
  def post_params
    params.require(:post).permit(:place, :shop_name, :address, :image, :youtube_url, tag_ids: [])
  end
end
