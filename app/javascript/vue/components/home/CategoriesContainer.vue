<template>
    <div class="col-2 h-100">
        <ul class="list-group overflow-auto h-25" id="categories_list" >
            <category_card v-bind:category_data="category" v-for="category in categories" v-on:category-clicked="categoryClicked" v-bind:key="category.id +'_'+ category.active"></category_card>
        </ul>
        <div class="input-group mt-3">
            <input type="text" class="form-control" placeholder="Search">
            <div class="input-group-append">
                <button type="submit" class="btn btn-primary">Go!</button>
            </div>
        </div>
    </div>
</template>

<script>
    import category_card from './Category.vue'

    export default {
        name: "categories-container",
        props: ['categories'],
        components: {category_card},
        methods: {
            categoryClicked: function (id) {
                return this.$emit('category-changed', id)
            }
        }
    }
</script>