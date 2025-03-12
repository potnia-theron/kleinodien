module Import
  class ForeignAttributeAssigner
    include Callable

    def initialize(adapter_layer, association, facade, entity)
      @adapter_layer = adapter_layer
      @association = association
      @entity = entity
      @facade = facade
    end

    def call
      entity.send(association_writer, foreign_entity)
    end

    private

    attr_reader :adapter_layer, :association, :entity, :facade
    delegate :name, to: :association, prefix: true

    def association_writer
      "#{association_name}="
    end

    def foreign_entity
      @foreign_entity ||= adapter_layer.supply_entity(association.class_name, foreign_attributes)
    end

    def foreign_attributes
      facade.scrape(association_name)
    end
  end
end
