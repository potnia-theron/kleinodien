module Ingestion
  class AssociatedBases
    include Callable

    def initialize(calling)
      @calling = calling
    end

    def call
      return unless reflections.foreign_base_associations.any?
      # debugger if facade.class.to_s == "MusicbrainzFacade::EditionPosition"
      reflections.foreign_base_associations.each do |association|
        assign(association)
      end
    end

    private

    attr_reader :calling
    delegate_missing_to :calling

    def assign(association)
      associated_facade = facade.send(association.name)
      associated_reflections = associated_facade.scrape(:ingestion_reflections)

      associated_record = Buffering.call(associated_facade, associated_reflections)
      associated_base = associated_record.send(association.name)
      writer = "#{association.name}="
      record.send(writer, associated_base)
    end
  end
end
