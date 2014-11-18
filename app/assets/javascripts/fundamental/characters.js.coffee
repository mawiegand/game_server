# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


# OpluOsRCGVgephZC


$ ->
  $("#character_search_field").keyup ->
    $("#characters").load "/game_server/en/fundamental/characters/livesearch?utf8=✓&" + $("#character_search_field").serialize()
    false

  return
