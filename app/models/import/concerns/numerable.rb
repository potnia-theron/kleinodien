module Import::Concerns
  module Numerable
    extend ActiveSupport::Concern

    def consecutive_number
      options[:consecutive_number]
    end
  end
end
