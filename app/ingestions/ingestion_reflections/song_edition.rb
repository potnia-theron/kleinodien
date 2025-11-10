module IngestionReflections
  class SongEdition < Base
    def record_class = ::SongEdition

    delegate_missing_to :record_class

    def delegated_base = factory.create("Edition")

    def model_name = "SongEdition"
  end
end
