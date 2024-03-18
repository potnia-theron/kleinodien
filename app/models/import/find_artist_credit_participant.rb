# TODO: Implement FindArtistCreditParticipant
# TODO: Is it ok when FindArtistCreditParticipant always returns nil?
# - an ArtistCredit must not search for an ArtistCreditParticipant when it exists
# - if an ArtistCredit does not exist the ArtistCreditParticipant can not exist
# - a Participant must not search for an ArtistCreditParticipant
module Import
  class FindArtistCreditParticipant
    def initialize(*)
    end

    def call = nil
    # def initialize(session, facade:)
    #   @session = session
    #   @facade = facade
    # end

    # attr_reader :facade, :session

    # def call
    #   ArtistCreditParticipant.where(
    #     artist_credit: facade.artist_credit,
    #     participant: facade.participant,
    #     join_phrase: facade.join_phrase,
    #     position: facade.position
    #   )
    # end
  end
end
