# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/




$ ->
	$("#armies_search_field").keyup ->
		$("#armies_partial").load "https://localhost/game_server/en/military/armies/livesearch?utf8=✓&" + $("#armies_search_field").serialize()
		false

	return