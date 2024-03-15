module Import
  class FindParticipant
    include Concerns::CodeFindable

    def initialize(session, facade:)
      @session = session
      @facade = facade
    end

    attr_reader :facade, :session
    delegate :model_class, to: :facade

    def properties
      @properties ||= session.build_properties(model_class)
    end

    def call
      find_by_cheap_codes || find_by_codes
    end
  end
end
