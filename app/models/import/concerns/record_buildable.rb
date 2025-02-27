module Import::Concerns
  module RecordBuildable
    extend ActiveSupport::Concern

    def assign_foreign_bases
      return unless reflections.respond_to? :delegated_base_associations

      reflections.delegated_base_associations.each do |association|
        adapter_layer.build_foreign_base_assigner(association, facade, record).assign
      end
    end

    def build_has_many_records
      reflections.has_many_associations.map do |association|
        build_has_many_builder(association, facade, record).build_many
      end
    end

    def assign_foreign_attributes
      reflections.belong_to_associations.each do |association|
        adapter_layer.build_foreign_attribute_assigner(association, facade, record).assign
      end
    end

    def inherent_attributes
      # reflections.inherent_attribute_names.index_with { |attr| facade.send(attr) }.compact
      names = reflections.inherent_attribute_names
      facade.scrape_many(names)
    end
  end
end
