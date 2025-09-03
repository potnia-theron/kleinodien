module IngestionReflections
  class AlbumArchetype
    include Concerns::Reflectable

    delegate_missing_to ::AlbumArchetype
  end
end
