class SecureController < ApplicationController
	before_action :authenticate_user
	before_action :get_values
	include Rails.application.routes.url_helpers


	private
	def get_data(controller, cust_path = nil)
		path = cust_path != nil ? send("course_#{cust_path}_path", @course) : send("course_#{controller}_path", @course)
		if !@sort || @sort.blank?
			items = get_items(@course.send(controller))
		else
			items = get_items(@course.send(controller).sort_by &@sort.to_sym)
		end
		# items.sort_by! &@sort.to_sym if @sort
		@links = get_page_links(@course.send(controller).count, path)
		return items
	end

	def get_partial(controller, variable, partial)
		items = get_data(controller)
		self.instance_variable_set("@#{variable}", items)
		return render_to_string( partial: partial, notice: "Student was added" ).html_safe
		
	end


		

	def get_values
		@course = Course.find(params[:course_id]) if params.has_key?("course_id")
		@page = params[:page]
		@sort = params[:sort]
		@type = params[:type]
		@drop = params[:drop] || 0
	end

	def get_items(data)
	 	@max_items = 12
	 	start = (@page.to_i - 1) * @max_items
	 	stop = start + (@max_items) >= data.count ? -1 : start + (@max_items - 1)
	 	data[start..stop]
	end

	def get_page_links(data, url)
		pages = (data.to_f / @max_items).ceil
		full_url = "#{url}/?page= &drop=#{@drop}" + (@sort ? "&sort=#{@sort}" : "") + (@type ? "&type=#{@type}" : "")
		Hash[1.upto(pages).map { |i| [i.to_s, full_url.sub(" ", i.to_s)] }] unless pages == 1
	end
end