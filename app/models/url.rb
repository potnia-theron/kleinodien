class Url < ApplicationRecord
  include Centralable
  include Linkable

  validates :address, presence: true
end
