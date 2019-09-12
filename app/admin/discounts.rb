# frozen_string_literal: true

ActiveAdmin.register Discount do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :amount_type, :amount, :discounted_type, :discounted_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  #edit page
  form do |f|
    f.inputs "Discounts" do
      f.input :amount_type
      f.input :amount
      f.input :discounted_type, as: :select, collection: Discount.discount_types.keys.map { |key| key.capitalize}
      f.input :discounted_id
    end
    f.actions
  end
end
