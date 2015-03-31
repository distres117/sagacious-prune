class SecureController < ApplicationController
	before_action :authenticate_user
	before_action :get_values
	include Rails.application.routes.url_helpers


	private
	def get_data(controller, cust_path = nil)
		path = cust_path != nil ? send("course_#{cust_path}_path", @course) : send("course_#{controller}_path", @course)
		items = get_items(@course.send(controller))
		items.sort_by! &@sort.to_sym if @sort
		@links = get_page_links(@course.send(controller).count, path)
		return items
	end
		

	def get_values
		@course = Course.find(params[:course_id]) if params.has_key?("course_id")
		@page = params[:page]
		@sort = params[:sort]
		@type = params[:type]
	end

	def get_items(data)
	 	@max_items = 15
	 	start = (@page.to_i - 1) * @max_items
	 	stop = start + (@max_items) >= data.count ? -1 : start + (@max_items - 1)
	 	data[start..stop]
	end

	def get_page_links(data, url)
		pages = (data.to_f / @max_items).ceil
		full_url = "#{url}/?page= " + (@sort ? "&sort=#{@sort}" : "") + (@type ? "&type=#{@type}" : "")
		Hash[1.upto(pages).map { |i| [i.to_s, full_url.sub(" ", i.to_s)] }] unless pages == 1
	end
end