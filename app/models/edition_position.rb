class EditionPosition < ApplicationRecord
  belongs_to :edition

  belongs_to :section, class_name: "EditionSection", foreign_key: "edition_section_id", inverse_of: :positions
end
