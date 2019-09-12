# frozen_string_literal: true
require "simplecov"
require "vcr"
SimpleCov.start

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "faker"
require "database_cleaner"
require "webmock/minitest"
DatabaseCleaner.strategy = :transaction

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end

module AroundEachTest
  def before_setup
    super
    @product = create(:product)
    @order = create(:order)
    DatabaseCleaner.start
  end

  def after_teardown
    super
    DatabaseCleaner.clean
  end
end


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all
  include FactoryBot::Syntax::Methods
  include AroundEachTest
  # Add more helper methods to be used by all tests here...
end
