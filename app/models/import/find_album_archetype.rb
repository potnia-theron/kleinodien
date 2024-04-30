module Import
  class FindAlbumArchetype
    include Concerns::CodeFindable

    def initialize(session, facade:)
      @session = session
      @facade = facade
    end

    attr_reader :facade, :session
    delegate :model_class, to: :facade

    # TODO: implement Import::FindAlbumArchetype#call
    def call
    end
  end
end
