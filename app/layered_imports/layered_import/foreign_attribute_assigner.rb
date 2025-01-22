module LayeredImport
  class ForeignAttributeAssigner
    def initialize(adapter_layer, association, facade, record)
      @adapter_layer = adapter_layer
      @association = association
      @facade = facade
      @record = record
    end

    def assign
      foreign_record = build_foreign_record
      record.send(association_writer, foreign_record) # build_foreign_record)
    end

    private

    attr_reader :adapter_layer, :association, :facade, :record

    def association_name
      association.name
    end

    def association_writer
      "#{association_name}="
    end

    def build_foreign_record
      adapter_layer.build_record(association.class_name, foreign_attributes)
    end

    def foreign_attributes
      facade.send(association_name)
    end
  end
end
