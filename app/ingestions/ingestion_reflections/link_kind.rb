module IngestionReflections
  class LinkKind < Base
    delegate_missing_to ::LinkKind

    def linkable? = false
  end
end
