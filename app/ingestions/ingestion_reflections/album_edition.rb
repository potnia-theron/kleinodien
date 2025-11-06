module IngestionReflections
  class AlbumEdition < Base
    # include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    def record_class = ::AlbumEdition

    delegate_missing_to :record_class

    def create_finder = IngestionFinder::AlbumEdition.new

    def delegated_base_reflections = factory.create(:edition)

    private

    attr_reader :factory
  end
end
