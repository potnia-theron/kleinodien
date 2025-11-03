module IngestionReflections
    class ArtistCredit < Base
    # include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    def record_class = ::ArtistCredit

    delegate_missing_to :record_class

    def class_name = ::ArtistCredit.name

    private

    attr_reader :factory
  end
end
