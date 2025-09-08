module IngestionFinder::Concerns
  module CodeFindable
    extend ActiveSupport::Concern

    delegate :all_codes, to: :facade
    delegate :cheap_codes, to: :facade

    def find_by_cheap_codes
      codes = facade.cheap_codes
      return unless codes.any?

      model_class.find_by(codes)
    end

    def find_by_codes
      codes = all_codes
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
