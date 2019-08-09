# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

get_closest_field = (event, field) ->
  $(event.target).closest('.row.mb-4').find(field)

sum_fields = (fields) ->
  sum=0
  for i in [0..fields.length-1]
    sum = parseInt(sum,10) + parseInt(fields.eq(i).text().replace( /^\D+/g, ''),10)
  sum

$(document).on('turbolinks:load', ->
  $('#products_window').on('click', 'a:contains(+)',(event) ->
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

  $('[aria-label="Remove_ordered_product"]').on('click', (event) ->
    $.ajax(
      url: 'cart/remove_product'
      type: 'post'
      method: 'delete'
      data: {id: get_closest_field(event,'.d-none').text()}
      success: ->
        $(event.target).closest(".row.mb-4").remove()
        $('#subtotal').text(parseInt($('#total').text().replace( /^\D+/g, ''),10)-parseInt(get_closest_field(event,'[data-name="total_price"]').text().replace( /^\D+/g, ''),10))
        $('#total').text(parseInt($('#total').text().replace( /^\D+/g, ''),10)-parseInt(get_closest_field(event,'[data-name="total_price"]').text().replace( /^\D+/g, ''),10))
    )
  )

  $("[type='number']").keypress( (evt) ->
    evt.preventDefault();
  )

  $("[type='number']").on('change', ->
    get_closest_field(event,'[data-name="displayed_quontity"]').text($(event.target).val())
    get_closest_field(event, '[data-name="total_price"]').text(' = $'+parseInt(get_closest_field(event, '[data-name="displayed_price"]').text().replace( /^\D+/g, ''),10) * $(event.target).val())
    rezult = sum_fields($('[data-name="total_price"]'))
    $('#subtotal').text(rezult)
    $('#total').text(rezult)
  )
);
