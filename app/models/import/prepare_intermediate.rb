module Import
  class PrepareIntermediate
    def initialize(intermediate)
      @intermediate = intermediate
    end

    attr_reader :intermediate

    def prepare!
      find_by_inherent_code || find_by_codes_hash
    end

    delegate_missing_to :intermediate

    private

    # TODO: move results-check to another method
    def find_by_inherent_code
      results = model_class.where(code_column_name => code)
      return unless results.any?

      raise "Too many results found" if results.length > 1

      result.first
    end

    # TODO: move results-check to another method
    def find_by_codes_hash
      results = model_class.where(codes_hash)

      return unless results.any?

      raise "Too many results found" if results.length > 1

      results.first
    end
  end
end
