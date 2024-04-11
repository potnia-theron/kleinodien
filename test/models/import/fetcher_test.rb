require "test_helper"
require "minitest/mock"

class Import::FetcherTest < ActiveSupport::TestCase
  setup do
    @factory = Minitest::Mock.new
    @factory.expect :max_tries, 1

    @fetcher = Import::Fetcher.new(factory: @factory, uri: "https://example.com")
  end

  test "attempt.get returns a response" do
    attempt = Minitest::Mock.new
    attempt.expect :get, :fake_response, ["https://example.com"]

    @factory.expect :build_attempt, attempt
    @factory.expect :transform_response, :fake_parsed_response, [:fake_response]
    assert_equal @fetcher.get, :fake_parsed_response

    attempt.verify
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
