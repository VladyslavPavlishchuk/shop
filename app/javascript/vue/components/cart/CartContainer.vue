<template>
    <div class="row">
        <card_container v-if="order" v-bind:ordered_products = 'currentData'
                        v-on:remove-pressed="removeFromOrder"
                        v-on:next-clicked="nextClicked"
                        v-on:cancel-clicked="cancelClicked"
                        v-on:quontity-pressed="changeQuontity"></card_container>
        <summary_price v-bind:ordered_products = 'currentData'></summary_price>
    </div>
</template>

<script>
    import Vue from 'vue/dist/vue.esm'
    import card_container from './CardContainer.vue'
    import summary_price from './Summary.vue'

    export default {
        data: function () {
            return{
                currentData: null
            }
        },
        beforeMount: function () {
            const self = this;
            this.ordered_products.forEach(function (ordered_product) {
                ordered_product.product = self.products.find(function (product) {
                    if (product.id === ordered_product.product_id)
                        return product
                })
                ordered_product.discount = self.discounts.find(function (discount) {
                    if (discount && discount.id === ordered_product.discount_id)
                        return product
                })
            })
            this.currentData = this.ordered_products
        },
        components: {
            card_container,
            summary_price},
        name: 'cart_container',
        props: ['products','order','ordered_products','discounts'],
        methods:{
        removeFromOrder: function(id) {
            self = this
            $.ajax({
                url: 'cart/remove_product',
                type: 'post',
                method: 'delete',
                data: {id: id, authenticity_token: $('meta[name="csrf-token"]').attr('content')},
                success() {
                    self.ordered_products.splice(self.getProductIdInArray(self.ordered_products,id),1)
                    self.currentData = self.ordered_products
                }
            })},
            getProductIdInArray: function(array, id){
                array.find(function(product,index){
                    if (product.id == id)
                        return index
                })
            },
            nextClicked: function() {
                const self = this
                $.ajax({
                url: 'order/submit',
                type: 'post',
                method: 'patch',
                data: {order_id: self.order.id, quontities:self.ordered_products.map(function (ordered_product) {
                    return ordered_product.quontity
                }) , authenticity_token: $('meta[name="csrf-token"]').attr('content')}
            })},
            cancelClicked: function() {
                const self = this
                $.ajax({
                url: 'order/delete',
                type: 'post',
                method: 'delete',
                data: {order_id: self.order.id, authenticity_token: $('meta[name="csrf-token"]').attr('content')}
            })},
            changeQuontity:function (val,id) {
                this.ordered_products.find(function (ordered_product) {
                    if(ordered_product.id == id)
                        ordered_product.quontity = val
                })
                this.currentData = this.ordered_products
            }

    }

    }

</script>