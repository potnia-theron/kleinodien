require "test_helper"
require "minitest/mock"

class FakeFaradayAttemptInterrupter
  def initialize(analyze = true)
    @analyze = analyze
  end

  attr_accessor :analyze

  def analyze?(_)
    analyze
  end

  def perform = nil
end

class FakeFaradayAttemptFactory
  def initialize(interrupter = FakeFaradayAttemptInterrupter.new)
    @interrupter = interrupter
  end

  attr_reader :interrupter

  def connection
    Object.new.then do |connection|
      connection.define_singleton_method(:get) { |uri_string| uri_string }
      connection
    end
  end
end

class Import::FaradayAttemptTest < ActiveSupport::TestCase
  setup do
    @factory = ::FakeFaradayAttemptFactory.new
    @attempt = Import::FaradayAttempt.new(@factory)
  end

  test "get when interrupter.analyze? returns true" do
    assert_equal @attempt.get("https://example.com"), "https://example.com"
  end

  test "get when interrupter.analyze? returns false" do
    @factory.interrupter.analyze = false
    assert_nil @attempt.get("https://example.com")
  end

  test "get when interrupter.analyze? returns nil" do
    @factory.interrupter.analyze = nil
    assert_nil @attempt.get("https://example.com")
  end
end
