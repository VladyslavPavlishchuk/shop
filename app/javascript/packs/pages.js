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
import ShopContainer from '../vue/components/home/ShopContainer.vue'

document.addEventListener('DOMContentLoaded', () => {
    const node = document.getElementById('vue_container');
    const props = JSON.parse(node.getAttribute('data'));

    // Render component with props
    new Vue({
        render: h => h(ShopContainer, { props })
    }).$mount('#vue_container');
});

