ActiveAdmin.register_page "General statistics" do
  content do
    panel "Products statistics" do
      table_for Product do
        products = Product.all
        categories = Category.all
        column "Products amount" do
          products.length
        end
        column "Avg product qty per category" do
          categories.map{|category| category.products.length}.sum / categories.length
        end
        column "Avg product price" do
           sprintf("%0.02f",products.average(:price))
        end
        column "Products with discount (%)" do
          products.map{|product|
            product.ordered_products.find{|ordered_product| ordered_product.discount != nil} ? product : nil.to_i
            }.sum/products.length * 100
        end
      end
    end

    panel "Users statistics" do
      table_for User do
        users = User.all
        discounts = Discount.all
        orders = Order.all
        column "Average age (since registration)" do
          "#{users.map{|user|(Date.today - user.created_at.to_date).to_i}.sum/users.length} days"
        end
        column "Average amount of completed orders (per user)" do
          users.map{|user| user.orders.map{|order| order.status == :completed ? order : nil.to_i}.sum}.sum/users.length
        end
        column "Amount of user discounts" do
          discounts.map{|discount| discount.discount_type == :user ? discount : nil.to_i}.sum
        end
        column "Average user discount per order" do
          orders.map{
              |order| order.ordered_products.map{
                |ordered_product| (ordered_product.discount && (ordered_product.discount.discount_type == :user)) ? ordered_product : nil.to_i
            }.sum
          }.sum/orders.length
        end
      end
    end

    panel "Orders statistics" do
      table_for Order do
        orders = Order.all
        column "cart" do
          orders.select{|order| order.status == 'cart' }.length
        end
        column "submitted" do
          orders.select{|order| order.status == 'submitted' }.length
        end
        column "confirmed" do
          orders.select{|order| order.status == 'confirmed' }.length
        end
        column "completed" do
          orders.select{|order| order.status == 'completed' }.length
        end
        column "canceled" do
          orders.select{|order| order.status == 'canceled' }.length
        end
      end

      table_for Order do
        orders = Order.all
        column "Discounted average price" do
          orders.map{
              |order| order.ordered_products.map{
                |ordered_product| ordered_product.discount ? OrderedProduct::CalculateFinalPrice.(ordered_product: ordered_product)["final_price"] : nil.to_i
            }.sum
          }.sum/orders.length
        end
        column "Non-discounted average price" do
          orders.map{
              |order| order.ordered_products.map{
                |ordered_product| !ordered_product.discount ? OrderedProduct::CalculateFinalPrice.(ordered_product: ordered_product)["final_price"] : nil.to_i
            }.sum
          }.sum/orders.length
        end
      end

      table_for Order do
        categories = Category.all
        column "With most ordered products (by quantity)" do
          max_val = categories.map{ |category| category.products.map{|product| product.ordered_products.map{|ordered_product| ordered_product.quontity}.sum }.sum }
          categories.find(max_val.find_index(max_val.max)+1).name
        end
        column "With most ordered products (by total price)" do
          max_price = categories.map{ |category| category.products.map{|product| product.ordered_products.map{|ordered_product| OrderedProduct::CalculateFinalPrice.(ordered_product: ordered_product)["final_price"]}.sum }.sum }
          categories.find(max_price.find_index(max_price.max)+1).name
        end
      end
    end
  end
end