module IngestionReflections
  class SongArchetype
    include Concerns::Reflectable

    delegate_missing_to ::SongArchetype
  end
end
