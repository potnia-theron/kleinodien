module IngestionReflections
  class ArtistCreditParticipant
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    delegate_missing_to ::ArtistCreditParticipant

    def after_belongs_to_associations(associations)
      associations.reject { |association| association.name == :artist_credit }
    end

    private

    attr_reader :factory
  end
end
