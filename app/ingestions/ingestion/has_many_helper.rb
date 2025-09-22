module Ingestion
  class HasManyHelper
    include Callable

    def initialize(ingestion, association_name, association_reflections)
      @ingestion = ingestion
      @association_name = association_name
      @association_reflections = association_reflections
    end

    def call
      facade.scrape(association_name).each do |association_facade|
        proxy << procreate(association_facade, association_reflections)
      end
    end

    private

    attr_reader :association_name, :association_reflections, :ingestion
    delegate_missing_to :ingestion

    def proxy = @proxy ||= record.send(association_name)
  end
end
