module Import
  class CreateAction < CollectAction
    def initialize(session, facade:, **options)
      @optios = options
      super(session, facade: facade)
    end

    attr_reader :options
    delegate :attribute_getter_names, to: :properties
    delegate :belongs_to_attribute_getter_names, to: :properties

    def continue
      super
      record
    end

    def record
      @record ||= model_class.create!(attributes)
    end

    def attributes
      attribute_getter_names
        .transform_values { |getter_name| facade.send(getter_name) }
        .merge(belongs_to_attributes)
        .compact
    end

    def belongs_to_attributes
      belongs_to_attribute_getter_names.transform_values do |getter_name|
        facade
          .send(getter_name)
          &.then { |foreign_facade| session.build_create_action(facade: foreign_facade) }
          &.call
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
