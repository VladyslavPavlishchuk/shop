//= import 'popper'
//= import 'bootstrap'
//= import 'bootstrap-sprockets'
//= import 'jquery3'
//= import 'rails-ujs'
//= import 'jquery.remotipart'
//= import 'activestorage'

$(document).on('turbolinks:load', () => $('#categories_list li').on('click', event => $.ajax({
    url: 'pages/products',
    type: 'get',
    data: {id: $(event.target.parentNode).find('p').text()},
    dataType: 'html',
    success(data) {
        $(event.target.parentNode.parentNode).find('li').removeClass('active');
        $(event.target).addClass('active');
        return $('#products_window').html(data);
    }
})));