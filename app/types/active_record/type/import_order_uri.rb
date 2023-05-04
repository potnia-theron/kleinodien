# https://michaeljherold.com/articles/extending-activerecord-with-custom-types/
module ActiveRecord
  module Type
    class ImportOrderUri < String
      def serialize(value)
        value.to_s.presence
      end

      def type = :import_order_uri

      private

      def cast_value(value)
        ::ImportOrderUri.build(value)
      end
    end

    register :import_order_uri, ImportOrderUri
  end
end
