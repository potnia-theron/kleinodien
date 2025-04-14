require "simplecov"
SimpleCov.use_merging true
SimpleCov.start "rails"

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Ensure SimpleCov works when tests run in parallel
  # https://github.com/simplecov-ruby/simplecov/issues/718#issuecomment-538201587
  parallelize_setup do |worker|
    SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
  end

  parallelize_teardown do |worker|
    SimpleCov.result
  end

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # def sign_in_as(user)
  #   post(sign_in_url, params: {email: user.email, password: "123TopSecret"})
  #   user
  # end
end
