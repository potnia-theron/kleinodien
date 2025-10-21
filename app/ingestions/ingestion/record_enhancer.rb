module Ingestion
  class RecordEnhancer
    include Callable

    def initialize(kit, record)
      @kit = kit
      @record = record
    end

    def call
      delegated_base
    end

    private

    attr_reader :kit, :record
    delegate_missing_to :kit

    def delegated_base
      base_kit = delegated_base_kit
      return unless base_kit

      delegated_type_attr_name = delegated_of_association.inverse_of.name
      RecordBuilder.call(base_kit, delegated_type_attr_name => record)
    end
  end
end
