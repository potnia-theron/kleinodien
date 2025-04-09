class ImportOrder < ApplicationRecord
  include Importable

  VALID_INFERRED_TYPE_REGEX = %r{\A[A-Z][a-z]+ImportOrder\z}

  before_validation :set_kind_and_code

  def inferred_type
    return type if type.present?

    class_name = self.class.name
    return class_name if VALID_INFERRED_TYPE_REGEX.match? class_name

    class_name = uri&.import_order_type
    class_name if class_name.match? %r{\A[A-Z][a-z]+ImportOrder\z}
  end

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
