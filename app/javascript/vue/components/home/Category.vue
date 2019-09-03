<template>
   <li class="list-group-item list-group-item-action"
       v-bind:id="getId(category_data.id)"
       v-on:click.prevent="categoryClicked(category_data.id)"
       v-bind:class="{active: category_data.active}"
   >{{ category_data.name }}</li>

</template>

<script>
    export default {
        name: "category_card",
        props: ['category_data'],
        methods:{
            categoryClicked: function (id) {
                return this.$emit('category-clicked', id)
            },
            getId: function (id) {
                return id + '_category'
            }
        }
    }
</script>