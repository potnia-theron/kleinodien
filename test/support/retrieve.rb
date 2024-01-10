require "support/retrieve/musicbrainz"

module Retrieve
  def self.musicbrainz(*)
    Musicbrainz.new(*).retrieve
  end
end
