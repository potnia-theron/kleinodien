module IngestionReflections
  class ArtistCreditParticipant < Base
    def record_class = ::ArtistCreditParticipant

    delegate_missing_to :record_class

    def belongs_to_associations
      super.reject { it.name == :artist_credit }
    end
  end
end
