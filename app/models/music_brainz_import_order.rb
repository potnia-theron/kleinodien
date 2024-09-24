class MusicBrainzImportOrder < ImportOrder
  include BufferableImport
  include Importable
  include Transitionable

  validates :code, format: {
    with: %r{[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}},
    message: "must be an UUID"
  }

  before_validation :set_kind_and_code
  def perform
    Import::MusicbrainzHandler.new(self).call
  end
end
