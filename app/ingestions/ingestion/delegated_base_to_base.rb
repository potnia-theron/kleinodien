module Ingestion
  class DelegatedBaseToBase
    include Callable

    def initialize(calling_base, associated, association)
      @calling_base = calling_base
      @associated = associated
      @association = association
    end

    def call
      associated.send(writer, associated_base)
    end

    private

    attr_reader :associated, :association, :calling_base
    delegate :delegated_base_reader, to: :association
    delegate :name, to: :association, prefix: true
    delegate_missing_to :calling_base

    def associated_base = associated_type.send(delegated_base_reader)

    def associated_facade = facade.scrape(association_name)

    def associated_reflections = association.delegated_class_reflections_for(associated)

    def associated_type = Buffering.call(associated_facade, associated_reflections)

    def writer = "#{association_name}="
  end
end
