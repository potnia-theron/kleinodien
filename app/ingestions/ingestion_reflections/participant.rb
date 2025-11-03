module IngestionReflections
    class Participant < Base
    # include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    def record_class = ::Participant

    delegate_missing_to :record_class

    def has_many_associations
      super.reject { it.name == :artist_credit_participants }
    end

    def create_finder = factory.create_finder(::Participant)

    attr_reader :factory
  end
end
