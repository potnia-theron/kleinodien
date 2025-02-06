require "test_helper"
require "minitest/mock"

class LayeredImport::ScraperBuilderTest < ActiveSupport::TestCase
  test "#always" do
    scraper = LayeredImport::ScraperBuilder.build do
      always(:nix)
      always(:something, "else")
    end

    facade = Minitest::Mock.new

    assert_nil scraper.get(:nix, facade)
    assert "else", scraper.get(:something, facade)

    facade.verify
  end

  test "#callback" do
    scraper = LayeredImport::ScraperBuilder.build do
      callback(:call_me, ->(facade) { facade.number })
    end

    facade = Minitest::Mock.new
    facade.expect :number, "3-6, 2-4, 3-6"

    assert_equal "3-6, 2-4, 3-6", scraper.get(:call_me, facade)

    facade.verify
  end

  test "#dig" do
    scraper = LayeredImport::ScraperBuilder.build do
      dig(:title)
      dig(:not_so_deep, :shallow)
      dig(:deep, :deep, :deeper, :deepest)
    end

    facade = Minitest::Mock.new

    facade.expect :data, {title: "Hello Scraper"}
    assert "Hello Scraper", scraper.get(:title, facade)

    facade.expect :data, {shallow: "Hello Puddle"}
    assert "Hello Puddle", scraper.get(:not_so_deep, facade)

    facade.expect :data, {deep: {deeper: {deepest: "Welcome to Hell"}}}
    assert "Welcome to Hell", scraper.get(:deep, facade)

    facade.verify
  end
end
