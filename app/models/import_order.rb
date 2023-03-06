class ImportOrder < ApplicationRecord
  belongs_to :import_order, optional: true
  belongs_to :user
end
