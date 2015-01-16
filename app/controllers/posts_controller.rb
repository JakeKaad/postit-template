class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_permission, only: [:edit, :update]

  def index
  	@posts = Post.all.sort_by{|post| post.vote_count}.reverse
    respond_to do |format|
      format.html
      format.json { render :json => @posts }
      format.xml { render :xml => @posts }
    end
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

  def vote
    @vote = Vote.create(voteable: @post, user: @current_user, vote: params[:vote])
     
    respond_to do |format|
      format.html do
        @vote.valid? ? flash[:notice] = 'Your vote was counted.' :  flash[:error] = 'You can only vote on a post once.'
        redirect_to :back       
      end
      format.js
    end
  end

  private

    def set_post
      @post = Post.find_by slug: params[:id]
    end

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end

    def require_permission
      access_denied unless current_user == @post.user || current_user.admin?
    end

end
