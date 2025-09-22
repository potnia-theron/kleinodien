module MusicbrainzIngestionState
  class FindExisting
    def initialize(factory)
      @factory = factory
    end

    def call
      finder.call(facade)
    end

    private

    attr_reader :factory

    def facade = factory.facade

    def finder = factory.reflections.create_finder
  end
end
