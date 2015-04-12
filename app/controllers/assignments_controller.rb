class AssignmentsController < TasksController

	def index
		if @type
			@sort = "last"
			@assignments = @course.assignments.where(assign_type: @type).order("due ASC").drop(@drop.to_i).take(10)
			@students = get_data("students", "assignments")
		else
			@assignments = get_data("assignments").reject {|a| a.assign_type == "Participation"}
		end
	end

	def update
		super(assignment_params)
	end

	def create
		create_params = assignment_params
		if !create_params[:due].blank?
			create_params[:due] = DateTime.strptime(assignment_params[:due], "%m/%d/%Y")
		else
			create_params[:due] = nil
		end
		assignment = @course.assignments.build(create_params)
		if assignment.save
			@course.students.each do |student|
				student.grades.create(assignment_id: assignment.id, score: 0)
			end
			redirect_to :back, notice: "Assignment was added successfully"
		else
			redirect_to :back, alert: assignment.errors.full_messages
		end
	end

	def destroy
		super
	end

	private

	def assignment_params
		params.require(:assignment).permit(:name, :assign_type, :due )
	end
end
