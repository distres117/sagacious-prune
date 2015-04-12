module ApplicationHelper

	def is_active(param)
		if @type
			return "active" if @type == param
		else
			return "active" if current_page?(param)
		end
	end

	def make_pages(links)
		if !links.nil?
			content_tag(:ul, id: "pagination") do
				links.keys.each do |key|
					concat(content_tag(:li, link_to(key, links[key]), 
						class: params[:page] == key ? "active" : "" ))
				
				end
			end
		end	
	end

	def bip(object, field, param)
		if param == "Check"
			return best_in_place object, field, as: :select, collection: [ [0.86, "\u2713"], [1.0, "\u2713+"], [0.76, "\u2713-"], [0.0, "NC"]]
		else
			return best_in_place object, field, as: :select, collection: letter_grades.map {|g| [(g[0][1] / 100.0).round(2), g[1]] }
		end
	end

	def to_grade(value)
		letter_grades.select { |g| value.round.between?(g[0][0], g[0][1]) }.first[1]
	end

	def letter_grades
		[
			[[97, 100], "A+"],
			[[93, 96], "A"],
			[[90, 92], "A-"],
			[[87, 89], "B+"],
			[[83, 86], "B"],
			[[80, 82], "B-"],
			[[77, 79], "C+"],
			[[73, 76], "C"],
			[[70, 72], "C-"],
			[[67, 69], "D+"],
			[[60, 66], "D" ],
			[[0, 59], "F"],
			[[0,0], "NC"]
		]
	end


	def sortable_link_to(title, controller)
		path = Rails.application.routes.url_helpers.send("course_#{controller}_path", @course, sort: title.downcase, page: params[:page])
		link_to title, path, method: :get
	end


	def ind_row(param, id, &block)
		if param <= 59
			 result = "danger"
		elsif param.between?(60, 69)
			result = "warning"
		else
			result = ""
		end
		content_tag(:tr, id: id, class: result) do
			block.call
		end
	end

	



end
