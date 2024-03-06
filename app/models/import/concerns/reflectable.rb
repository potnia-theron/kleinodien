module Import::Concerns
  # https://rewind.com/blog/zeitwerk-autoloader-rails-app/
  module Reflectable
    extend ActiveSupport::Concern

    def model_class
      properties_class_name = self.class.name
      mad = properties_class_name.match(%r{\AImport::(.+)Properties\z})
      class_name = mad[1]
      class_name.constantize
    end

    def coining_attributes
      model_class.attribute_names
        .without("id", "created_at", "updated_at")
        .reject { |attr| attr.end_with? "_id" }
        .reject { |attr| attr.end_with? "_code" }
    end

    def belongs_to_associations
      model_class.reflect_on_all_associations(:belongs_to)
    end

    def has_and_belongs_to_many_associations
      model_class.reflect_on_all_associations(:has_and_belongs_to_many)
    end

    def has_many_associations
      model_class.reflect_on_all_associations(:has_many)
    end
  end
end
