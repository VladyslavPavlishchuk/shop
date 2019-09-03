<template>
    <div class="card mb-3 border-0" style="max-width: 400px;">
        <div class="row no-gutters w-100">
            <div class="col-md-5" style="background: #868e96;">
                <img v-bind:src="product_data.image.thumb.url" class="card-img-top">
            </div>
            <div class="col-md-7">
                <div class="card-body">
                    <h5 class="card-title">{{ product_data.name }}</h5>
                    <p class="card-text d-inline">$ {{ product_data.price }}</p>
                    <a href="#" class="btn btn-primary stretched-link d-inline float-right" v-on:click.prevent="btnPressed(product_data.id)">+</a>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "product_card",
        props: ['product_data'],
        methods:{
            btnPressed: function (id) {
                return this.$emit('add-btn-clicked', id)
            }
        }
    }
</script>