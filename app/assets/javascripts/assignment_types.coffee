# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	$('.best_in_place').on("ajax:success", (evt, data, status, xhr) ->
		parsed = jQuery.parseJSON(data)
		partial = parsed["partial"] 
		$('#updatable').html(partial)
		$('.best_in_place').best_in_place()
		ev = $._data($('#updatable')[0], 'events')
		if ev == undefined
			$('#updatable').on("click", ready))

$(document).ready(ready)
$(document).on('page:load', ready)
