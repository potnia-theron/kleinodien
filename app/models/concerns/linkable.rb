module Linkable
  extend ActiveSupport::Concern
  include Centralable

  included do
    has_many :links, through: :central
  end
end
