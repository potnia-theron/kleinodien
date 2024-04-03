module Import
  class CreateAction < CollectAction
    def initialize(session, facade:, **options)
      @optios = options
      super(session, facade: facade)
    end

    attr_reader :options

    def continue
      super
      persist
      # record
    end

    def persist
      new_record
    end

    def new_record
      @new_record ||= model_class.create!(attributes)
    end

    def attributes
      attr = properties.belongs_to_association_names.index_with do |a_name|
        bel2_facade = facade.send(a_name)
        action = session.build_create_action(facade: bel2_facade)
        action.call
      end

      properties.attribute_names.index_with { |attr_name| facade.send(attr_name) }.merge(attr).compact
    end

    def has_many_associations
      properties.has_many_associations.each { |association| persist_one_has_many_association(association) }
    end

    def persist_one_has_many_association(association)
      association_name = association.name
      option_name = association.inverse_of.name
      persisters = facade.send(association_name).to_persisters(option_name => new_record)
      persisters.each(&:call)
    end
  end
end
