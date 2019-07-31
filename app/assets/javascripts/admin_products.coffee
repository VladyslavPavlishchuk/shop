# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#Change colour to darker and back
$(document).on('turbolinks:load', ->
  $(".edit_form").hide();
  $(".edit_form").find(".error_field").hide();

  get_text = (label_tag, event) ->
    $(event.target.parentNode).siblings().find(label_tag).text();

  set_input_val = (form_class, input_tag, text) ->
    $(form_class).find(input_tag).val(text);

  add_row = (colls_count, table) ->
    $(table).append("<tr class='row'></tr>");
    $(table+" tr:last-child").append(
      for i in [1..colls_count]
        "<td class='category_field'></td>"
    );

  edit_btn_field = (table) ->
    $(table).find("tr").last().find("td").last()

  add_data_to_row = (table_selector,url) ->
    cols = $(table_selector).find("tr").last().children(".category_field")
    $.ajax(
      url: url
      type: 'get'
      success: (response) ->
        resp = JSON.parse(response)
        for i in [0..response.length-1]
          $('.table tr:last td').eq(i).append("<p class='"+Object.keys(resp)[i]+"'>"+Object.values(resp)[i]+"</p>")
        edit_btn_field('.table').empty()
        edit_btn_field('.table').append("<button type=\"button\" class=\"purple_btn\">Edit</button>")
        edit_btn_field('.table').append("<button type=\"button\" class=\"purple_btn\">Delete</button>")
   )

  edit_data_in_row = (data, event, for_param="id") ->
    cols = $(".table").find("p[class='"+for_param+"']:contains('"+data[0]+"')").parent().siblings()
    for i in [0..cols.length-2]
      cols.eq(i).children("").first().text(data[i+1])

  $('.category_field').on('mouseover', (event) ->
    $(event.target.closest('.row')).css('background-color', '#e2daff');
  )

  $('.category_field').on('mouseout', (event) ->
    $(event.target.closest('.row')).css('background-color', 'white');
  )

  #Hide new btn and show edit form
  $('.big_purple_btn').on('click', (event) ->
    event.preventDefault();
    $('.big_purple_btn').hide("slow", -> $(".edit_form").show("slow"));
  )

  $('#products_table button:contains("Edit")').on('click', (event) ->
    event.preventDefault();
    $('.big_purple_btn').hide("slow", -> $(".edit_form").show("slow"));
    set_input_val(".edit_form", "input[type='hidden']", get_text("p[class='id']", event));
    set_input_val(".edit_form", "input[name='name']", get_text("p[class='name']", event));
    set_input_val(".edit_form", "input[name='price']", get_text("p[class='price']", event));
    set_input_val(".edit_form", "textarea[name='description']", get_text("p[class='description']", event));
    set_input_val(".edit_form", "select[name='category_id']", get_text("p[class='category_id']", event));
  )

#Hide edit form and show new btn
  $('#products_table').find("input[value='Save']").on('click', (event) ->
    event.preventDefault();
    $('.big_purple_btn').hide("slow", -> $(".edit_form").show("slow"));
    id_value = $(event.target.parentNode).find("input[type='hidden']").val()
    name_value = $('.edit_form input[name="name"]').val()
    price_value = $('.edit_form input[name="price"]').val()
    description_value = $('.edit_form textarea[name="description"]').val()
    category_value = $('.edit_form select[name="category_id"]').val()
    if !$(event.target.parentNode).find("input[type='hidden']").val().trim().length
      $.ajax(
        url: 'products'
        type: 'post'
        data: {
          name: name_value
          price: price_value
          description: description_value
          category_id: category_value
        }
        success: ->
          $(".edit_form").hide("slow", -> $('.big_purple_btn').show("slow"))
          add_row(6, ".table")
          add_data_to_row('.table', 'products/newest')
          $(".edit_form").find(".error_field").hide();
        error: (responce, json) ->
          $(".edit_form").find(".error_field").show("slow")
          $(".edit_form").find(".error_field").find("p").text(responce)
      )
    else
      $.ajax(
        url: 'products'
        type: 'post'
        method: 'PATCH'
        data: {
          id: id_value
          name: name_value
          price: price_value
          description: description_value
          category_id: category_value
        }
        error: (xhr, ajaxOptions, error) ->
          responce = JSON.parse(xhr.responseText)
          errors_log=Object.entries(responce.errors)
          $(".edit_form").find(".error_field").show("slow")
          for i in [0..errors_log.length-1]
            for j in [0..Object.values(errors_log[i])[1].length-1]
              $(".edit_form").find(".error_field").append("<p>"+Object.values(errors_log[i])[0]+" "+Object.values(errors_log[i])[1][j]+"</p>")
        success: ->
          $(".edit_form").hide("slow", -> $('.big_purple_btn').show("slow"))
          data = [id_value, name_value, price_value, description_value, category_value]
          edit_data_in_row(data, event)
          $(".edit_form").find(".error_field").hide();
      )
  );

#Delete row
  $('#products_table').find("button:contains('Delete')").on('click', (event) ->
    if confirm("Are you sure?")
      $.ajax({
        url: 'products'
        type: 'post'
        method: 'DELETE'
        success: $(event.target.closest('.row').remove())
        data: {id: get_text("p[class='id']", event)}
      })
    event.preventDefault();
  )


#=======================================================================================================

  $('#categories_table').find("button:contains('Edit')").on('click', (event) ->
    event.preventDefault();
    $('.big_purple_btn').hide("slow", -> $(".edit_form").show("slow"));
    set_input_val(".edit_form", "input[type='hidden']", get_text("p[class='show_id']", event));
    set_input_val(".edit_form", "input[name='name']", get_text("p[class='show_name']", event));
    set_input_val(".edit_form", "input[name='priority']", get_text("p[class='show_priority']", event));
  )

  #Hide edit form and show new btn
  $('#categories_table').find("input[value='Save']").on('click', (event) ->
    event.preventDefault();
    $('.big_purple_btn').hide("slow", -> $(".edit_form").show("slow"));
    id_value = $(event.target.parentNode).find("input[type='hidden']").val()
    name_value = $('.edit_form input[name="name"]').val()
    priority_value = $('.edit_form input[name="priority"]').val()
    if !id_value.trim().length
      $.ajax(
        url: 'categories'
        type: 'post'
        data: {
          name: name_value
          priority: priority_value
        }
        success: ->
          $(".edit_form").hide("slow", -> $('.big_purple_btn').show("slow"))
          add_row(4, ".table")
          add_data_to_row('.table', 'categories/newest')
          $(".edit_form").find(".error_field").hide();
        error: (responce, json) ->
          $(".edit_form").find(".error_field").show("slow")
          $(".edit_form").find(".error_field").find("p").text(responce)
      )
    else
      $.ajax(
        url: 'categories'
        type: 'post'
        method: 'PATCH'
        data: {
          id: id_value
          name: name_value
          priority: priority_value
        }
        error: (xhr, ajaxOptions, error) ->
          responce = JSON.parse(xhr.responseText)
          errors_log=Object.entries(responce.errors)
          $(".edit_form").find(".error_field").show("slow")
          for i in [0..errors_log.length-1]
            for j in [0..Object.values(errors_log[i])[1].length-1]
              $(".edit_form").find(".error_field").append("<p>"+Object.values(errors_log[i])[0]+" "+Object.values(errors_log[i])[1][j]+"</p>")
        success: ->
          $(".edit_form").hide("slow", -> $('.big_purple_btn').show("slow"))
          data = [id_value, name_value, priority_value]
          edit_data_in_row(data, event, "show_id")
          $(".edit_form").find(".error_field").hide();
      )
  );

#Delete row
  $('#categories_table').find("button:contains('Delete')").on('click', (event) ->
    if confirm("Are you sure?")
      $.ajax({
        url: 'categories'
        type: 'post'
        method: 'DELETE'
        success: $(event.target.closest('.row').remove())
        data: {id: get_text("p[class='show_id']", event)}
      })
    event.preventDefault();
  )
);
