module IngestionReflections
  module Associations
    class Default < Base
      def initialize(factory, record_class)
        super(factory)
        @record_class = record_class
      end

      attr_reader :record_class
    end
  end
end
