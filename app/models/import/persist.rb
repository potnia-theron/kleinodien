module Import
  class Persist
    def initialize(session, facade:) # , properties:)
      @session = session
      @facade = facade
      # @properties = properties
    end

    attr_reader :facade, :session

    delegate :model_class, to: :facade

    def properties
      @properties ||= session.build_properties(model_class)
    end

    def persist!
      persist_belongs_to!

      model_class = facade.model_class
      # attributes = facade.attributes

      record = model_class.create!(attributes)

      persist_has_many!
      record
    end

    def attributes
      properties.coining_attributes.index_with { |attr_name| facade.send(attr_name) }
    end

    def persist_belongs_to!
      facade.belongs_to_associations.each do |association|
      end
    end

    def persist_has_many!
      facade.has_many_associations.each do |association|
        name = association.name
        facade_list = facade.send name
        # persister_list = Import::PersisterList.new(session, facade_list: facade_list)
        persister_list = session.build_persister_list(facade_list)
        # debugger
        persister_list.each(&:persist!)
      end
    end
  end
end
