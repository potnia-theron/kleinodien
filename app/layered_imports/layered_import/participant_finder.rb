module LayeredImport
  class ParticipantFinder
    include Concerns::CodeFindable

    def initialize(order, facade:)
      @session = session
      @facade = facade
    end

    attr_reader :facade, :order
    delegate :model_class, to: :order

    def find
      find_by_cheap_codes || find_by_codes
    end
  end
end
