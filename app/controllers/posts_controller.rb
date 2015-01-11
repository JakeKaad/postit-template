class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]

  def index
  	@posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
  	@post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    
    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to post_url(@post)
    else
      render 'new'
    end
    
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "This post was updated"
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end

    def require_creator
      unless current_user == @post.user
        flash[:error] = "You can't do that."
        redirect_to post_path(@post)
      end
    end

end
