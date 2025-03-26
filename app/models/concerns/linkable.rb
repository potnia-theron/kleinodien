module Linkable
  extend ActiveSupport::Concern
  include Centralable

  included do
    has_many :links, through: :central
    has_many :backlinks, through: :central
  end
end
