module IngestionReflections
  class ArtistCreditParticipant
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    def record_class = ::ArtistCreditParticipant

    delegate_missing_to :record_class

    def after_belongs_to_associations(associations)
      associations.reject { |association| association.name == :artist_credit }
    end

    private

    attr_reader :factory
  end
end
