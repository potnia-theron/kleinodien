class Central < ApplicationRecord
  belongs_to :centralable, polymorphic: true
  self.primary_key = "centralable_id"
end
