module Import
  class ParticipantFinder
    include Concerns::CodeFindable
    # include Import::Concerns::CodeFindable

    def initialize(order, facade:)
      @order = order
      @facade = facade
    end

    attr_reader :facade, :order
    # delegate :model_class, to: :order

    def find
      find_by_cheap_codes || find_by_codes
    end
  end
end
