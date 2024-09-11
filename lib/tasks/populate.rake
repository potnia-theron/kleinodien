namespace :db do
  desc "add sample data to the database"
  task populate: :environment do
    ac_dc = Participant.create!(name: "AC/DC", sort_name: "AC/DC")
    a_credit = ArtistCredit.create!(name: "AC/DC")
    ArtistCreditParticipant.create!(participant: ac_dc, artist_credit: a_credit, position: 1)

    Archetype.create! artist_credit: a_credit, title: "Highway to Hell",
      archetypeable: AlbumArchetype.new(musicbrainz_code: "aea29854-0260-11ef-b9d3-f726b8ca2a96")
  end
end
