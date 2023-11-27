require "test_helper"
require "minitest/mock"

class FakeFactory
  def max_tries = 1

  attr_accessor :connection
end

class Import::FetcherTest < ActiveSupport::TestCase
  setup do
    @factory = FakeFactory.new
    @fetcher = Import::Fetcher.new(factory: @factory, uri: "https://example.com")
  end

  test "get" do
    response = Minitest::Mock.new
    response.expect :success?, true
    response.expect :body, {test: "success"}.to_json

    connection = Minitest::Mock.new
    connection.expect :get, response

    @factory.connection = connection

    assert_equal @fetcher.get, {test: "success"}.to_json

    connection.verify
    response.verify
  end
end
