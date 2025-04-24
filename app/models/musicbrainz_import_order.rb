class MusicbrainzImportOrder < ApplicationRecord
  include BufferableImport
  include ImportOrderable

  before_validation :set_kind_and_code

  # TODO: remove this when we have a proper way to set the target_kind
  # def target_kind = "album_archetype"
  # def target_kind = kind
  def target_kind
    return "AlbumEdition" if kind == "release"
    kind
  end

  def set_kind_and_code
    return if kind.present?
    return if code.present?
    return if uri.blank?

    import_order_uri = ImportOrderUri.build(uri)
    self.kind = import_order_uri.kind
    self.code = import_order_uri.code
  end
end
