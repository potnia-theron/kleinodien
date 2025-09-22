module Ingestion
  class Buffering
    include Callable

    CALLABLE_STEPS = [
      Ingestion::DelegatedBase,
      Ingestion::AssociatedBases,
      Ingestion::BelongsTo,
      Ingestion::HasMany
    ].freeze

    def initialize(facade, reflections)
      @facade = facade
      @reflections = reflections
    end

    attr_reader :facade, :reflections

    def call
      record
      CALLABLE_STEPS.each { it.call(self) }
      record
    end

    def procreate(...) = self.class.call(...)

    # def record = @record ||= reflections.base_class.new(inherent_attributes)
    def record = @record ||= find || build

    private

    def find
      finder = reflections.create_finder
      finder.call(facade)
    end

    def build
      reflections.base_class.new(inherent_attributes)
    end

    def inherent_attributes = facade.scrape_many(inherent_attribute_names)

    def inherent_attribute_names = reflections.inherent_attribute_names
  end
end
