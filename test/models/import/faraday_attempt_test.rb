require "test_helper"
require "minitest/mock"

FakeFactory = Data.define(:connection, :interrupter)

class Import::FaradayAttemptTest < ActiveSupport::TestCase
  setup do
    @connection = Minitest::Mock.new
    @connection.expect :get, :fake_response, ["https://example.com"]

    @interrupter = Minitest::Mock.new
    @interrupter.expect :perform, nil

    factory = FakeFactory.new(@connection, @interrupter)

    @attempt = Import::FaradayAttempt.new(factory)
  end

  test "get when interrupter.analyze? returns true" do
    @interrupter.expect :analyze?, :fake_response, [:fake_response]

    assert_equal @attempt.get("https://example.com"), :fake_response

    @connection.verify
    @interrupter.verify
  end

  test "get when interrupter.analyze? returns false" do
    @interrupter.expect :analyze?, false, [:fake_response]

    assert_nil @attempt.get("https://example.com")

    @connection.verify
    @interrupter.verify
  end

  test "get when interrupter.analyze? returns nil" do
    @interrupter.expect :analyze?, nil, [:fake_response]

    assert_nil @attempt.get("https://example.com")

    @connection.verify
    @interrupter.verify
  end
end
