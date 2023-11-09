module Periodeable
  extend ActiveSupport::Concern
  include DateAccuracy

  included do
    enum :begin_date_accuracy, DATE_ACCURACY_MASK, prefix: :begin_date_accuracy
    enum :end_date_accuracy, DATE_ACCURACY_MASK, prefix: :end_date_accuracy

    composed_of :begins_at, class_name: "IncompleteDate", mapping: {begin_date: :date, begin_date_accuracy: :accuracy}
    composed_of :ends_at, class_name: "IncompleteDate", mapping: {end_date: :date, end_date_accuracy: :accuracy}

    validate :begins_all_or_nothing
    validate :ends_all_or_nothing
  end

  def begins_all_or_nothing
    if begin_date.present? ^ begin_date_accuracy.present?
      errors.add(:begin_date, "either begin_date and begin_date_accuracy must be set or neither of them")
    end
  end

  def ends_all_or_nothing
    if end_date.present? ^ end_date_accuracy.present?
      errors.add(:end_date, "either end_date and end_date_accuracy must be set or neither of them")
    end
  end
end
