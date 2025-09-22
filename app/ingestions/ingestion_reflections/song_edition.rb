module IngestionReflections
  class SongEdition
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    def base_class = ::SongEdition
    delegate_missing_to :base_class

    def delegated_base = factory.create("Edition")

    def model_name = "SongEdition"

    private

    attr_reader :factory
  end
end
