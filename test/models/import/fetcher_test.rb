require "test_helper"
require "minitest/mock"

class FakeFetcherFactory
  def max_tries = 1

  attr_accessor :attempt

  def purify(response)
    response
  end
end

class Import::FetcherTest < ActiveSupport::TestCase
  setup do
    @factory = FakeFetcherFactory.new
    @fetcher = Import::Fetcher.new(factory: @factory, uri: "https://example.com")
  end

  test "attempt.get returns a response" do
    response = Minitest::Mock.new
    response.expect :==, response, [response]

    attempt = Minitest::Mock.new
    attempt.expect :get, response, ["https://example.com"]

    @factory.attempt = attempt

    assert_equal @fetcher.get, response

    attempt.verify
    response.verify
  end

  test "attempt.get doesn't return a response" do
    attempt = Minitest::Mock.new
    attempt.expect :get, nil, ["https://example.com"]

    @factory.attempt = attempt

    assert_raises(RuntimeError) { @fetcher.get }

    attempt.verify
  end
end
