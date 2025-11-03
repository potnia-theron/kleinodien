module IngestionKit
  class One
    def initialize(facade, reflections, association: nil)
      @facade = facade
      @reflections = reflections
      @association = association
    end

    attr_reader :association, :facade, :reflections

    delegate :scrape, :scrape_many, to: :facade
    delegate_missing_to :reflections

    def inherent_attributes = facade.scrape_many(inherent_attribute_names)

    def belongs_to_kits
      belongs_to_association_reflections.map do |name, assoc_reflections|
        assoc_facade = scrape(name)
        [name, One.new(assoc_facade, assoc_reflections)]
      end.to_h
    end

    def delegated_base_kit
      base_reflections = delegated_base_reflections
      return unless base_reflections

      self.class.new(facade, base_reflections)
    end

    # When we a delegated_base we want our delegated_type
    def delegated_type_kit
      type_assoc = reflections.delegated_type_association
      return unless type_assoc

      assoc_name = type_assoc.foreign_type
      assoc_type = facade.scrape(assoc_name)
      delegated_type_reflections = reflections.factory.create(assoc_type)

      One.new(facade, delegated_type_reflections)
    end

    def has_many_kits
      has_many_associations.map { IngestionKit::Many.new(it, facade, reflections) }
    end
  end
end
