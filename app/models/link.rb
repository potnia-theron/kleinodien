class Link < ApplicationRecord
  belongs_to :source, class_name: "Central", primary_key: :centralable_id, inverse_of: :links
  belongs_to :destination, class_name: "Central", primary_key: :centralable_id, inverse_of: :backlinks
  belongs_to :link_kind
end
