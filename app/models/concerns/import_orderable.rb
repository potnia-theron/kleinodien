module ImportOrderable
  extend ActiveSupport::Concern

  included do
    has_one :import_order, as: :import_orderable, touch: true, dependent: :destroy
  end
end
