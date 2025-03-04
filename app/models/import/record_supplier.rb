module Import
  class RecordSupplier
    def initialize(adapter_layer, kind, options)
      @adapter_layer = adapter_layer
      @kind = kind
      @options = options
    end

    def supply_record
      existing_record = find_record(kind, options)
      return existing_record if existing_record

      Import::RecordBuilder.new(adapter_layer, kind, options).call

      find_record(kind, options) || build_record(kind, options)
    end

    private

    attr_reader :adapter_layer, :kind, :options
    delegate_missing_to :adapter_layer
  end
end
