require "active_support/concern"

module Importable
  extend ActiveSupport::Concern

  included do
    attribute :state, default: :open

    belongs_to :import_order, optional: true
    belongs_to :user

    validates :code, presence: true
    validates :kind, presence: true
    validates :state, presence: true
  end
end
