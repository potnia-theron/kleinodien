module IngestionReflections
  class Participant
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    def record_class = ::Participant

    delegate_missing_to :record_class

    def after_has_many_associations(associations)
      associations.reject { |association| association.name == :artist_credit_participants }
    end

    def create_finder = factory.create_finder(::Participant)

    attr_reader :factory
  end
end
