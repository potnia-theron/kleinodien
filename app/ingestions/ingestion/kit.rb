module Ingestion
  class Kit
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
        [name, Kit.new(assoc_facade, assoc_reflections)]
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

      Kit.new(facade, delegated_type_reflections)
    end

    def has_many_kits
      has_many_associations.map do |assoc|
        name = assoc.name
        assoc_facades = facade.scrape(name)

        assoc_class_name = assoc.class_name
        assoc_reflections = reflections.create(assoc_class_name)

        assoc_kits = assoc_facades.map { Kit.new(it, assoc_reflections, association: assoc) }

        [name, assoc_kits]
      end.to_h
    end
  end
end
