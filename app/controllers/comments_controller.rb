class CommentsController < ApplicationController

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.user = User.first #change onc we have authentication

		if @comment.save
			flash[:notice] = "Your comment was created"
			redirect_to post_path(@post)
		else
		  render 'posts/show'
		end
	end
end