class ImportOrder < ApplicationRecord
  belongs_to :import_order, optional: true
  belongs_to :user

  delegated_type :import_orderable, types: %w[MusicbrainzImportOrder]
  accepts_nested_attributes_for :import_orderable

  delegate_missing_to :import_orderable
end
