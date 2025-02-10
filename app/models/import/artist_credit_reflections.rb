module Import
  class ArtistCreditReflections
    include Concerns::Reflectable

    delegate_missing_to ArtistCredit
  end
end
