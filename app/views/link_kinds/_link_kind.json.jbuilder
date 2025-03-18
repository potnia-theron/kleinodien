json.extract! link_kind, :id, :name, :description, :link_phrase, :reverse_link_phrase, :long_link_phrase, :musicbrainz_code, :created_at, :updated_at
json.url link_kind_url(link_kind, format: :json)
