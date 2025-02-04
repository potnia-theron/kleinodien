module LayeredImport
  class AlbumArchetypeReflections
    include Concerns::Reflectable

    delegate_missing_to AlbumArchetype
  end
end
