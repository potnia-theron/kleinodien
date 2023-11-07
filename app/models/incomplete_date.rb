class IncompleteDate
  attr_accessor :accuracy, :date

  def initialize(date, accuracy)
    @date = date
    @accuracy = accuracy
  end
end
