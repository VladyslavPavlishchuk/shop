<template>
    <% products.each_with_index do |product,i|%>
    <div class="row mb-4">
        <div class="col-10">
            <div class="card mb-3 border-0" >
                <div class="row no-gutters">
                    <div class="col-md-5">
                        <img v-bind:src="product.image.url" class="card-img-top h-100">
                    </div>
                    <div class="col-md-7">
                        <div class="card-body">
                            <span class="d-none" id="ordered_product_id"><%= ordered_products[i].id %></span>
                            <span class="d-none" id="order_id"><%= order.id %></span>
                            <h5 class="card-title"><%= product.name %></h5>
                            <p class="card-text d-inline"><%= product.description %></p>
                            <div class="card-footer">
                                <small data-name="displayed_price">$<%= ordered_products[i].price %></small> x <small data-name="displayed_quontity"><%= ordered_products[i].quontity %></small>
                                <% if ordered_products[i].discount %>
                                <small data-name="discount" data-type="<%= ordered_products[i].discount.amount_type %>">-  <%= ordered_products[i].discount.amount %> </small>
                                <% if ordered_products[i].discount.amount_type == "percent" %>
                                <small data-name="total_price">% = $<%= OrderedProduct::CalculateFinalPrice.(ordered_product: ordered_products[i])["final_price"] %></small>
                                <% else %>
                                <small data-name="total_price">$ = $<%= OrderedProduct::CalculateFinalPrice.(ordered_product: ordered_products[i])["final_price"] %></small>
                                <% end %>
                                <% else %>
                                <small data-name="total_price"> = $<%= OrderedProduct::CalculateFinalPrice.(ordered_product: ordered_products[i])["final_price"] %></small>
                                <% end %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-2 d-flex justify-content-center align-items-center">
            <input type="number" value="1" min="1" max="100" class="form-control">
            <button type="button" class="close align-self-start" aria-label="Remove_ordered_product">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </div>
    <% end %>
</template>

<script>
    export default {
        name: "card",
        props: ['products_data','order_data'],
        methods: {
            quontityChanged: function (id) {
                return this.$emit('quontity-changed', id)
            }
        }
    }
</script>