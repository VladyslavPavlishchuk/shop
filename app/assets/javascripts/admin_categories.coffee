# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#$(document).on('turbolinks:load', ->
#
#  get_label_text = (label_tag, event) ->
#    $(event.target.parentNode).siblings().find(label_tag).text();
#
#  set_input_val = (form_class, input_tag, text) ->
#    $(form_class).find(input_tag).val(text);
#
#  add_row = (colls_count, table) ->
#    $(table).append("<tr class='row'></tr>");
#    $(table+" tr:last-child").append(
#      for i in [0..colls_count]
#        "<td class='category_field'></td>"
#    );
#
#  $("input[value='Edit']").on('click', (event) ->
#    event.preventDefault();
#    $('.big_purple_btn').hide("slow", -> $(".edit_form").index("slow"));
#    if $('form[action="admin/categories"]').length
#      set_input_val(".edit_form", "input[type='hidden']", get_label_text("label[for='show_id']", event));
#      set_input_val(".edit_form", "input[name='name']", get_label_text("label[for='show_name']", event));
#      set_input_val(".edit_form", "input[name='priority']", get_label_text("label[for='show_priority']", event));
#  )
#
#  #Hide edit form and index new btn
#  $("input[value='Save']").on('click', (event) ->
#    if $('form[action="admin/categories"]').length
#      add_row(4, ".table");
#    event.preventDefault();
#  )
#);