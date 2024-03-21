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

      attrs = belongs_to_attrs.merge(attributes)
      @record = model_class.create!(attrs)

      persist_has_many!
      record
    end

    def attributes
      properties.coining_attributes.index_with { |attr_name| facade.send(attr_name) }
    end

    def persist_belongs_to!
      assos = model_class.reflect_on_all_associations(:belongs_to).reject { |association| association.name == :import_order }
      assos.map do |association|
        association_persister = Import::OneBelongsToAssociationPersister.new(session, association: association, other: self)
        association_persister.persist
      end.to_h
    end

    def persist_has_many!
      properties.has_many_associations.each do |association|
        association_name = association.name
        option = association.inverse_of.name
        persisters = facade.send(association_name).to_persisters(option => @record)
        persisters.each(&:persist!)
      end
    end
  end
end
