# frozen_string_literal: true

ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :id, :user_id, :status, ordered_products_attributes: [:id, :order_id, :product_id, :discount_id, :quontity, :price, :_destroy]
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  #remove Create new buttor
  actions :all, :except => [:new]


  # edit filters
  preserve_default_filters!
  remove_filter :ordered_products
  filter :products, label: "Present product", collection: ->{
    OrderedProduct.all.map{ |ordered| ordered.product}
  }

  #edit page
  form do |f|
    f.inputs "Details" do
      f.input :user
      f.input :status, label: "Status:"
    end
    f.inputs do
      f.has_many :ordered_products, heading: "Products in order",
                 allow_destroy: true do |a|
        a.input :product
        a.input :discount_id
        a.input :quontity
        a.input :price
      end
    end
    f.actions
  end

  #scv file generation
  csv do
    column :id, label: "Order id:"
    column(:products) { |order| order.ordered_products.map { |ordered_product| "#{ordered_product.product.name} - #{OrderedProduct::CalculateFinalPrice.(ordered_product: ordered_product)["final_price"]}$" }.join("/") }
  end


  #sendeng mail on order status change
  controller do
    def update(options = {}, &block)
      order = Order.find(params[:id])

      unless order.status == params[:order][:status]
        MailerWorker.perform_async(current_user.email, order.id, params[:order][:status])
      end

      super do |success, failure|
        block.call(success, failure) if block
        failure.html { render :edit }
      end
    end
  end
end
