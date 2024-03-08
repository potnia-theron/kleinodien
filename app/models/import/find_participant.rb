module Import
  class FindParticipant
    # Does not need a session,
    # all calls to external apis are done by the facade
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
      search_attributes = intrinsic_codes
      return unless search_attributes
      facade.model_class.find_by(search_attributes)
    end

    def find_by_all_codes
      search_attributes = all_codes
      return unless search_attributes.any?

      first_pair = search_attributes.shift
      query = Participant.where(first_pair.first => first_pair.second)
      search_attributes.each do |attr, code_value|
        query = query.or(Participant.where(attr => code_value))
      end

      result = query.load
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
