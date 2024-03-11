module Import
  class FindArtistCredit
    def initialize(session, facade:)
      @session = session
      @facade = facade
    end

    attr_reader :facade, :session

    def call = nil
  end
end
