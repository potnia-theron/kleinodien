module LayeredImport::Concerns
  module Scrapeable
    extend ActiveSupport::Concern

    delegate :get, to: :scraper
    delegate :get_many, to: :scraper
  end
end
