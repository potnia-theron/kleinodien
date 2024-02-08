module Import
  class MusicbrainzParticipantAdapter
    def model_class = Participant

    def initialize(session, data: nil, **options)
      @session = session
      @data = data
      @options = options
    end

    def prepare
      model_class.find_by(musicbrainz_code: code) || find_by_all_codes
    end

    def persist!
      model_class.create!(
        name: data.name,
        sort_name: data.sort_name,
        musicbrainz_code: code
      )
    end

    attr_reader :options, :session

    def code
      options[:code] || data&.id || raise("can't get code")
    end

    def data
      @data ||= session.musicbrainz.get(:artist, code)
    end

    def find_by_all_codes
      relations = Import::MusicbrainzRelationsCode.extract(data.relations)

      codes_hash = {
        discogs_code: relations.dig("discogs", "artist"),
        imdb_code: relations.dig("imdb", "name")
      }.compact

      query = model_class.where(musicbrainz_code: code)
      codes_hash.each do |attr, code_value|
        query = query.or(model_class.where(attr => code_value))
      end

      query.load&.first
    end
  end
end
