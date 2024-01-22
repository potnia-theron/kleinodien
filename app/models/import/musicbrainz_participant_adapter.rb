module Import
  class MusicbrainzParticipantAdapter
    def initialize(factory, code:)
      @code = code
      @factory = factory
    end

    def arguments
      {
        name: data["name"],
        sort_name: data["sort-name"]
      }
    end

    def expensive_search_parameters
      relations_code = Import::MusicbrainzRelationsCode.extract(relations)
      cheap_search_parameters
        .merge({discogs_code: relations_code["discogs"]["artist"]})
        .compact
    end

    def cheap_search_parameters
      {musicbrainz_code: code}
    end

    private

    attr_reader :code, :factory

    delegate_missing_to :factory

    def data
      @data ||= Import::Json.parse(json_string)
    end

    def json_string
      from.musicbrainz.get(:artist, code)
    end

    def relations
      data["relations"]
    end
  end
end
