module IngestionReflections
  class Url < Default
    # TODO: remove #linkable?
    # TODO: ... or shall it stay? Urls shouldn't link to other entities
    def linkable? = false
  end
end
