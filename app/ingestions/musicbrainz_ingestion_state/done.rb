module MusicbrainzIngestionState
  class Done
    def initialize(factory)
      @factory = factory
    end

    attr_reader :factory, :result

    def call(final_result)
      import_order = factory.import_order
      import_order.done!
      @result = final_result
      self
    end
  end
end
