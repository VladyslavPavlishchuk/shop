# frozen_string_literal: true

ActiveAdmin.register Category do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :priority
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

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

  #set priorities in line
  action_item :order_priorities do
    link_to 'Order priorities','order_categories', data: {:confirm => "Are you sure?" }
  end

end
