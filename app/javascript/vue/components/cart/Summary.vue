<template>
    <div class="col-3">
        <div class="navbar sticky-top w-100 pr-0">
            <div class="row w-100">
                <div class="cal-12 w-100 ">
                    <h3 class="text-muted w-100">Summary</h3>
                </div>
            </div>
            <div class="row w-100">
                <div class="cal-12 border-top border-bottom w-100">
                    <input type="text" class="form-control-plaintext font-weight-bold w-100" placeholder="ENTER COUPON CODE">
                </div>
            </div>
            <div class="row w-100">
                <div class="cal-12 border-bottom w-100">
                    <div class="row w-100 m-0">
                        <div class="col-12 w-100 p-0">
                            <p class="text-muted d-inline">SUBTOTAL</p>
                            <p class="text-muted d-inline float-right" id="subtotal">${{ sum }}</p>
                        </div>
                    </div>
                    <div class="row w-100 m-0">
                        <div class="col-12 w-100 p-0">
                            <p class="text-muted d-inline">SHIPPING</p>
                            <p class="text-muted d-inline float-right">FREE</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row w-100">
                <div class="cal-12 w-100">
                    <h3 class="text-muted d-inline">TOTAL</h3>
                    <h3 class="text-muted d-inline float-right" id="total">${{ sum }}</h3>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "summary_price",
        props: ['ordered_products'],
        computed:{
            sum: function () {
                let sum = 0;
                this.ordered_products.forEach(function(product){
                    sum += product.price * product.quontity
                })
                return sum
            }
        }
    }
</script>