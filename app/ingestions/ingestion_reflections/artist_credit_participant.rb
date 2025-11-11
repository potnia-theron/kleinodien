module IngestionReflections
  class ArtistCreditParticipant < Base
    def record_class = ::ArtistCreditParticipant

    delegate_missing_to :record_class
  end
end
