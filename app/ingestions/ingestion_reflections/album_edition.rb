module IngestionReflections
  class AlbumEdition
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    delegate_missing_to ::AlbumEdition

    def create_finder = IngestionFinder::AlbumEdition.new

    def delegated_base = factory.create("Edition")

    private

    attr_reader :factory
  end
end
