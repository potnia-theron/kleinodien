module LayeredImport
  class ArtistCreditFinder
    include Concerns::CodeFindable

    def initialize(order, facade:)
      @order = order
      @facade = facade
    end

    attr_reader :facade, :order

    def find
      # this guard-clause ...
      # - may not be ok in a non-musicbrainz.org context
      # - is maybe unnecessary in "real" scenarios
      #   - but is needed for LayeredImport::ImportAnArtistCreditFromMusicbrainzTest
      return unless order.buffering?

      name = facade.name

      ArtistCredit.find_by(name: name)
    end
  end
end
