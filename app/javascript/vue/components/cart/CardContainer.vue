<template>
    <div class="col-9">
        <div class="row border-bottom mr-1">
            <div class="col-12">
                <h3 class="text-muted">Shopping cart</h3>
            </div>
        </div>
        <card product_data="product" order_data="order" v-for="product in products" v-if="content.order"></card>
        <div class='w-100 h-100' v-else>
            <h2> No orders </h2>
            <h5 class="text-secondary"> Please, choose something </h5>
        </div>
        <div class="row border-top mb-5 pt-3">
            <div class="col-12" v-if="content.order">
                <button type="button" class="btn btn-primary w-25">Next</button>
                <button type="button" class="btn btn-light w-25 ml-3">Cancel</button>
            </div>
        </div>
    </div>
</template>

<script>
    import card from './Card.vue'

    export default {
        name: "card_container",
        props: ['products','order'],
        components: {card},
        methods: {
            quontityChanged: function (id) {
                return this.$emit('quontity-changed', id)
            }
        }
    }
</script>
