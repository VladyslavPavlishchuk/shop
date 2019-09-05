<template>
    <div class="row" id="shop_container" >
        <categories_container v-bind:categories="currentCategories" v-on:category-changed="showProductsFromCategory"></categories_container>
        <products_container v-bind:products="currentProducts" v-on:add-clicked="addToCart" id="products_container"></products_container>
    </div>
</template>

<script>

    import Vue from 'vue/dist/vue.esm'
    import products_container from './ProductsContainer.vue'
    import categories_container from './CategoriesContainer.vue'

    export default {
        data: function() {
            return {
                currentProducts: null,
                currentCategories: null
            }
        },
        components: {
            products_container,
            categories_container},
        name: "shop-container",
        props: ['categories', 'products'],
        beforeMount: function () {
            this.currentProducts = this.products
            this.categories.forEach(function (category, index) {
                category.active = index === 0
            })
            this.currentCategories = this.categories
        },
        methods:{
            addToCart: function (product_id) {
                return $.ajax({
                    url:'/current',
                    type: 'get',
                    success(result) {
                        return $.ajax({
                            url: 'ordered_products',
                            type: 'post',
                            data: {id: result.id, product_id: product_id, authenticity_token: $('meta[name="csrf-token"]').attr('content')},
                            success() {
                                if ($('#navigation_menu .badge').hasClass('invisible')) {
                                    return $('#navigation_menu .badge').removeClass('invisible');
                                } else {
                                    return $('#navigation_menu .badge').text(parseInt($('#navigation_menu .badge').text(),10)+1);
                                }
                            }
                        });
                    }
                });
            },

            showProductsFromCategory: function (category_id) {
                const self = this;
                $.ajax({
                    url: 'pages/products',
                    type: 'get',
                    data: {id: category_id},
                    dataType: 'json',
                    success(data) {
                        self.currentCategories = self.currentCategories.map(function (category) {
                            category.active = category.id === category_id;
                            return category
                        });
                        self.currentProducts=data.products
                    }
                })
            }
        }
    }
</script>
