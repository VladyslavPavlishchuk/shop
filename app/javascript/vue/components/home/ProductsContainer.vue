<template>
    <div class="col-10" id="products_container">
        <div class="row">
            <div class="col-6" v-for="product in products">
                <product_card v-bind:product_data="product"  v-on:add-btn-clicked="btnPressed"></product_card>
            </div>
        </div>
    </div>
</template>
<script>

    import product_card from './Product.vue'
    export default {
        name: "products-container",
        props:['products'],
        components: {product_card},
        methods:{
            btnPressed: function (id) {
                return this.$emit('add-clicked', id)
            }
        },
        mounted: function () {
            console.log("mounted")
        }
    }
</script>