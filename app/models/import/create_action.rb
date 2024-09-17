module Import
  class CreateAction < Import::BaseAction
    def initialize(session, facade:, **options)
      @optios = options
      super(session, facade: facade)
    end

    attr_reader :options

    def continue
      super
      record
    end

    def record
      @record ||= model_class.create!(attributes)
    end

    def attributes
      ordinary_attributes.merge(foreign_attributes).compact
    end

    def foreign_attributes
      super.compact.transform_values do |foreign_facade|
        session.build_create_action(facade: foreign_facade).call
      end
    end

    def has_many_associations
      properties.has_many_associations.each { |association| persist_one_has_many_association(association) }
    end

    def persist_one_has_many_association(association)
      association_name = association.name
      option_name = association.inverse_of.name
      persisters = facade.send(association_name).to_persisters(option_name => record)
      persisters.each(&:call)
    end
  end
end
