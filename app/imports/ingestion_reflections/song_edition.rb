module IngestionReflections
  class SongEdition < Default
    def delegated_base = factory.create("Edition")
  end
end
