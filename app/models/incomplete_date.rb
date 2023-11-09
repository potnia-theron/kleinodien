class IncompleteDate
  include DateAccuracy
  attr_reader :accuracy, :date

  def initialize(date, accuracy)
    date = Date.iso8601(date) if date.is_a? String
    @date = date

    if accuracy.present? && DATE_ACCURACY_VALUES.exclude?(accuracy)
      raise ArgumentError, "invalid accuracy #{accuracy}"
    end

    @accuracy = accuracy
  end

  def year
    date&.year
  end

  def month
    date&.month
  end

  def day
    date&.day
  end
end
