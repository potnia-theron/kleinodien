module Import
  class HasManyBuilder
    def initialize(adapter_layer, association, facade, record)
      @adapter_layer = adapter_layer
      @association = association
      @facade = facade
      @record = record
    end

    def build_many
      proxy = record.send(association_name)
      model = association.options[:class_name]

      option_list.each { |options| proxy.push(build_record(model, options)) }
    end

    private

    attr_reader :adapter_layer, :association, :facade, :record

    delegate :name, to: :association, prefix: true
    delegate_missing_to :adapter_layer

    def option_list
      # facade.send association_name
      facade.get(association_name)
    end
  end
end
