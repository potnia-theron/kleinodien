module IngestionReflections
  module Associations
    class ArtistCreditParticipant < Default
      def record_class = ::ArtistCreditParticipant

      def belongs_to = super.reject { it.name == :artist_credit }
    end
  end
end
