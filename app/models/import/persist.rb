module Import
  class Persist
    def initialize(facade)
      @facade = facade
    end

    attr_reader :facade

    def persist!
      persist_belongs_to!

      model_class = facade.model
      attributes = facade.attributes

      record = model_class.create!(attributes)

      persist_has_many!
      record
    end

    def persist_belongs_to!
      facade.belongs_to_associations.each do |name|
      end
    end

    def persist_has_many!
    end
  end
end
