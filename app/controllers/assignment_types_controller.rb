class AssignmentTypesController < SecureController
	respond_to :html, :json 
	
	def update
		assign_type = AssignmentType.find(params[:id])
		assign_type.update_attributes(assign_type_params)
		render json: assign_type
	end

	def create
		assign_type = @course.assignment_types.build(assign_type_params)
		if assign_type.save
			redirect_to @course, notice: "Assignment type was added"
		else
			redirect_to @course, alert: assign_type.errors.full_messages
		end
	end

	private 

	def assign_type_params
		params.require(:assignment_type).permit(:assign_type, :percentage, :format)
	end

end
