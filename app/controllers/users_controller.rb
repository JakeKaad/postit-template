class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]
	
	def show

	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		binding.pry

		if @user.save
			flash[:notice] = "Profile successfully created"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit

	end

	def update

	end

	private
		
		def user_params
			params.require(:user).permit(:username, :password, :password_confirmation)
		end

		def set_user
			@user = User.find(params[:id])
		end


end