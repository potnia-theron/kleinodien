module Import
  class ForeignBaseAssigner
    include Callable

    def initialize(adapter_layer, association, facade, record)
      @adapter_layer = adapter_layer
      @association = association
      @facade = facade
      @record = record
    end

    def call
      build_record(delegated_type, facade.data)
    end

    private

    attr_reader :adapter_layer, :association, :facade, :record
    delegate_missing_to :adapter_layer

    def delegated_type = @delegated_type ||= facade.delegated_type_for(association)
  end
end
