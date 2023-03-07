class MusicBrainzImportOrder < ImportOrder
  validates :code, presence: true
  validates :kind, presence: true
  validates :state, presence: true
  validates :user, presence: true
end
