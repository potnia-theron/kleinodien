class Import::MusicbrainzRelationsCode
  DOMAINS_OF_INTEREST = {
    "discogs.com" => %r{/(?<kind>[a-z-]+)/(?<code>\d+)},
    "imdb.com" => %r{/(?<kind>[a-z-]+)/(?<code>\w\w\d+)}
    # "tmdb.org" => %r{}
  }.freeze

  def initialize(relations)
    @relations = relations
  end

  def self.extract(*)
    new(*).extract
  end

  def extract
    urls_of_interest.map { |uri| kind_and_code_for(uri) }
  end

  private

  attr_reader :relations

  def all_urls
    relations
      .filter { |relation| relation.target_type == "url" }
      .map { |url_rel| url_rel&.url&.resource }
      .compact
      .map { |uri_string| URI(uri_string) }
  end

  def urls_of_interest
    all_urls.filter { |uri_obj| domain_of_interest?(uri_obj) }
  end

  def domain_of_interest?(uri_obj)
    hostname = uri_obj.host

    DOMAINS_OF_INTEREST.keys.any? do |host_of_interest|
      hostname.ends_with? host_of_interest
    end
  end

  def kind_and_code_for(uri_obj)
    hostname = uri_obj.host
    key = DOMAINS_OF_INTEREST.keys.find do |host_of_interest|
      hostname.ends_with? host_of_interest
    end

    regex = DOMAINS_OF_INTEREST[key]

    match_data = regex.match(uri_obj.path)
    [match_data[:kind], match_data[:code]]
  end
end
