module IngestionReflections
  class LinkKind < Default
    delegate_missing_to ::LinkKind

    def linkable? = false
  end
end
