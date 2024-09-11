module Archetypeable
  extend ActiveSupport::Concern

  included do
    has_one :archetype, as: :archetypeable, touch: true
  end
end
