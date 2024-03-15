module Import::Concerns
  module CodeFindable
    extend ActiveSupport::Concern

    # def find_by_intrinsic_code
    def find_by_cheap_codes
      return unless intrinsic_codes.any?

      model_class.find_by(intrinsic_codes)
    end

    # def find_by_all_codes
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
