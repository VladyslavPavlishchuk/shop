# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#Change colour to darker and back
$(document).on('turbolinks:load', ->
  $(".custom_edit_form").hide();
  $(".custom_edit_form").find(".custom_error_field").hide();

  get_text = (label_tag, event) ->
    $(event.target.parentNode).siblings().find(label_tag).text();

  set_input_val = (form_class, input_tag, text) ->
    $(form_class).find(input_tag).val(text);

  add_row = (colls_count, table) ->
    $(table).append("<tr class='custom_row'></tr>");
    $(table+" tr:last-child").append(
      for i in [1..colls_count]
        "<td class='custom_category_field'></td>"
    );

  edit_field = (table,num) ->
    $(table).find("tr").last().find("td").eq(num)

  add_data_to_row = (table_selector,url) ->
    cols = $(table_selector).find("tr").last().children(".custom_category_field")
    $.ajax(
      url: url
      type: 'get'
      success: (response) ->
        resp = JSON.parse(response)
        console.log(resp)
        for i in [0..response.length-2]
          $('.custom_table tr:last td').eq(i).append("<p class='"+Object.keys(resp)[i]+"'>"+Object.values(resp)[i]+"</p>")
        edit_field('.custom_table', -2).empty()
        edit_field('.custom_table', -2).append("<img src='"+resp.image.thumb.url+"'>")
        edit_field('.custom_table', -1).empty()
        edit_field('.custom_table', -1).append("<button type=\"button\" class=\"custom_purple_btn\">Edit</button>")
        edit_field('.custom_table', -1).append("<button type=\"button\" class=\"custom_purple_btn\">Delete</button>")
   )

  edit_data_in_row = (id, event, for_param="id") ->
    cols = $(".custom_table").find("p[class='"+for_param+"']:contains('"+id+"')").parent().siblings()
    $.ajax(
      url: 'products/show'
      type: 'get'
      data: {id: id}
      success: (response) ->
        console.log(response)
        resp = JSON.parse(response)

        for i in [0..cols.length-2]
          edit_field('.custom_table', i).empty()
          $('.custom_table tr:last td').eq(i).append("<p class='"+Object.keys(resp)[i]+"'>"+Object.values(resp)[i]+"</p>")
          edit_field('.custom_table', -2).empty()
        edit_field('.custom_table', -2).append("<img src='"+resp.image.thumb.url+"'>")
    )

  $('.custom_category_field').on('mouseover', (event) ->
    $(event.target.closest('.row')).css('background-color', '#e2daff');
  )

  $('.custom_category_field').on('mouseout', (event) ->
    $(event.target.closest('.row')).css('background-color', 'white');
  )

  #Hide new btn and index edit form
  $('.custom_big_purple_btn').on('click', (event) ->
    event.preventDefault();
    $('.custom_big_purple_btn').hide("slow", -> $(".custom_edit_form").show("slow"));
  )

  $('#products_table button:contains("Edit")').on('click', (event) ->
    event.preventDefault();
    $('.custom_big_purple_btn').hide("slow", -> $(".custom_edit_form").show("slow"));
    set_input_val(".custom_edit_form", "input[type='hidden']", get_text("p[class='id']", event));
    set_input_val(".custom_edit_form", "input[name='name']", get_text("p[class='name']", event));
    set_input_val(".custom_edit_form", "input[name='price']", get_text("p[class='price']", event));
    set_input_val(".custom_edit_form", "textarea[name='description']", get_text("p[class='description']", event));
    set_input_val(".custom_edit_form", "select[name='category_id']", get_text("p[class='category_id']", event));
  )

#Hide edit form and index new btn
  $('#products_table').find("input[value='Save']").on('click', (event) ->
    event.preventDefault();
    $('.custom_big_purple_btn').hide("slow", -> $(".custom_edit_form").show("slow"));
    id_value = $(event.target.parentNode).find("input[type='hidden']").val()
    name_value = $('.custom_edit_form input[name="name"]').val()
    price_value = $('.custom_edit_form input[name="price"]').val()
    description_value = $('.custom_edit_form textarea[name="description"]').val()
    category_value = $('.custom_edit_form select[name="category_id"]').val()
    data = new FormData()
    data.append('name', name_value)
    data.append('price', price_value)
    data.append('description', description_value)
    data.append('category_id', category_value)
    $.each($("#image_field")[0].files, (i, file) ->
      data.append('image', file))

    edit_data = new FormData()
    edit_data.append('id', id_value)
    edit_data.append('name', name_value)
    edit_data.append('price', price_value)
    edit_data.append('description', description_value)
    edit_data.append('category_id', category_value)
    $.each($("#image_field")[0].files, (i, file) ->
      edit_data.append('image', file))

    if !$(event.target.parentNode).find("input[type='hidden']").val().trim().length
      $.ajax(
        url: 'products'
        type: 'post'
        data: data
        contentType: false
        processData: false
        cache: false
        success: ->
          $(".custom_edit_form").hide("slow", -> $('.custom_big_purple_btn').show("slow"))
          add_row(7, ".table")
          add_data_to_row('.table', 'products/newest')
          $(".edit_form").find(".custom_error_field").hide();
        error: (responce, json) ->
          $(".custom_edit_form").find(".custom_error_field").show("slow")
          $(".custom_edit_form").find(".custom_error_field").find("p").text(responce)
      )
    else
      $.ajax(
        url: 'products'
        type: 'post'
        method: 'PATCH'
        data: edit_data
        contentType: false
        processData: false
        cache: false
        error: (xhr, ajaxOptions, error) ->
          responce = JSON.parse(xhr.responseText)
          errors_log=Object.entries(responce.errors)
          $(".custom_edit_form").find(".custom_error_field").show("slow")
          for i in [0..errors_log.length-1]
            for j in [0..Object.values(errors_log[i])[1].length-1]
              $(".custom_edit_form").find(".custom_error_field").append("<p>"+Object.values(errors_log[i])[0]+" "+Object.values(errors_log[i])[1][j]+"</p>")
        success: ->
          $(".custom_edit_form").hide("slow", -> $('.custom_big_purple_btn').show("slow"))
          new_image = $.get()
          edit_data_in_row(id_value,event)
          $(".custom_edit_form").find(".custom_error_field").hide();
      )
  );

#Delete row
  $('#products_table').find("button:contains('Delete')").on('click', (event) ->
    if confirm("Are you sure?")
      $.ajax({
        url: 'products'
        type: 'post'
        method: 'DELETE'
        success: $(event.target.closest('.custom_row').remove())
        data: {id: get_text("p[class='id']", event)}
      })
    event.preventDefault();
  )


#=======================================================================================================

  $('#categories_table').find("button:contains('Edit')").on('click', (event) ->
    event.preventDefault();
    $('.custom_big_purple_btn').hide("slow", -> $(".custom_edit_form").show("slow"));
    set_input_val(".custom_edit_form", "input[type='hidden']", get_text("p[class='show_id']", event));
    set_input_val(".custom_edit_form", "input[name='name']", get_text("p[class='show_name']", event));
    set_input_val(".custom_edit_form", "input[name='priority']", get_text("p[class='show_priority']", event));
  )

  #Hide edit form and index new btn
  $('#categories_table').find("input[value='Save']").on('click', (event) ->
    event.preventDefault();
    $('.custom_big_purple_btn').hide("slow", -> $(".custom_edit_form").show("slow"));
    id_value = $(event.target.parentNode).find("input[type='hidden']").val()
    name_value = $('.custom_edit_form input[name="name"]').val()
    priority_value = $('.custom_edit_form input[name="priority"]').val()
    if !id_value.trim().length
      $.ajax(
        url: 'categories'
        type: 'post'
        data: {
          name: name_value
          priority: priority_value
        }
        success: ->
          $(".custom_edit_form").hide("slow", -> $('.custom_big_purple_btn').show("slow"))
          add_row(4, ".table")
          add_data_to_row('.table', 'categories/newest')
          $(".custom_edit_form").find(".custom_error_field").hide();
        error: (responce, json) ->
          $(".custom_edit_form").find(".custom_error_field").show("slow")
          $(".custom_edit_form").find(".custom_error_field").find("p").text(responce)
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
          $(".custom_edit_form").find(".custom_error_field").show("slow")
          for i in [0..errors_log.length-1]
            for j in [0..Object.values(errors_log[i])[1].length-1]
              $(".custom_edit_form").find(".custom_error_field").append("<p>"+Object.values(errors_log[i])[0]+" "+Object.values(errors_log[i])[1][j]+"</p>")
        success: ->
          $(".custom_edit_form").hide("slow", -> $('.custom_big_purple_btn').show("slow"))
          data = [id_value, name_value, priority_value]
          edit_data_in_row(data, event, "show_id")
          $(".custom_edit_form").find(".custom_error_field").hide();
      )
  );

#Delete row
  $('#categories_table').find("button:contains('Delete')").on('click', (event) ->
    if confirm("Are you sure?")
      $.ajax({
        url: 'categories'
        type: 'post'
        method: 'DELETE'
        success: $(event.target.closest('.custom_row').remove())
        data: {id: get_text("p[class='show_id']", event)}
      })
    event.preventDefault();
  )
);
