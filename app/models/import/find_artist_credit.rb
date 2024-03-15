module Import
  class FindArtistCredit
    def initialize(session, facade:)
      @session = session
      @facade = facade
    end

    attr_reader :facade, :session

    def call
      name = facade.name

      ArtistCredit.find_by(name: name)
    end
  end
end
