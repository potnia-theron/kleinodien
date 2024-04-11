module Import
  class ArtistCreditProperties
    include Concerns::Reflectable

    def model_class = ArtistCredit
  end
end
