class IncompleteDate
  include ActiveModel::Validations
  include DateAccuracy
  attr_accessor :accuracy, :date

  validates :accuracy, inclusion: {in: DateAccuracy::DATE_ACCURACY_VALUES}
  validate :is_a_date, :is_a_date
  validate :all_or_nothing, :all_or_nothing

  def initialize(date, accuracy)
    @date = date
    @accuracy = accuracy
  end

  private

  def all_or_nothing
    return unless date.nil? ^ accuracy.nil?

    errors.add("Either #date and #accuracy are set or neither of them")
  end

  def is_a_date
    return unless date
    return if date.is_a?(Date)

    errors.add("#{date} is not an instance of Date")
  end
end
