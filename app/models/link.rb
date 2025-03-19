class Link < ApplicationRecord
  belongs_to :central, foreign_key: :source_id, primary_key: :centralable_id, inverse_of: :link_sources
  belongs_to :central, foreign_key: :destination_id, primary_key: :centralable_id, inverse_of: :link_destinations
  belongs_to :link_kind
end
