module IngestionFinder
  class Participant
    include Callable
    include Concerns::CodeFindable

    #  def initialize
    #   @order = order
    #   @facade = facade
    # end
    def initialize
      @factory = factory
    end

    # attr_reader :facade, :order
    attr_reader :factory

    def call(facade)
      find_by_cheap_codes(facade) || find_by_codes(facade)
    end

    def model_class = ::Participant
  end
end
