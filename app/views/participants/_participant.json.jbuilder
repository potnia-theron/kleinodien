json.extract! participant, :id, :name, :sort_name, :disambiguation, :begin_date, :begin_date_accuracy, :end_date, :end_date_accuracy, :import_order_id, :discogs_code, :imdb_code, :musicbrainz_code, :tmdb_code, :wikidata_code, :created_at, :updated_at
json.url participant_url(participant, format: :json)
