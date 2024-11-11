module Import
  class MusicbrainzCollector
    def self.call(...)
      new(...).call
    end

    def initialize(session, facade)
      @session = session
      @facade = facade
    end

    attr_reader :facade, :session

    def call
      find || collect
    end

    private

    def find
      finder = session.build_finder(facade)
      finder.call
    end

    def collect
      collector = session.build_collect_action(facade: facade)
      collector.call
    end
  end
end
