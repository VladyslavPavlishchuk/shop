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
          $('.table').find("tr").last().find("td").eq(i).append("<lable '"+Object.keys(resp)[i]+"'>"+Object.values(resp)[i]+"</lable>")
        edit_btn_field('.table').empty()
        edit_btn_field('.table').append("<input type=\"submit\" name=\"commit\" value=\"Edit\" class=\"purple_btn edit_btn\" data-disable-with=\"Edit\">")
        edit_btn_field('.table').append("<input type=\"submit\" name=\"commit\" value=\"Delete\" class=\"purple_btn\" remote=\"true\" method=\"delete\" data-disable-with=\"Delete\">")
   )

  edit_data_in_row = (data, event, for_param="id") ->
    cols = $(".table").find("label[for='"+for_param+"']:contains('"+data[0]+"')").parent().siblings()
    console.log(cols)
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

  $('#products_table').find("input[value='Edit']").on('click', (event) ->
    event.preventDefault();
    $('.big_purple_btn').hide("slow", -> $(".edit_form").show("slow"));
    if $('form[action="admin/products"]').length
      set_input_val(".edit_form", "input[type='hidden']", get_text("label[for='id']", event));
      set_input_val(".edit_form", "input[name='name']", get_text("label[for='name']", event));
      set_input_val(".edit_form", "input[name='price']", get_text("label[for='price']", event));
      set_input_val(".edit_form", "select[name='category_id']", get_text("label[for='category_id']", event));
      set_input_val(".edit_form", "textarea[name='description']", get_text("label[for='description']", event));
  )

#Hide edit form and show new btn
  $('#products_table').find("input[value='Save']").on('click', (event) ->
    event.preventDefault();
    $('.big_purple_btn').hide("slow", -> $(".edit_form").show("slow"));
    id_value = $(event.target.parentNode).find("input[type='hidden']").val()
    name_value = $('.edit_form').find("input[name='name']").val()
    price_value = $('.edit_form').find("input[name='price']").val()
    description_value = $('.edit_form').find("textarea[name='description']").val()
    category_value = $('.edit_form').find("select[name='category_id']").val()
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
          add_data_to_row('.table', 'products')
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
          console.log(responce.errors)
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

#Delete row console.log()
  $('#products_table').find("input[value='Delete']").on('click', (event) ->
    if confirm("Are you sure?")
      $.ajax({
        url: 'products'
        type: 'post'
        method: 'DELETE'
        success: $(event.target.closest('.row').remove())
        data: {id: get_text("label[for='id']", event)}
      })
    event.preventDefault();
  )


#=======================================================================================================

  $('#categories_table').find("input[value='Edit']").on('click', (event) ->
    event.preventDefault();
    $('.big_purple_btn').hide("slow", -> $(".edit_form").show("slow"));
    if $('form[action="admin/categories"]').length
      set_input_val(".edit_form", "input[type='hidden']", get_text("label[for='show_id']", event));
      set_input_val(".edit_form", "input[name='name']", get_text("label[for='show_name']", event));
      set_input_val(".edit_form", "input[name='priority']", get_text("label[for='show_priority']", event));
  )

  #Hide edit form and show new btn
  $('#categories_table').find("input[value='Save']").on('click', (event) ->
    event.preventDefault();
    $('.big_purple_btn').hide("slow", -> $(".edit_form").show("slow"));
    id_value = $(event.target.parentNode).find("input[type='hidden']").val()
    name_value = $('.edit_form').find("input[name='name']").val()
    priority_value = $('.edit_form').find("input[name='priority']").val()
    if !$(event.target.parentNode).find("input[type='hidden']").val().trim().length
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
          add_data_to_row('.table', 'categories')
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
          console.log(responce.errors)
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

#Delete row console.log()
  $('#categories_table').find("input[value='Delete']").on('click', (event) ->
    if confirm("Are you sure?")
      $.ajax({
        url: 'categories'
        type: 'post'
        method: 'DELETE'
        success: $(event.target.closest('.row').remove())
        data: {id: get_text("label[for='id']", event)}
      })
    event.preventDefault();
  )
);