module Import
  class MusicbrainzCreator
    def self.call(...)
      new(...).call
    end

    def initialize(session, facade)
      @session = session
      @facade = facade
    end

    def call
      find || create
    end

    private

    attr_reader :facade, :session

    def find
      finder = session.build_finder(facade)
      finder.call
    end

    def create
      Rails.logger.info("persisting data")

      ActiveRecord::Base.transaction do
        create_action.call
      end
    end

    def create_action
      session.build_create_action(facade: facade)
    end
  end
end
