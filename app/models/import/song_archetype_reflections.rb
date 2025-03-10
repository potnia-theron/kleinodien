module Import
  class SongArchetypeReflections
    include Concerns::Reflectable

    delegate_missing_to SongArchetype
  end
end
