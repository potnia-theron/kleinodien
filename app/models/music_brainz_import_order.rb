class MusicBrainzImportOrder < ImportOrder
  include Importable

  enum :state, {open: 0, buffering: 1, persisting: 2, done: 3, failed: 4}, default: :open
end
