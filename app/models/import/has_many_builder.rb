module Import
  class HasManyBuilder
    include Callable

    def initialize(adapter_layer, association, facade, entity)
      @adapter_layer = adapter_layer
      @association = association
      @entity = entity
      @facade = facade
    end

    def call
      proxy = entity.send(association_name)
      model = association.options[:class_name]

      option_list.each do |options|
        owned_entity = find_entity(model, options) || build_entity(model, options)
        proxy.push(owned_entity)
      end
    end

    private

    attr_reader :adapter_layer, :association, :entity, :facade

    delegate :name, to: :association, prefix: true
    delegate_missing_to :adapter_layer

    def option_list
      facade.scrape(association_name)
    end
  end
end
