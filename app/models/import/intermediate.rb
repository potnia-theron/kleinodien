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
      search_parameters = adapter.cheap_search_parameters
      find_by_codes(search_parameters)
    end

    def expensive_find
      search_parameters = adapter.expensive_search_parameters
      find_by_codes(search_parameters)
    end

    def find_by_codes(codes_hash)
      results = model_class.where(codes_hash)

      return unless results.any?
      raise "Too many records found" if results.length > 1

      @id = results.first.id
    end
  end
end
