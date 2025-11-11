module IngestionReflections
  class ArtistCreditParticipant < Default
    def record_class = ::ArtistCreditParticipant

    delegate_missing_to :record_class
  end
end
