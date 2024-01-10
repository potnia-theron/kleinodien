require "test_helper"
require "minitest/mock"

class Import::FetcherTest < ActiveSupport::TestCase
  setup do
    @factory = Minitest::Mock.new
    @factory.expect :max_tries, 1

    @fetcher = Import::Fetcher.new(factory: @factory, uri: "https://example.com")
  end

  test "attempt.get returns a response" do
    response = Minitest::Mock.new
    response.expect :body, "response body"

    attempt = Minitest::Mock.new
    attempt.expect :get, response, ["https://example.com"]

    @factory.expect :build_attempt, attempt
    assert_equal @fetcher.get, "response body" # response

    attempt.verify
    response.verify
    @factory.verify
  end

  test "attempt.get doesn't return a response" do
    attempt = Minitest::Mock.new
    attempt.expect :get, nil, ["https://example.com"]

    @factory.expect :build_attempt, attempt

    assert_raises(RuntimeError) { @fetcher.get }

    attempt.verify
    @factory.verify
  end
end
