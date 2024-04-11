module Import
  class ParticipantProperties
    include Concerns::Reflectable

    # Participants shall not care about their :artist_credit_participants
    def has_many_associations
      super.reject { |association| association.name == :artist_credit_participants }
    end
  end
end
