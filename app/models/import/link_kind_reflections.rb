module Import
  class LinkKindReflections
    include Concerns::Reflectable

    delegate_missing_to LinkKind

    def linkable? = false
  end
end
