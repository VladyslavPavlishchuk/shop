# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load', ->
  $('a:contains(+)').on('click', (event) ->
    event.preventDefault();

    $.ajax(
      url:'/current'
      type: 'get'
      success: (result) ->
        $.ajax(
          url: 'ordered_products'
          type: 'post'
          data: {id: result.id, product_id: $(event.target.parentNode).find('.invisible').text()}
          success: ->
            $(event.target).addClass('disabled')
            if $('#navigation_menu .badge').hasClass('invisible')
              $('#navigation_menu .badge').removeClass('invisible')
            else
              $('#navigation_menu .badge').text(parseInt($('#navigation_menu .badge').text(),10)+1)
        )
    )
  )
);