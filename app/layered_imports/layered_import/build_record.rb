module LayeredImport
  class BuildRecord
    def self.call(...)
      new(...).call
    end

    def initialize(adapter_layer, kind, options)
      @adapter_layer = adapter_layer
      @kind = kind
      @options = options
    end

    def call
      reflections.inherent_attribute_names.index_with { |attr| facade.send(attr) }

      build_has_many_records
      assign_foreign_attributes
      record
    end

    private

    attr_reader :adapter_layer, :kind, :options
    delegate_missing_to :adapter_layer

    def build_has_many_records
      reflections.has_many_associations.map do |association|
        create_has_many_builder(association, facade, record).build_many
      end
    end

    def inherent_attributes
      reflections.inherent_attribute_names.index_with { |attr| facade.send(attr) }.compact
    end

    def assign_foreign_attributes
      belongs_to_associations = reflections.belong_to_associations
      belongs_to_associations.each do |association|
        record.send(:"#{association.name}=", adapter_layer.build_record(association.class_name, facade.send(association.name)))
      end
    end

    def facade
      @facade ||= facade_layer.build_facade(reflections, options)
    end

    def record
      @record ||= kind.to_s.classify.constantize.new(inherent_attributes)
    end

    def reflections
      @reflections ||= build_reflections_for(kind)
    end
  end
end
