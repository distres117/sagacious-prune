class NotesController < SecureController
	respond_to :html, :json
	before_action :get_params, only: [:create, :destroy, :index]
	
	def index	
	end

	def update
		note = Note.find(params[:id])
		note.update_attributes(note_params)
		render json: note
	end

	def create
		note = Note.create notable_id: @id.to_i, notable_type: @type, content: "Note"
		render action: 'index'
	end

	def destroy
		note = Note.find(params[:id])
		note.destroy
		render action: 'index'
	end


	private

	def get_params
		@id = params[:n_id]
		@type = params[:type]
		@course = Course.find(params[:c_id])
		if @id && @type
			@caller = @type.constantize.find_by(id: @id.to_i )
			@notes = @caller.notes
			@partial = "#{ActiveSupport::Inflector.pluralize(@type).downcase}/row" 
		end
	end

	def note_params
		params.require(:note).permit(:content)
	end
end
