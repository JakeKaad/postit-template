class CommentsController < ApplicationController
	before_action :require_user

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.user = current_user
		
		if @comment.save
			flash[:notice] = "Your comment was created"
			redirect_to post_path(@post)
		else
		  render 'posts/show'
		end
	end

	def vote
		comment = Comment.find(params[:id])
    vote = Vote.create(user: current_user, vote: params[:vote], voteable: comment)
    comment.votes << vote

   	if vote.valid?
      flash[:notice] = "Thank you for voting"
    else
      flash[:error] = "You have already voted there"
    end

    redirect_to :back
  end
end