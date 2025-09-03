module IngestionReflections
  class SongEdition
    include Concerns::Reflectable

    delegate_missing_to ::SongEdition
  end
end
