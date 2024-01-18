module Import
  class MusicbrainzRelationsCode
    REGEX_FOR = {
      "discogs" => %r{/(?<kind>[a-z-]+)/(?<code>\d+)},
      "imdb" => %r{/(?<kind>[a-z-]+)/(?<code>\w\w\d+)}
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
      type = type_of(url_rel)
      regex = REGEX_FOR[type]
      uri_obj = URI(url_rel.url.resource)

      match_data = regex.match(uri_obj.path)
      [type, match_data[:kind], match_data[:code]]
    end

    def type_of(url_rel)
      url_rel.type.downcase
    end
  end
end
