module Periodeable
  extend ActiveSupport::Concern
  include DateAccuracy

  included do
    enum :begin_date_accuracy, DATE_ACCURACY_MASK, prefix: :begin_date_accuracy
    enum :end_date_accuracy, DATE_ACCURACY_MASK, prefix: :end_date_accuracy

    composed_of :begins_at, class_name: "IncompleteDate", mapping: {begin_date: :date, begin_date_accuracy: :accuracy}
    composed_of :ends_at, class_name: "IncompleteDate", mapping: {end_date: :date, end_date_accuracy: :accuracy}
  end
end
