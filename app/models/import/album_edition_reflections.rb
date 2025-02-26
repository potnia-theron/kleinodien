module Import
  class AlbumEditionReflections
    include Concerns::Reflectable

    delegate_missing_to AlbumEdition
  end
end
