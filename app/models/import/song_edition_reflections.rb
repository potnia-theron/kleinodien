module Import
  class SongEditionReflections
    include Concerns::Reflectable

    delegate_missing_to SongEdition
  end
end
