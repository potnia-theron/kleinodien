module MusicbrainzFacade::Concerns
  module Scrapeable
    extend ActiveSupport::Concern

    delegate :scrape, to: :scraper
    delegate :scrape_many, to: :scraper

    def scraper
      @scraper ||= scraper_builder.call(self)
    end

    # TODO: find a better place for #desired_delegated_type
    def desired_delegated_type = nil
  end
end
