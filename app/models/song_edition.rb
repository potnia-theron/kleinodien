class SongEdition < ApplicationRecord
  # TODO: are there really codes for discogs, musicbrainz and wikidata?
  include Editionable
end
