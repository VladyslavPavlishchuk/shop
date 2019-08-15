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

 form do |f|
  f.inputs 'Details' do

   f.input :user
   f.input :status, label: 'Status:'
  end
  f.inputs do
   f.has_many :ordered_products, heading: 'Products in order',
              allow_destroy: true do |a|
    a.input :product
    a.input :discount_id
    a.input :quontity
    a.input :price
   end
  end
  f.actions
 end
end