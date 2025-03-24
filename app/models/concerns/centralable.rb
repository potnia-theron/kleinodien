module Centralable
  extend ActiveSupport::Concern

  included do
    has_one :central, as: :centralable, dependent: :destroy

    after_initialize :ensure_central

    before_create :find_central

    private

    def ensure_central
      return if central

      self.central = new_record? && build_central || find_central || create_central
    end

    # TODO: Why do we need this method?
    # This method is not only called by ensure_central but also from some unknown sources
    def find_central
      return unless id

      Central.find(id)
    end
  end
end
