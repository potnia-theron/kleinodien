module Import
  class PresenterList
    include Enumerable

    def initialize(session, class_name:, data:)
      @session = session
      @class_name = class_name
      @data = data
    end

    attr_reader :data, :session

    def each
      data.map { |raw| session.build_presenter(class_name: class_name, data: raw) }
    end
  end
end
