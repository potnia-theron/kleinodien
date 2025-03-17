class Participant < ApplicationRecord
  include Periodable

  belongs_to :import_order, optional: true
  has_many :artist_credit_participants, dependent: :destroy
  has_one :central, as: :centralable, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :sort_name, presence: true

  before_validation :ensure_sort_name_has_a_value

  before_create ->(participant) { participant.build_central }

  private

  def ensure_sort_name_has_a_value
    return if sort_name.present?
    self.sort_name = name
  end
end
