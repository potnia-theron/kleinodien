module IngestionReflections
  module Associations
    class Participant < Base
      def record_class = ::Participant

      def has_many = super.reject { it.name == :artist_credit_participants }
    end
  end
end
