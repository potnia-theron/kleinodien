# - an ArtistCredit must not search for an ArtistCreditParticipant when it exists
# - if an ArtistCredit does not exist the ArtistCreditParticipant can not exist
# - a Participant must not search for an ArtistCreditParticipant
# therefor we do nothing
module Import
  # OPTIMIZE: Consider creation of a basic null object class for Finders
  class FindArtistCreditParticipant
    def initialize(*)
    end

    def call = nil
  end
end
