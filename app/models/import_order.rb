class ImportOrder < ApplicationRecord
  belongs_to :import_order, optional: true
  belongs_to :user

  delegated_type :import_orderable, types: %w[MusicbrainzImportOrder]
  accepts_nested_attributes_for :import_orderable

  VALID_INFERRED_TYPE_REGEX = %r{\A[A-Z][a-z]+ImportOrder\z}

  delegate_missing_to :import_orderable
end
