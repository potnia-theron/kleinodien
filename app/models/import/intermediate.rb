module Import
  class Intermediate
    def initialize(adapter:, model_class:)
      @adapter = adapter
      @model_class = model_class.constantize
    end

    attr_reader :adapter, :id, :model_class

    def prepare!
      return if id

      find_existing_by_inherent_code || find_existing_by_all_codes
    end

    def save!
    end

    def persisted?
      return true if id
      false
    end

    private

    def find_existing_by_inherent_code
      codes_hash = adapter.inherent_codes_hash
      find_by_codes(codes_hash)
    end

    def find_existing_by_all_codes
      codes_hash = adapter.full_codes_hash
      find_by_codes(codes_hash)
    end

    def find_by_codes(codes_hash)
      # Won't work with more than one code!
      results = model_class.where(codes_hash)

      return unless results.any?
      raise "Too many records found" if results.length > 1

      @id = results.first.id
    end
  end
end
