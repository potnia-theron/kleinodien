require "test_helper"
require "minitest/mock"

class FacadeScraper::BuilderTest < ActiveSupport::TestCase
  test "#define always" do
    scraper_builder = FacadeScraper::Builder.call do
      define :nix, always: nil
      define :something, always: "else"
    end

    facade = Minitest::Mock.new
    scraper = scraper_builder.call(facade)

    assert_nil scraper.scrape(:nix)
    assert "else", scraper.scrape(:something)

    facade.verify
  end

  test "#define callback" do
    scraper_builder = FacadeScraper::Builder.call do
      define :call_me, callback: ->(facade) { facade.number }
    end

    facade = Minitest::Mock.new
    scraper = scraper_builder.call(facade)

    facade.expect :number, "3-6, 2-4, 3-6"

    assert_equal "3-6, 2-4, 3-6", scraper.scrape(:call_me)

    facade.verify
  end

  test "#define dig" do
    scraper_builder = FacadeScraper::Builder.call do
      define :title
      define :not_so_deep, :shallow
      define :deep, :deep, :deeper, :deepest
    end

    facade = Minitest::Mock.new
    scraper = scraper_builder.call(facade)

    facade.expect :data, {title: "Hello Scraper"}
    assert "Hello Scraper", scraper.scrape(:title)

    facade.expect :data, {shallow: "Hello Puddle"}
    assert "Hello Puddle", scraper.scrape(:not_so_deep)

    facade.expect :data, {deep: {deeper: {deepest: "Welcome to Hell"}}}
    assert "Welcome to Hell", scraper.scrape(:deep)

    facade.verify
  end
end
