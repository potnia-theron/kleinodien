module Import
  class Persist
    def initialize(session, facade:, **options)
      @session = session
      @facade = facade
      @options = options
    end

    attr_reader :facade, :options, :record, :session

    delegate :model_class, to: :facade

    def properties
      @properties ||= session.build_properties(model_class)
    end

    def persist!
      belongs_to_attrs = persist_belongs_to!

      # model_class = facade.model_class
      attrs = belongs_to_attrs.merge(attributes)
      @record = model_class.create!(attrs)

      persist_has_many!
      record
    end

    def attributes
      properties.coining_attributes.index_with { |attr_name| facade.send(attr_name) }
    end

    def persist_belongs_to!
      # properties.belongs_to_associations.map do |association|
      assos = model_class.reflect_on_all_associations(:belongs_to).reject { |association| association.name == :import_order }
      assos.map do |association|
        key = association.name
        value = options[key]
        if !value
          other_facade = session.build_facade(association.klass, data: facade.data)

          persister = session.build_persister(other_facade)
          value = persister.persist!
        end

        [key, value]
      end.to_h
    end

    def persist_has_many!
      properties.has_many_associations.each do |association|
        name = association.name
        facade_list = facade.send name
        option = association.inverse_of.name
        # persister_list = Import::PersisterList.new(session, facade_list: facade_list)
        persister_list = session.build_persister_list(facade_list, option => @record)
        persister_list.each(&:persist!)
      end
    end
  end
end
