module IngestionReflections
  class EditionSection < Default
    def record_class = ::EditionSection

    delegate_missing_to :record_class

    def create_finder = factory.create_finder(::EditionSection)
  end
end
