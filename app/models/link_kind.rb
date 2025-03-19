class LinkKind < ApplicationRecord
  has_many :links, dependent: :restrict_with_error
end
