module IngestionReflections
  class ArtistCredit < Default
    def record_class = ::ArtistCredit

    delegate_missing_to :record_class

    def class_name = ::ArtistCredit.name
  end
end
