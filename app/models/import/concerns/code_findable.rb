module Import::Concerns
  module CodeFindable
    extend ActiveSupport::Concern

    delegate :all_codes, to: :facade
    delegate :cheap_codes, to: :facade

    def find_by_cheap_codes
      return unless cheap_codes.any?

      model_class.find_by(cheap_codes)
    end

    def find_by_codes
      return unless all_codes.any?

      result = OrWithPresentValues
        .query(attributes: all_codes, model_class: model_class)
        .load
      return unless result.any?
      raise "Too much reslts" if result.length != 1

      result.first
    end
  end
end
