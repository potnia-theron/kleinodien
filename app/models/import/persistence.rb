module Import
  class Persistence
    def initialize(adapter)
      @adapter = adapter
    end

    def create!
      persist!("Participant", :participants)
    end

    private

    attr_reader :adapter

    def persist!(model_class_name, adapter_method)
      model_class = model_class_name.constantize
      adapter.send(adapter_method).each do |args|
        model_class.create!(args)
      end
    end
  end
end
