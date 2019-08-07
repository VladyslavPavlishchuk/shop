# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load', ->

  $('#categories_list li').on('click', (event) ->
    $.ajax(
      url: 'pages/products'
      type: 'get'
      data: {id: $(event.target.parentNode).find('p').val()}
      success: (response,data,third) ->
        console.log(third)
    )
  )
);