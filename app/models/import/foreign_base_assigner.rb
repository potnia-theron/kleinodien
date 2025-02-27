module Import
  class ForeignBaseAssigner
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
      # TODO: this is a hack to get the archetype record
      @foreign_record ||= adapter_layer.supply_record(delegated_type_class, foreign_attributes).archetype
    end

    def foreign_attributes
      facade.scrape(association_name)
    end

    def delegated_type_class
      # TODO: this is a hack to get the archetype class
      xxx = record.send(association.delegated_type_reader)
      xxx.sub("Edition", "Archetype")
    end
  end
end
