module Import
  class ForeignBaseAssigner
    include Callable

    def initialize(adapter_layer, association, facade, record)
      @adapter_layer = adapter_layer
      @association = association
      @facade = facade
      @record = record
    end

    def call
      record.send(association_writer, foreign_base)
    end

    private

    attr_reader :adapter_layer, :association, :facade, :record
    delegate_missing_to :adapter_layer

    def association_name = association.name

    def association_writer = "#{association_name}="

    def delegated_type = @delegated_type ||= facade.delegated_type_for(association)

    def foreign_base
      # TODO: use #supply_record instead of #build_record ?
      build_record(delegated_type, facade.data)
        .send(association_name)
    end
  end
end
