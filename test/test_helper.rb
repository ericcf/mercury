ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

# use the RR mock framework
class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end

# Transactional fixtures do not work with Selenium tests, because Capybara
# uses a separate server thread, which the transactions would be hidden
# from. We hence use DatabaseCleaner to truncate our test database.
DatabaseCleaner.strategy = :truncation

# specify the javascript driver for integration tests
Capybara.javascript_driver = :webkit
#Capybara.register_driver :selenium do |app| Capybara::Selenium::Driver.new(app, :browser => :chrome) end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Stop ActiveRecord from wrapping tests in transactions
  self.use_transactional_fixtures = false

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end
end
