module ImportOrderUri
  module MusicBrainz
    include Common
    CODE_AND_KIND_REGEX = %r{/(?<kind>[a-z-]+)/(?<code>[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})}

    def code_and_kind
      path&.match CODE_AND_KIND_REGEX
    end
  end
end
