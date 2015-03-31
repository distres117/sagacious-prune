class GradesController < SecureController
	respond_to :html, :json

	def update
		grade = Grade.find(params[:id])
		grade.update_attributes(grade_params)
		render json: grade
	end

	private 

	def grade_params
		params.require(:grade).permit(:score)
	end
end
