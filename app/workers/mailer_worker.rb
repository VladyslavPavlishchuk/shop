# frozen_string_literal: true

class MailerWorker
  include Sidekiq::Worker

  def perform(user, order, status)
    UserMailer.with(user: user, order: order, status: status).order_change_status_email(user: user, order: order, status: status).deliver_now
  end
end
