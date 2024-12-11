module LayeredImport
  class WorkflowLayer
    def initialize(order)
      @order ||= order
    end

    attr_reader :order

    def build_record(model, options)
      reflections = reflections_for(model)
      LayeredImport::BuildRecord.call(self, reflections, options)
    end

    def build_buffer_filler(**options)
      # Buffer.filer.new
    end

    def build_buffer_persister
      proc { true }
    end

    def reflections_for(model)
      model
        .to_s
        .camelize
        .prepend("LayeredImport::")
        .concat("Reflections")
        .constantize
    end
  end
end
