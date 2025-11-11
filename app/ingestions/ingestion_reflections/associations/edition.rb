module IngestionReflections
  module Associations
    class Edition < Base
      def record_class = ::Edition

      def belongs_to = super.reject { it.name == :editionable }
    end
  end
end
