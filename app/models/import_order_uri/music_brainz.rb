module ImportOrderUri
  module MusicBrainz
    include Common
    KIND_AND_CODE_REGEX = %r{/(?<kind>[a-z-]+)/(?<code>[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})}

    def kind_and_code
      path
        &.match(KIND_AND_CODE_REGEX)
        &.then { |match_data| KindAndCode.new(*match_data.values_at(1, 2)) }
    end
  end
end
