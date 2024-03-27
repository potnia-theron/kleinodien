# TODO: add tests
module Import
  class OneBelongsToAssociationPersister
    def initialize(session, association:, other:)
      @session = session
      @association = association
      @other = other
    end

    def persist
      [name, record]
    end

    private

    attr_reader :association, :other, :session

    delegate :options, to: :other
    delegate :name, to: :association

    def other_facade
      other.facade
    end

    def persist_record
      facade = other_facade.send(name)
      persister = session.build_persister(facade)
      persister.persist!
    end

    def record
      options[name] || persist_record
    end
  end
end
