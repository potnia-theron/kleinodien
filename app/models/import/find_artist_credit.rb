module Import
  class FindArtistCredit
    # Does not need a session,
    # all calls to external apis are done by the presenter
    def initialize(presenter)
      @presenter = presenter
    end

    attr_reader :presenter, :session

    # model ????

    def call
      find_by_intrinsic_code || find_by_all_codes
    end

    def find_by_intrinsic_code
      attrs = presenter.intrinsic_code
      return unless attrs

      model.record_class.find(attrs)
    end

    def find_by_all_codes
      attrs = presenter.all_codes
      return unless attrs

      result = model.record_class.find(attrs)
      return unless result.any?
      raise "Too much reslts" if result.length != 1

      result.first
    end
  end
end
