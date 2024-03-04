module Import::Concerns
  # https://rewind.com/blog/zeitwerk-autoloader-rails-app/
  module Reflectable
    extend ActiveSupport::Concern

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
