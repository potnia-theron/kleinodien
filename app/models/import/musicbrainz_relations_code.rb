module Import
  class MusicbrainzRelationsCode
    REGEX_FOR = {
      "discogs" => %r{/(?<kind>[a-z-]+)/(?<code>\d+)},
      "imdb" => %r{/(?<kind>[a-z-]+)/(?<code>\w\w\d+)}
      # "wikidata" => %r{}
    }

    def initialize(relations)
      @relations = relations
    end

    def self.extract(*)
      new(*).extract
    end

    def extract
      result = Hash.new { |hash, key| hash[key] = {} }

      url_rels_of_interest.each do |url_rel|
        type, kind, code = type_kind_and_code_for(url_rel)
        next if [type, kind, code].any?(&:nil?)

        result[type][kind] = code
      end

      result
    end

    private

    attr_reader :relations

    def url_rels
      relations.filter { |relation| relation.target_type == "url" }
    end

    def url_rels_of_interest
      url_rels.filter { |url_rel| REGEX_FOR.include?(type_of(url_rel)) }
    end

    def type_kind_and_code_for(url_rel)
      uri_obj = uri_obj_for(url_rel)
      return unless uri_obj

      type = type_of(url_rel)
      regex = REGEX_FOR[type]

      # debugger
      match_data = regex.match(uri_obj.path)
      return unless match_data

      [type, match_data[:kind], match_data[:code]]
    end

    def type_of(url_rel)
      url_rel.type.downcase
    end

    def uri_obj_for(url_rel)
      URI(url_rel.url.resource)
    rescue URI::InvalidURIError
      Rails.logger.warn("Bad uri in #{url_rel}")
      nil
    rescue NoMethodError
      Rails.logger.warn("Malformed data in MusicBrainz url-rel #{url_rel}")
      nil
    end
  end
end
