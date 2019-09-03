//= import 'popper'
//= import 'bootstrap'
//= import 'bootstrap-sprockets'
//= import 'jquery3'
//= import 'rails-ujs'
//= import 'jquery.remotipart'
//= import 'activestorage'
import 'bootstrap/dist/css/bootstrap'
require('bootstrap');
import Vue from 'vue/dist/vue.esm'
import CartContainer from '../vue/components/cart/CartContainer.vue'

document.addEventListener('DOMContentLoaded', () => {
    const node = document.getElementById('cart_container');
    const props = JSON.parse(node.getAttribute('data'));

    new Vue({
        render: h => h(CartContainer, { props })
    }).$mount('#cart_container');
});
