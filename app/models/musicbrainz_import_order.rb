class MusicbrainzImportOrder < ImportOrder
  include BufferableImport
  include Importable
  include Transitionable

  def self.model_name = ImportOrder.model_name

  validates :code, format: {
    with: %r{[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}},
    message: "must be an UUID"
  }

  before_validation :set_kind_and_code

  def target_kind
    return :album_edition if kind.to_sym == :release

    kind
  end
end
