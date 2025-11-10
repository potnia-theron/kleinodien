module IngestionReflections
  class EditionPosition < Base
    def record_class = ::EditionPosition

    delegate_missing_to :record_class
  end
end
