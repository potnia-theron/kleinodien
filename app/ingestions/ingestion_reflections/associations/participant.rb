module IngestionReflections
  module Associations
    class Participant < Base
      def record_class = ::Participant

      def has_many_associations
        super.reject { it.name == :artist_credit_participants }
      end
    end
  end
end
