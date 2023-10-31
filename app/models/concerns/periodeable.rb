module Periodeable
  extend ActiveSupport::Concern
  include DateAccuracy

  included do
    enum :begin_date_accuracy, DATE_ACCURACY_MASK, prefix: :begin_date_accuracy
    enum :end_date_accuracy, DATE_ACCURACY_MASK, prefix: :end_date_accuracy
  end
end
