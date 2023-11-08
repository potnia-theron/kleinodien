class IncompleteDate
  include DateAccuracy
  attr_reader :accuracy, :date

  def initialize(date, accuracy)
    date = Date.iso8601(date) if date.is_a? String
    @date = date

    raise ArgumentError, "invalid accuracy" unless accuracy.in? DATE_ACCURACY_VALUES
    @accuracy = accuracy
  end
end
