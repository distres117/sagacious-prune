class AssignmentTypesController < SecureController
	respond_to :html, :json 
	
	def update
		assign_type = AssignmentType.find(params[:id])
		assign_type.update_attributes(assign_type_params)
		partial = render_to_string( partial: 'courses/settings.html.erb', layout: false).html_safe
		respond_to do |f|
			f.json { render json: { partial: partial, status: 200 } }
			f.js
		end
	end

	def create
		assign_type = @course.assignment_types.build(assign_type_params)
		if assign_type.save
			redirect_to @course, notice: "Assignment type was added"
		else
			redirect_to @course, alert: assign_type.errors.full_messages
		end
	end

	def destroy
		target = @course.assignment_types.find(params[:id])
		@course.assignments.where(assign_type: target.assign_type).destroy_all
		target.destroy
		redirect_to :back
	end

	private 

	def assign_type_params
		params.require(:assignment_type).permit(:assign_type, :percentage, :format, :drop_lowest)
	end

end
