module IngestKit
  class Many
    def initialize(association, facade, reflections)
      @association = association
      @facade = facade
      @reflections = reflections
    end

    attr_reader :association, :facade, :reflections
    delegate :any?, :none?, to: :kits
    delegate_missing_to :association

    def facades = facade.scrape(name)

    def kits
      facades.map { Single.new(it, associated_reflections) }
    end

    def associated_reflections
      @associated_reflections ||= reflections.create(association.class_name)
    end
  end
end
