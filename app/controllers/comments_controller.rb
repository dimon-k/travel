class CommentsController < ApplicationController

	before_action :authenticate_user!
	before_action :find_post, only: [:create, :edit, :update, :destroy]
	before_action :find_comment, only: [:edit, :update, :destroy]
	before_action :user_or_admin, only: [:edit, :update, :destroy]

	def create
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		@comment.update_attributes(comment_params)
		if @comment.save
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@comment.destroy
		redirect_to @post
	end

	private
	def find_post
		@post = Post.find(params[:post_id])
	end

	def find_comment
		@comment = @post.comments.find(params[:id])
	end

	def comment_params
		params.require(:comment).permit(:content)
	end
end
