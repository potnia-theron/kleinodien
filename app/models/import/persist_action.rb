module Import
  class PersistAction < CollectAction
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
      @record ||= model_class.create!(super.compact)
    end

    def has_many_associations
      properties.has_many_associations.each { |association| persist_one_has_many_association(association) }
    end

    def persist_one_has_many_association(association)
      association_name = association.name
      option_name = association.inverse_of.name
      persisters = facade.send(association_name).to_persisters(option_name => record)
      persisters.each(&:persist!)
    end
  end
end
