class EditionSection < ApplicationRecord
  belongs_to :edition

  has_many :positions, class_name: "EditionPosition", inverse_of: :section, dependent: :destroy
end
