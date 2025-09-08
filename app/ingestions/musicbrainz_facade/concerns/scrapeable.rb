module MusicbrainzFacade::Concerns
  module Scrapeable
    extend ActiveSupport::Concern

    delegate :scrape, to: :scraper
    delegate :scrape_many, to: :scraper

    def scraper
      @scraper ||= scraper_builder.call(self)
    end
  end
end
