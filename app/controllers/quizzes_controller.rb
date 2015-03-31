class QuizzesController < TasksController
	def index
		@assignments = @course.quizzes.order("due ASC")
		@students = get_data("students", "quizzes")
	end

	def update
		super(quiz_params)
	end

	def destroy
		super
	end

	private

	def quiz_params
		params.require(:quiz).permit(:name)
	end
end
