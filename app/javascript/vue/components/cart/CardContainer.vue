<template>
    <div class="col-9">
        <div class="row border-bottom mr-1">
            <div class="col-12">
                <h3 class="text-muted">Shopping cart</h3>
            </div>
        </div>
        <card v-for="ordered_product in ordered_products" v-bind:content="ordered_product" v-on:remove-pressed="removePressed" v-on:quontity-changed="quontityChanged"></card>
        <div class="row border-top mb-5 pt-3">
            <div class="col-12">
                <button type="button" class="btn btn-primary w-25" @click.prevent="$emit('next-clicked')">Next</button>
                <button type="button" class="btn btn-light w-25 ml-3" @click.prevent="$emit('cancel-clicked')">Cancel</button>
            </div>
        </div>
    </div>
</template>

<script>
    import card from './Card.vue'
    export default {
        name: "card_container",
        props: ['ordered_products'],
        components: {card},
        methods: {
            removePressed: function (id) {
                return this.$emit('remove-pressed', id)
            },
            quontityChanged: function (val, id) {
                return this.$emit('quontity-pressed', val, id)
            }
        }
    }
</script>
