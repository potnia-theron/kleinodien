module LayeredImport
  class BuildHasManyRecords
    def self.call(...)
      new(...).call
    end

    def initialize(adapter_layer, facade, reflections)
      @adapter_layer = adapter_layer
      @reflections = reflections
      @facade = facade
    end

    attr_reader :adapter_layer, :facade, :reflections
    delegate_missing_to :adapter_layer

    def call
      reflections.has_many_associations.each { |association| build_siblings_for(association) }
    end

    def build_siblings_for(association)
      # reflections = build_reflections_for(association.class_name)
      name = association.name
      option_list = facade.send(name)
      option_list.map do |opts, index|
        rec = build_record(association.class_name, opts)
      end
    end
  end
end
