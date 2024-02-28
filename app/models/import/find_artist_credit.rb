module Import
  class FindArtistCredit
    # Does not need a session,
    # all calls to external apis are done by the facade
    def initialize(facade)
      @facade = facade
    end

    attr_reader :facade, :session

    # model ????

    def call
      find_by_intrinsic_code || find_by_all_codes
    end

    def find_by_intrinsic_code
      attrs = facade.intrinsic_code
      return unless attrs

      model.record_class.find(attrs)
    end

    def find_by_all_codes
      attrs = facade.all_codes
      return unless attrs

      result = model.record_class.find(attrs)
      return unless result.any?
      raise "Too much reslts" if result.length != 1

      result.first
    end
  end
end
