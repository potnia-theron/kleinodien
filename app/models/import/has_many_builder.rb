module Import
  class HasManyBuilder
    include Callable

    def initialize(adapter_layer, association, facade, record)
      @adapter_layer = adapter_layer
      @association = association
      @facade = facade
      @record = record
    end

    def call
      proxy = record.send(association_name)
      model = association.options[:class_name]

      option_list.each { |options| proxy.push(supply_record(model, options)) }
    end

    private

    attr_reader :adapter_layer, :association, :facade, :record

    delegate :name, to: :association, prefix: true
    delegate_missing_to :adapter_layer

    def option_list
      facade.scrape(association_name)
    end
  end
end
