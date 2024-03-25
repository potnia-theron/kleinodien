module Import
  class Persist
    def initialize(session, facade:, **options)
      @session = session
      @facade = facade
      @options = options
    end

    attr_reader :facade, :options, :session

    delegate :model_class, to: :facade

    def persist!
      persist_has_many_associations
      record
    end

    private

    def attributes
      properties
        .coining_attributes
        .index_with { |attr_name| facade.send(attr_name) }
        .merge(persist_belongs_to_associations)
    end

    def build_one_belongs_to_association_persister(association)
      session.build_one_belongs_to_association_persister(association: association, other: self)
    end

    def persist_belongs_to_associations
      properties.belongs_to_associations.map do |association|
        build_one_belongs_to_association_persister(association).persist
      end.to_h
    end

    def persist_has_many_associations
      properties.has_many_associations.each { |association| persist_one_has_many_association(association) }
    end

    def persist_one_has_many_association(association)
      association_name = association.name
      option_name = association.inverse_of.name
      persisters = facade.send(association_name).to_persisters(option_name => record)
      persisters.each(&:persist!)
    end

    def properties
      @properties ||= session.build_properties(model_class)
    end

    def record
      @record ||= model_class.create!(attributes)
    end
  end
end
