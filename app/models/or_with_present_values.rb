class OrWithPresentValues
  def self.query(...)
    new(...).query
  end

  def initialize(attributes:, model_class:)
    @attributes = attributes
    @model_class = model_class
  end

  attr_reader :attributes, :model_class

  def query
    pairs = attributes.compact
    return unless pairs.any?

    first_pair = pairs.shift

    query = model_class.where(first_pair.first => first_pair.second)
    pairs.each { |attr, value| query.or(model_class.where(attr => value)) }

    query
  end
end
