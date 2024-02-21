module Import
  class Prepare
    def self.call(...)
      new(...).call
    end

    def initialize(session, model:, presenter:)
      @session = session
      @model = model
      @presenter = presenter
    end

    attr_reader :session, :model, :presenter

    def call
      find || buffer && nil
    end

    def find
      finder = session.build_finder(presenter)
      finder.call
    end

    def buffer
      # prepare_belongs_to
      prepare_has_many
      prepare_has_and_belongs_to_many
    end

    def prepare_belongs_to
      associations = model.belongs_to_associations

      associations.each do |association|
        # ???
      end
    end

    def prepare_has_many
    end

    def prepare_has_and_belongs_to_many
    end
  end
end
