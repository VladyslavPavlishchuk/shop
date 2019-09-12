# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "order_notifications@example.com"

  def order_change_status_email(params)
    @user = params[:user]
    @order = params[:order]
    @status = params[:status]
    mail(to: @user, subject: "Your order status has been changed")
  end
end
