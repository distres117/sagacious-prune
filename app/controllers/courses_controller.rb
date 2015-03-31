class CoursesController < SecureController
	respond_to :html, :json

	def index
		@courses = current_user.courses
	end

	def show
		@courses = current_user.courses
		@course = Course.find(params[:id]) 
	end

	def update
		course = Course.find(params[:id])
		course.update_attributes(course_params)
		render json: course
	end

	def create
		course = init_course
		redirect_to course_path(course)
	end

	def destroy
		course = Course.find(params[:id])
		course.destroy
		if current_user.courses.empty?
			init_course
		end
		redirect_to current_user.courses.first
	end

	private

	def course_params
		params.require(:course).permit(:name)
	end
end
