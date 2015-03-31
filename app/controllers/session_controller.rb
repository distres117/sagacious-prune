class SessionController < ApplicationController

	def new
	end

	def create
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			if user.courses.empty?
				init_course
			end
			redirect_to course_path(user.courses.first)
		else
			render 'new'
		end
	end

end
