module Ingestion
  class HasMany
    include Callable

    def initialize(calling)
      @calling = calling
    end

    def call
      has_many_association_reflections.each do |association_name, association_reflections|
        assign(association_name, association_reflections)
      end
    end

    private

    attr_reader :calling
    delegate :has_many_association_reflections, to: :reflections
    delegate_missing_to :calling

    def assign(association_name, association_reflections)
      HasManyHelper.call(self, association_name, association_reflections)
    end
  end
end
