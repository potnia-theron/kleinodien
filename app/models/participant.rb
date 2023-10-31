class Participant < ApplicationRecord
  belongs_to :import_order, optional: true

  include Periodeable
end
