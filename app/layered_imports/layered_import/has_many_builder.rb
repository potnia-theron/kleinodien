module LayeredImport
  class HasManyBuilder
    def initialize(adapter_layer, association, facade, record)
      @adapter_layer = adapter_layer
      @association = association
      @facade = facade
      @record = record
    end

    def build_many
      record.send association_writer, option_list.map { |options| build_record(model, options) }
    end

    private

    attr_reader :adapter_layer, :association, :facade, :record

    delegate :name, to: :association, prefix: true
    delegate_missing_to :adapter_layer

    def association_writer
      "#{association_name}="
    end

    def model
      association.options[:class_name]
    end

    def option_list
      facade.send association_name
    end
  end
end
