module ImportOrderUri
  EXTENSION_FOR = {
    "musicbrainz.org" => ::ImportOrderUri::MusicBrainz
  }.freeze

  def self.build(uri_string)
    uri_object = URI(uri_string)

    host = uri_object.host
    extension_key = EXTENSION_FOR.keys.find { |key| key.ends_with?(host)}

    extension = EXTENSION_FOR.fetch(extension_key, ImportOrderUri::Common)

    uri_object.extend extension
  end
end
