module Import
  class Intermediate
    def initialize(adapter:, model_class:)
      @adapter = adapter
      @model_class = model_class
    end

    attr_reader :adapter, :id, :model_class

    def prepare!
      return if id

      cheap_find || expensive_find
    end

    def save!
      return model_class.find(id) if persisted?

      arguments = adapter.arguments
      model_class.create!(arguments)
    end

    def persisted?
      return true if id
      false
    end

    private

    def cheap_find
      codes_hash = adapter.inherent_codes_hash
      find_by_codes(codes_hash)
    end

    def expensive_find
      codes_hash = adapter.full_codes_hash
      find_by_codes(codes_hash)
    end

    def find_by_codes(codes_hash)
      results = model_class.where(codes_hash)

      return unless results.any?
      raise "Too many records found" if results.length > 1

      @id = results.first.id
    end
  end
end
