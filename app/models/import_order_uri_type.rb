# https://michaeljherold.com/articles/extending-activerecord-with-custom-types/
# https://fly.io/ruby-dispatch/humane-rails-forms/
class ImportOrderUriType < ActiveRecord::Type::Value
  def serialize(value)
    value.to_s.presence
  end

  def type = :import_order_uri

  private

  def cast_value(value)
    ImportOrderUri.build(value)
  end
end

ActiveRecord::Type.register :import_order_uri, ImportOrderUriType
