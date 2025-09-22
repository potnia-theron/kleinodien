module Ingestion
  class BelongsTo
    include Callable

    def initialize(calling)
      @calling = calling
    end

    def call
      reflections.belongs_to_association_reflections.each do |name, associated_reflections|
        associated_facade = facade.scrape(name)
        associated_record = procreate(associated_facade, associated_reflections)
        writer = "#{name}="
        record.send(writer, associated_record)
      end
    end

    private

    attr_reader :calling
    delegate_missing_to :calling
  end
end
