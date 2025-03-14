module Import
  class ForeignBaseAssigner
    include Callable

    def initialize(adapter_layer, association, entity, facade)
      @adapter_layer = adapter_layer
      @association = association
      @entity = entity
      @facade = facade
    end

    def call
      entity.send(association_writer, foreign_base)
    end

    private

    attr_reader :adapter_layer, :association, :entity, :facade
    delegate_missing_to :adapter_layer

    def association_name = association.name

    def association_writer = "#{association_name}="

    def delegated_type = @delegated_type ||= facade.delegated_type_for(association)

    def foreign_base
      build_entity(delegated_type, facade.data)
        .send(association_name)
    end
  end
end
