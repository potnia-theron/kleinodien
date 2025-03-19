class Central < ApplicationRecord
  self.primary_key = "centralable_id"
  belongs_to :centralable, polymorphic: true

  has_many :link_sources, class_name: "Link", foreign_key: "source_id", primary_key: "centralable_id"
  has_many :link_destinations, class_name: "Link", foreign_key: "destination_id", primary_key: "centralable_id"
end
