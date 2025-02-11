module Import
  class ForeignAttributeAssigner
    def initialize(adapter_layer, association, facade, record)
      @adapter_layer = adapter_layer
      @association = association
      @facade = facade
      @record = record
    end

    def assign
      record.send(association_writer, foreign_record)
    end

    private

    attr_reader :adapter_layer, :association, :facade, :record
    delegate :name, to: :association, prefix: true

    def association_writer
      "#{association_name}="
    end

    def foreign_record
      @foreign_record ||= adapter_layer.build_record(association.class_name, foreign_attributes)
    end

    def foreign_attributes
      facade.scrape(association_name)
    end
  end
end
