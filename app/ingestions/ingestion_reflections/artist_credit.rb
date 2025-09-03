module IngestionReflections
  class ArtistCredit
    include Concerns::Reflectable

    delegate_missing_to ::ArtistCredit
  end
end
