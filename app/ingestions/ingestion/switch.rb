module Ingestion
  class Switch
    def initialize(facade, reflections)
      @facade = facade
      @reflections = reflections
    end

    delegate :call, to: :current_state

    def persisting! = @persisting = true

    def persisting? = persisting

    def buffering? = !persisting

    private

    attr_reader :facade, :persisting, :reflections

    def current_state = persisting ? persisting_state : buffering_state

    def buffering_state = Ingestion::Buffering.new(facade, reflections)

    def persisting_state = Ingestion::Persisting.new(facade, reflections)
  end
end
