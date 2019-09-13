# frozen_string_literal: true

ActiveAdmin.register Category do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :priority, products_attributes: [:id, :name, :price, :description, :category, :image, :_destroy]
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end


  #form
  index do
    selectable_column
    column :id
    column :name
    column :priority
    column :created_at
    column :updated_at
    actions defaults: true do |category|
      item 'Show products ', admin_products_path(q: {category_id_eq: category.id}), class: 'member_link'
    end
  end

  #show page
  show do
    attributes_table do
      row :name
      row :priority
      row :created_at
      row :updated_at
    end

    panel "Statistics" do
      table_for category do
        column "Products quantity" do |category|
          category.products.length
        end
        column "Avg cost" do |category|
          category.products.average(:price)
        end
        column "Products sold from category" do |category|
          category.products.map {|product| product.ordered_products.map{|ordered_product|
            ordered_product.order.status == 'completed' ? ordered_product.quontity : nil.to_i }.sum}.sum
        end
      end
    end
  end

  #edit creation
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :priority
    end
    f.inputs do
      f.has_many :products, heading: "Products in category",
                 allow_destroy: true do |a|
        a.input :name
        a.input :price
        a.input :description
        a.input :category, selected: f.object.id
        a.input :image
      end
    end
    f.actions
  end

  #set priorities in line
  action_item :order_priorities do
    link_to 'Order priorities','order_categories', data: {:confirm => "Are you sure?" }
  end

end
