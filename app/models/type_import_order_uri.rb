# https://fly.io/ruby-dispatch/humane-rails-forms/

class TypeImportOrderUri < ActiveRecord::Type::Value
  EXTENSION_FOR = {
    "musicbrainz.org" => ::ImportOrderUri::MusicBrainz
  }.freeze

  def cast_value(value)
    return value if value.is_a? ImportOrderUri

    uri_object = URI(value)
    host = uri_object.host
    extension_key = EXTENSION_FOR.keys.find { |key| key.ends_with?(host)}

    extension = EXTENSION_FOR.fetch(extension_key, ImportOrderUri::Common)

    uri_object.extend extension
  end
end
