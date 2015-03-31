class HomeworksController < TasksController

	def index
		@assignments = @course.homeworks.order("due ASC")
		@students = get_data("students", "homeworks")
	end

	def update
		super(homework_params)
	end

	def destroy
		super
	end

	private

	def homework_params
		params.require(:homework).permit(:name)
	end
end
