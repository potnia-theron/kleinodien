module Import
  class Persist
    def initialize(presenter)
      @presenter = presenter
    end

    attr_reader :presenter

    def persist!
      persist_belongs_to!

      model_class = presenter.model
      attributes = presenter.attributes

      record = model_class.create!(attributes)

      persist_has_many!
      record
    end

    def persist_belongs_to!
      presenter.belongs_to_association_names.each do |name|
      end
    end

    def persist_has_many!
    end
  end
end
