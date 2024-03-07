module Import
  class FindParticipant
    # Does not need a session,
    # all calls to external apis are done by the facade
    def initialize(session, facade:)
      @session = session
      @facade = facade
    end

    attr_reader :facade, :session

    # model ????

    def call
      find_by_intrinsic_code || find_by_all_codes
    end

    def find_by_intrinsic_code
      search_attribibutes = facade.intrinsic_code
      return unless search_attribibutes
      facade.model_class.find_by(search_attribibutes)
    end

    def find_by_all_codes
      search_attribibutes = facade.all_codes
      return unless search_attribibutes.any?

      first_pair = search_attribibutes.shift
      query = Participant.where(first_pair.first => first_pair.second)
      search_attribibutes.each do |attr, code_value|
        query = query.or(Participant.where(attr => code_value))
      end

      result = query.load
      return unless result.any?
      raise "Too much reslts" if result.length != 1

      result.first
    end
  end
end
