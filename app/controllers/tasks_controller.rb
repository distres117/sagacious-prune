class TasksController < SecureController
	respond_to :html, :json

	def update(param)
		assignment = Assignment.find(params[:id])
		assignment.update_attributes(param)
		render json: assignment
	end

	def destroy
		Assignment.find(params[:id]).destroy
		redirect_to :back
	end

	private

end