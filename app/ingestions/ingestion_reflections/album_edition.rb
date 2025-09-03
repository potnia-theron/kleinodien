module IngestionReflections
  class AlbumEdition
    include Concerns::Reflectable

    delegate_missing_to ::AlbumEdition
  end
end
