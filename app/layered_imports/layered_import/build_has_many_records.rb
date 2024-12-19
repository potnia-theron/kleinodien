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
      reflections = build_reflections_for(association.class_name)
      name = association.name
      facades = facade.send(name)
      # facades.each do |facade|
      #   LayeredImport::BuildRecord.call(adapter_layer, facade, reflections)
      # end
    end
  end
end
