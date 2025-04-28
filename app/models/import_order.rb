class ImportOrder < ApplicationRecord
  belongs_to :import_order, optional: true
  belongs_to :user

  delegated_type :import_orderable, types: %w[MusicbrainzImportOrder]
  accepts_nested_attributes_for :import_orderable

  VALID_INFERRED_TYPE_REGEX = %r{\A[A-Z][a-z]+ImportOrder\z}

  # before_validation :set_kind_and_code

  delegate_missing_to :import_orderable

  private

  def set_kind_and_code
    return if kind.present?
    return if code.present?
    return if uri.blank?

    import_order_uri = ImportOrderUri.build(uri)
    self.kind = import_order_uri.kind
    self.code = import_order_uri.code
  end
end
