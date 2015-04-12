class StudentsController < SecureController
	respond_to :html, :json
	def index
		@students = get_data("students")
	end

	def show
		@student = Student.find(params[:id])
	end

	def update
		student = Student.find(params[:id])
		student.update_attributes(student_params)
		render json: student
	end

	def destroy
		student = Student.find(params[:id])
		student.destroy
		redirect_to :back
	end

	def create
		new_student = @course.students.build(student_params)
		if new_student.save
			if @course.assignments.any?
				@course.assignments.each do |assign|
					new_student.grades.create(assignment_id: assign.id, score: 0)
				end
			end
			redirect_to :back, notice: "Student was added successfully"
			#partial = get_partial("students", "students", "view")
			#render json: {html: partial}
		else
			redirect_to :back, alert: new_student.errors.full_messages
		end
		
	end

	private

	def student_params
		params.require(:student).permit(:first, :last, :absences)
	end
	
end
