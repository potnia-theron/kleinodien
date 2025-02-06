require "test_helper"
require "minitest/mock"

class LayeredImport::ScraperArchitectTest < ActiveSupport::TestCase
  test "#always" do
    scraper_builder = LayeredImport::ScraperArchitect.build do
      always(:nix)
      always(:something, "else")
    end

    facade = Minitest::Mock.new
    scraper = scraper_builder.build(facade)

    assert_nil scraper.get(:nix)
    assert "else", scraper.get(:something)

    facade.verify
  end

  test "#callback" do
    scraper_builder = LayeredImport::ScraperArchitect.build do
      callback(:call_me, ->(facade) { facade.number })
    end

    facade = Minitest::Mock.new
    scraper = scraper_builder.build(facade)

    facade.expect :number, "3-6, 2-4, 3-6"

    assert_equal "3-6, 2-4, 3-6", scraper.get(:call_me)

    facade.verify
  end

  test "#dig" do
    scraper_builder = LayeredImport::ScraperArchitect.build do
      dig(:title)
      dig(:not_so_deep, :shallow)
      dig(:deep, :deep, :deeper, :deepest)
    end

    facade = Minitest::Mock.new
    scraper = scraper_builder.build(facade)

    facade.expect :data, {title: "Hello Scraper"}
    assert "Hello Scraper", scraper.get(:title)

    facade.expect :data, {shallow: "Hello Puddle"}
    assert "Hello Puddle", scraper.get(:not_so_deep)

    facade.expect :data, {deep: {deeper: {deepest: "Welcome to Hell"}}}
    assert "Welcome to Hell", scraper.get(:deep)

    facade.verify
  end
end
