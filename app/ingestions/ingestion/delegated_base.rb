module Ingestion
  class DelegatedBase
    include Callable
    def initialize(calling)
      @calling = calling
    end

    def call
      return unless delegated_base_class

      record.send(writer, associated)
      base2base
    end

    private

    attr_reader :calling
    delegate :delegated_base_class, to: :reflections
    delegate :delegated_base_associations, to: :delegated_base_class

    delegate_missing_to :calling

    def writer = reflections.delegated_of_association_writer

    def associated_reflections = reflections.delegated_base

    # Note that we don't call #procreate here.
    # Otherwise we would get an ActiveRecord::RecordInvalid exception:
    # "<Class name> must exist"
    def associated = @associated ||= Buffering.call(facade, associated_reflections)

    def base2base = delegated_base_associations.map { base2base_assign(it) }

    def base2base_assign(association) = DelegatedBaseToBase.call(self, associated, association)
  end
end
