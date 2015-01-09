class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by username: params[:username]

		if user && user.authenticate(params[:password])
			flash[:success] = "Successfully logged in"
			session[:user_id] = user.id
			redirect_to root_path
		else
			flash[:error] = "User name or password entered incorrectly"
			render 'login'
		end
	end

	def destroy
		flash[:success] = "Succesfully logged out"
		session[:user_id] = nil
		redirect_to root_path
	end

end