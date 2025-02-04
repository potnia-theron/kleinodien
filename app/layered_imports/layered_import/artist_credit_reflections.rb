module LayeredImport
  class ArtistCreditReflections
    include Concerns::Reflectable

    delegate_missing_to ArtistCredit

    def has_many_associations = reflect_on_all_associations(:has_many)
  end
end
