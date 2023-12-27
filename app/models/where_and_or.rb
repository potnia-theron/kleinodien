class WhereAndOr
  def self.and(*)
    new(*).and
  end

  def self.or(*)
    new(*).or
  end

  def initialize(model_class, arguments)
    @model_class = model_class.constantize
    @arguments = arguments
  end

  def and
    where_arguments = parameters(" AND ")
    model_class.where(where_arguments)
  end

  def or
    where_arguments = parameters(" OR ")
    model_class.where(where_arguments)
  end

  private

  attr_reader :arguments, :model_class

  def parameters(join_with)
    [query_string(join_with), arguments.values].flatten
  end

  def query_string(join_with)
    arguments.keys.map { |column| "#{column} = ?" }.join(join_with)
  end
end
