module IngestionReflections
  class SongEdition
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    def record_class = ::SongEdition
    delegate_missing_to :record_class

    def delegated_base = factory.create("Edition")

    def model_name = "SongEdition"

    private

    attr_reader :factory
  end
end
