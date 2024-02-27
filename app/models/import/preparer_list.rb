module Import
  class PreparerList
    include Enumerable

    def initialize(session, presenter_list:)
      @session = session
      @presenter_list = presenter_list
    end

    attr_reader :presenter_list, :session

    def each
      presenter_list.map { |presenter| session.build_preparer(presenter) }
    end
  end
end
