module Import
  class MusicbrainzRelationsCode
    REGEX_FOR = {
      "discogs" => %r{/(?<kind>[a-z-]+)/(?<code>\d+)},
      "imdb" => %r{/(?<kind>[a-z-]+)/(?<code>\w\w\d+)},
      "wikidata" => %r{/(?<kind>wiki)/Q(?<code>\d+)}
    }.freeze

    def initialize(relations)
      @relations = relations
    end

    def extract
      result = Hash.new { |hash, key| hash[key] = {} }

      url_rels_of_interest.each do |url_rel|
        type, kind, code = type_kind_and_code_for(url_rel)
        next if [type, kind, code].any?(&:nil?)

        result[type.to_sym][kind.to_sym] = code
      end

      result
    end

    private

    attr_reader :relations

    def url_rels_of_interest
      relations.filter { |relation| relation[:target_type] == "url" }
        .filter { |url_rel| REGEX_FOR.include?(url_rel[:type].downcase) }
    end

    def type_kind_and_code_for(url_rel)
      uri_obj = uri_obj_for(url_rel)
      return unless uri_obj

      type = url_rel[:type].downcase
      regex = REGEX_FOR[type]

      match_data = regex.match(uri_obj.path)
      return unless match_data

      [type, match_data[:kind], match_data[:code]]
    end

    def uri_obj_for(url_rel)
      URI(url_rel.dig(:url, :resource))
    rescue URI::InvalidURIError
      Rails.logger.warn("Bad uri in #{url_rel}")
      nil
    rescue NoMethodError
      Rails.logger.warn("Malformed data in MusicBrainz url-rel #{url_rel}")
      nil
    end
  end
end
