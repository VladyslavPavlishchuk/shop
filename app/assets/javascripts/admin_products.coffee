# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#Change colour to darker and back
$(document).on('turbolinks:load', ->
  $(".edit_form").hide();

  get_text = (label_tag, event) ->
    $(event.target.parentNode).siblings().find(label_tag).text();

  set_input_val = (form_class, input_tag, text) ->
    $(form_class).find(input_tag).val(text);

  add_row = (colls_count, table) ->
    $(table).append("<tr class='row'></tr>");
    $(table+" tr:last-child").append(
      for i in [0..colls_count]
        "<td class='category_field'></td>"
    );

  add_data_to_row = (table_selector) ->
    cols = $(table_selector).find("tr").last().children(".category_field")
    $.ajax(
      url: 'products'
      type: 'get'
      data:
      success: (response) ->
        alert(response)
    )

  $('.category_field').on('mouseover', (event) ->
    $(event.target.closest('.row')).css('background-color', '#e2daff');
  )

  $('.category_field').on('mouseout', (event) ->
    $(event.target.closest('.row')).css('background-color', 'white');
  )

  #Hide new btn and show edit form
  $('.big_purple_btn').add("input[value='Edit']").on('click', (event) ->
    event.preventDefault();
    $('.big_purple_btn').hide("slow", -> $(".edit_form").show("slow"));
  )

  $("input[value='Edit']").on('click', (event) ->
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
  $("input[value='Save']").on('click', (event) ->
    event.preventDefault();
    name_value = $('.edit_form').find("input[name='name']").val()
    price_value = $('.edit_form').find("input[name='price']").val()
    description_value = $('.edit_form').find("textarea[name='description']").val()
    category_value = $('.edit_form').find("select[name='category_id']").val()
    if !get_text("input[type='hidden']", event).trim().length
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
          add_data_to_row('.table')
      )
  );

#Delete row
  $("input[value='Delete']").on('click', (event) ->
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
);