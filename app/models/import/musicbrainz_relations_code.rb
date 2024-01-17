class Import::MusicbrainzRelationsCode
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
    url_rels_of_interest.inject({}) { |memo, url_rel| memo.update(kind_and_code_for(url_rel)) }
  end

  private

  attr_reader :relations

  def url_rels
    relations.filter { |relation| relation.target_type == "url" }
  end

  def url_rels_of_interest
    url_rels.filter { |url_rel| REGEX_FOR.include?(key_for(url_rel)) }
  end

  def kind_and_code_for(url_rel)
    key = key_for(url_rel)
    regex = REGEX_FOR[key]
    uri_obj = URI(url_rel.url.resource)

    match_data = regex.match(uri_obj.path)
    {key => {match_data[:kind] => match_data[:code]}}
  end

  def key_for(url_rel)
    url_rel.type.downcase
  end
end
