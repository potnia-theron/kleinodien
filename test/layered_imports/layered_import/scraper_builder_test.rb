require "test_helper"
require "minitest/mock"

class LayeredImport::ScraperBuilderTest < ActiveSupport::TestCase
  test "#always" do
    scraper = LayeredImport::ScraperBuilder.build do |builder|
      builder.always(:nix)
      builder.always(:something, "else")
    end

    data = {}
    assert_nil scraper.get(:nix, data)
    assert "else", scraper.get(:something, data)
  end

  test "#callback" do
    scraper = LayeredImport::ScraperBuilder.build do |builder|
      builder.callback(:call_me, ->(data) { data.number })
    end

    data = Minitest::Mock.new
    data.expect :number, "3-6, 2-4, 3-6"

    assert_equal "3-6, 2-4, 3-6", scraper.get(:call_me, data)
  end

  test "#dig" do
    scraper = LayeredImport::ScraperBuilder.build do |builder|
      builder.dig(:title)
      builder.dig(:not_so_deep, :shallow)
      builder.dig(:deep, :deep, :deeper, :deepest)
    end

    data = {
      title: "Hello Scraper",
      shallow: "Hello Puddle",
      deep: {deeper: {deepest: "Welcome to Hell"}}
    }

    assert "Hello Scraper", scraper.get(:title, data)
    assert "Hello Puddle", scraper.get(:not_so_deep, data)
    assert "Welcome to Hell", scraper.get(:deep, data)
  end
end
