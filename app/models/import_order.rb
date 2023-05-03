class ImportOrder < ApplicationRecord
  include Importable

  before_validation :set_kind_and_code

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
