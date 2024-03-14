module Import
  class FindParticipant
    def initialize(session, facade:)
      @session = session
      @facade = facade
    end

    attr_reader :facade, :session
    delegate :model_class, to: :facade
    delegate :intrinsic_codes, to: :facade

    def properties
      @properties ||= session.build_properties(model_class)
    end

    def call
      find_by_intrinsic_code || find_by_all_codes
    end

    def find_by_intrinsic_code
      return unless intrinsic_codes.any?

      model_class.find_by(intrinsic_codes)
    end

    def find_by_all_codes
      return unless all_codes.any?

      result = OrWithPresentValues
        .query(attributes: all_codes, model_class: model_class)
        .load
      return unless result.any?
      raise "Too much reslts" if result.length != 1

      result.first
    end

    def all_codes
      attribute_names = properties.code_attribute_names
      return unless attribute_names&.any?

      attribute_names.index_with { |attr_name| facade.send(attr_name) }.compact
    end
  end
end
