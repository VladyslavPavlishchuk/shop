# frozen_string_literal: true

ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :price, :description, :category_id, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # edit filters
  preserve_default_filters!
  filter :image_filter, label: "", as: :check_boxes, collection:[['Only with image', true]]

  #edit page
  form do |f|
    f.inputs "Products" do
      f.input :name
      f.input :price
      f.input :description
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :name
    column :price
    column :description
    column :category
    column :created_at
    column :updated_at
    column :image do |product|
      image_tag(product.image.url(:thumb))
    end
    actions
  end

  csv do
    column :id
    column :name
    column :price
    column :description
    column :category
    column :created_at
    column :updated_at
  end
end
