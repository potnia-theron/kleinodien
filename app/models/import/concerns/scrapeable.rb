module Import::Concerns
  module Scrapeable
    extend ActiveSupport::Concern

    delegate :get, to: :scraper
    delegate :get_many, to: :scraper

    def scraper
      # @scraper ||= scraper_builder.build(self)
      @scraper ||= scraper_builder.call(self)
    end
  end
end
