module IngestionFinder::Concerns
  module CodeFindable
    extend ActiveSupport::Concern

    def find_by_cheap_codes(facade)
      codes = facade.cheap_codes
      return unless codes.any?

      model_class.find_by(codes)
    end

    def find_by_codes(facade)
      codes = facade.all_codes
      return unless codes.any?

      result = OrWithPresentValues
        .query(attributes: codes, model_class: model_class)
        .load
      return unless result.any?
      raise "Too much reslts" if result.length != 1

      result.first
    end
  end
end
