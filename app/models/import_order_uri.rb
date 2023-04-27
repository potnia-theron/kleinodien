module ImportOrderUri
  EXTENSION_FOR = {
    "musicbrainz.org" => ::ImportOrderUri::MusicBrainz
  }.freeze

  def self.build(uri_candidate)
    return uri_candidate if uri_candidate.is_a? ImportOrderUri

    uri_object = URI(uri_candidate)
    host = uri_object.host
    extension_key = uri_object
      &.host
      &.then { EXTENSION_FOR.keys.find { |key| key.ends_with?(host) } }

    extension = EXTENSION_FOR.fetch(extension_key, ImportOrderUri::Common)

    uri_object.extend extension
  end
end
