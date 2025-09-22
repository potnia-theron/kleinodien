module IngestionReflections
  class ArtistCredit
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    delegate_missing_to ::ArtistCredit

    def class_name = ::ArtistCredit.name

    private

    attr_reader :factory
  end
end
