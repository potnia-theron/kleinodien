module Centralable
  extend ActiveSupport::Concern

  included do
    has_one :central, as: :centralable, dependent: :destroy

    before_create ->(centralable) { centralable.build_central }
  end
end
