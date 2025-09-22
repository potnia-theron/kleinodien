module MusicbrainzIngestionState
  class Buffering
    def initialize(factory)
      @factory = factory
    end

    # def call = Persisting.new(import_order)
    # def call = find || persist
    def call
      import_order.buffering!
      ingestion.call
      persisting = factory.create(:persisting)
      persisting.call
    end

    private

    attr_reader :factory

    # def ingestion = @ingestion ||= Ingestion::Switch.new(facade, reflections)

    # delegate :facade, :reflections, to: :factory
    delegate_missing_to :factory
  end
end
