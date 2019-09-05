<template>
    <div class="row mb-4">
        <div class="col-10">
            <div class="card mb-3 border-0" >
                <div class="row no-gutters">
                    <div class="col-md-5">
                        <img v-bind:src="content.product.image.url" class="card-img-top h-100">
                    </div>
                    <div class="col-md-7">
                        <div class="card-body">
                            <h5 class="card-title">{{ content.product.name }}</h5>
                            <p class="card-text d-inline">{{ content.product.description }}</p>
                            <div class="card-footer">
                                <small data-name="displayed_price">${{ content.price }}</small> x <small>{{ quontity }}</small>
                                <small v-if="content.discount">-  {{ content.discount.amount }} </small>
                                <small data-name="total_price">{{ calculateFinalPrice(quontity) }}</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-2 d-flex justify-content-center align-items-center">
            <input type="number" value="1" min="1" max="100" class="form-control" v-on:keydown.prevent="" v-model.number="quontity" @change="quontityChanged(quontity)">
            <button type="button" class="close align-self-start" aria-label="Remove_ordered_product" v-on:click="removePressed">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </div>
</template>

<script>
    export default {
        data: function () {
            return {
                quontity: 1
            }
        },
        name: "card",
        props: ['content'],
        methods: {
            calculateFinalPrice: function (quontity) {
                const sumPrice = this.content.price * quontity
                if (this.content.discount){
                    if (isPercentDiscount){
                        return "% = $"+(sumPrice-sumPrice/100*this.content.discount.amount)}
                    else{
                        return "$ = $"+(sumPrice-this.content.discount.amount)}}
                else{
                    return " = $"+sumPrice}
            },
            isPercentDiscount: function () {
                return this.content.discount.amount_type == 'percent'
            },
            removePressed: function () {
                return this.$emit('remove-pressed', this.content.id)
            },
            quontityChanged: function (val) {
                return this.$emit('quontity-changed', val, this.content.id)
            }
        }
    }
</script>