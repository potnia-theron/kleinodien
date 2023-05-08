require "active_support/concern"
require "import_order_uri_type"

module Importable
  extend ActiveSupport::Concern

  included do
    attribute :uri, :import_order_uri
    attribute :state, default: :open

    belongs_to :import_order, optional: true
    belongs_to :user

    validates :code, presence: true
    validates :kind, presence: true
    validates :state, presence: true
  end
end
