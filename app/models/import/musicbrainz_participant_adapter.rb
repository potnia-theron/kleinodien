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
      cheap_search_parameters.merge({discogs_code: discogs_code}).compact
    end

    def cheap_search_parameters
      {musicbrainz_code: code}
    end

    private

    attr_reader :code, :factory

    delegate_missing_to :factory

    def data
      @data ||= from.musicbrainz.get(:artist, code) # .then { |string| ActiveSupport::JSON.decode(string) }
    end

    def discogs_code
      url_rel = url_rels.find { |relation| relation["type"] == "discogs" }
      return unless url_rel
      uri = url_rel.dig("url", "resource")
      match = uri.match %r{/artist/(?<code>[0-9]+)}
      match[:code]
    end

    def relations
      data["relations"]
    end

    def urls
      url_rels.map { |url_rel| url_rel.dig("url", "resource") }
    end

    def url_rels
      return [] unless relations
      relations.filter { |relation| relation.target_type == "url" }
    end
  end
end
