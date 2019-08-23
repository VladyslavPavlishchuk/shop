/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS202: Simplify dynamic range loops
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
//= import 'popper'
//= import 'bootstrap'
//= import 'bootstrap-sprockets'
//= import 'jquery3'
//= import 'rails-ujs'
//= import 'jquery.remotipart'
//= import 'activestorage'

const get_closest_field = (event, field) => $(event.target).closest('.row.mb-4').find(field);

const sum_fields = function(fields) {
    let sum=0;
    for (let i = 0, end = fields.length-1, asc = 0 <= end; asc ? i <= end : i >= end; asc ? i++ : i--) {
        sum = parseInt(sum,10) + parseInt(fields.eq(i).text().replace( /^\D+/g, ''),10);
    }
    return sum;
};

const set_sum = function() {
    const sum = sum_fields($('[data-name="total_price"]'));
    $('#subtotal').text(sum);
    return $('#total').text(sum);
};

$(document).on('turbolinks:load', function() {
    set_sum();

    $('#products_window').on('click', 'a:contains(+)',function(event) {
        event.preventDefault();
        return $.ajax({
            url:'/current',
            type: 'get',
            success(result) {
                return $.ajax({
                    url: 'ordered_products',
                    type: 'post',
                    data: {id: result.id, product_id: $(event.target.parentNode).find('.invisible').text()},
                    success() {
                        $(event.target).addClass('disabled');
                        if ($('#navigation_menu .badge').hasClass('invisible')) {
                            return $('#navigation_menu .badge').removeClass('invisible');
                        } else {
                            return $('#navigation_menu .badge').text(parseInt($('#navigation_menu .badge').text(),10)+1);
                        }
                    }
                });
            }
        });
    });

    $('[aria-label="Remove_ordered_product"]').on('click', event => $.ajax({
        url: 'cart/remove_product',
        type: 'post',
        method: 'delete',
        data: {id: get_closest_field(event,'#ordered_product_id').text()},
        success() {
            $(event.target).closest(".row.mb-4").remove();
            $('#subtotal').text(parseInt($('#total').text().replace( /^\D+/g, ''),10)-parseInt(get_closest_field(event,'[data-name="total_price"]').text().replace( /^\D+/g, ''),10));
            return $('#total').text(parseInt($('#total').text().replace( /^\D+/g, ''),10)-parseInt(get_closest_field(event,'[data-name="total_price"]').text().replace( /^\D+/g, ''),10));
        }
    }));

    $("[type='number']").keypress( evt => evt.preventDefault());

    $("[type='number']").on('change', function() {
        let rezult;
        const quontity = get_closest_field(event,'[data-name="displayed_quontity"]');
        const total = get_closest_field(event, '[data-name="total_price"]');
        const price = get_closest_field(event, '[data-name="displayed_price"]');
        const discount = get_closest_field(event, '[data-name="discount"]');
        quontity.text($(event.target).val());

        if (!get_closest_field(event,'[data-name="discount"]').length) {
            total.text(' = $'+(parseInt(price.text().replace( /^\D+/g, ''),10) * $(event.target).val()));
        }

        if (get_closest_field(event, '[data-type="fixed"]').length) {
            rezult = (parseInt(price.text().replace( /^\D+/g, ''),10)*quontity.text()) - parseInt(discount.text().replace( /^\D+/g, ''),10);
            total.text("$ = $"+rezult);
        } else if (get_closest_field(event, '[data-type="percent"]').length) {
            rezult = (parseInt(price.text().replace( /^\D+/g, ''),10)*quontity.text()) - (((parseInt(price.text().replace( /^\D+/g, ''),10)*quontity.text()) / 100) * parseInt(discount.text().replace( /^\D+/g, ''),10));
            total.text("% = $"+rezult);
        }

        return set_sum();
    });

    $('button:contains("Next")').on('click', () => $.ajax({
        url: 'order/submit',
        type: 'post',
        method: 'patch',
        data: {order_id: $('#order_id').text(), quontities: $('input[type="number"]').map( (key, value) => value.value).get()}
}));

    return $('button:contains("Cancel")').on('click', () => $.ajax({
        url: 'order/delete',
        type: 'post',
        method: 'delete',
        data: {order_id: $('#order_id').text()}
    }));
});
