module Import
  class AdapterLayer
    def initialize(order)
      @order ||= order
      @supply_persisted = false
    end

    attr_reader :order
    attr_accessor :supply_persisted

    def assign_foreign_base(...) = Import::ForeignBaseAssigner.call(self, ...)

    def assign_foreign_attribute(...) = Import::ForeignAttributeAssigner.call(self, ...)

    def assign_delegate_base_to_delegated_base(...) = DelegatedBaseToDelegatedBaseAssigner.call(self, ...)

    def build_delegated_base(...) = Import::DelegatedBaseBuilder.call(self, ...)

    def build_has_many_associations(...) = Import::HasManyBuilder.call(self, ...)

    def build_record(...) = Import::RecordBuilder.call(self, ...)

    def build_reflections_for(kind)
      "Import::#{kind.to_s.underscore.classify}Reflections".constantize.new
    end

    def facade_layer = @facade_layer ||= Import::FacadeLayer.new(order)

    def find_record(...) = Import::RecordFinder.call(self, ...)

    def find_or_build_record(...) = find_record(...) || build_record(...)

    def supply_record(kind, options)
      entity = find_or_build_record(kind, options)

      return entity unless entity.new_record?
      entity.save! if supply_persisted?

      entity
    end

    def supply_persisted? = supply_persisted
  end
end
