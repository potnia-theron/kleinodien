class Participant < ApplicationRecord
  include Periodeable

  belongs_to :import_order, optional: true
  has_many :artist_credit_participants, dependent: :destroy
end
