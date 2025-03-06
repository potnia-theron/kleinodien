class EditionPosition < ApplicationRecord
  belongs_to :edition
  belongs_to :edition_section
end
