# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $("#search_form").on("ajax:success", (e, data, status, xhr) ->
    $("body").html xhr.responseText
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#search_form").append "<p>ERROR</p>"
      