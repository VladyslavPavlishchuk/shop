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

set_sum = ->
  sum = sum_fields($('[data-name="total_price"]'))
  $('#subtotal').text(sum)
  $('#total').text(sum)

$(document).on('turbolinks:load', ->
  set_sum()

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
      data: {id: get_closest_field(event,'#ordered_product_id').text()}
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
    quontity = get_closest_field(event,'[data-name="displayed_quontity"]')
    total = get_closest_field(event, '[data-name="total_price"]')
    price = get_closest_field(event, '[data-name="displayed_price"]')
    discount = get_closest_field(event, '[data-name="discount"]')
    quontity.text($(event.target).val())

    unless get_closest_field(event,'[data-name="discount"]').length
      total.text(' = $'+parseInt(price.text().replace( /^\D+/g, ''),10) * $(event.target).val())

    if get_closest_field(event, '[data-type="fixed"]').length
      rezult = parseInt(price.text().replace( /^\D+/g, ''),10)*quontity.text() - parseInt(discount.text().replace( /^\D+/g, ''),10)
      total.text("$ = $"+rezult)
    else if get_closest_field(event, '[data-type="percent"]').length
      rezult = parseInt(price.text().replace( /^\D+/g, ''),10)*quontity.text() - parseInt(price.text().replace( /^\D+/g, ''),10)*quontity.text() / 100 * parseInt(discount.text().replace( /^\D+/g, ''),10)
      total.text("% = $"+rezult)

    set_sum()
  )

  $('button:contains("Next")').on('click', ->
    $.ajax(
      url: 'order/submit'
      type: 'post'
      method: 'patch'
      data: {order_id: $('#order_id').text(), quontities: $('input[type="number"]').map( (key,value) ->  value.value).get()}
      success: ->
        window.location.replace("localhost:3000");
    )
  )

  $('button:contains("Cancel")').on('click', ->
    $.ajax(
      url: 'order/delete'
      type: 'post'
      method: 'delete'
      data: {order_id: $('#order_id').text()}
      success: ->
        window.location.replace("localhost:3000");
    )
  )
);
