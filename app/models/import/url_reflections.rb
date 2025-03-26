module Import
  class UrlReflections
    include Concerns::Reflectable

    delegate_missing_to Url

    # TODO: remove #linkable?
    # TODO: ... or shall it stay? Urls shouldn't link to other entities
    def linkable? = false
  end
end
