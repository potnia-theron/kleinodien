module Import
  class Persist
    def initialize(session, facade:)
      @session = session
      @facade = facade
    end

    attr_reader :facade, :session

    def persist!
      persist_belongs_to!

      model_class = facade.model_class
      attributes = facade.attributes

      record = model_class.create!(attributes)

      persist_has_many!
      record
    end

    def persist_belongs_to!
      facade.belongs_to_associations.each do |association|
      end
    end

    def persist_has_many!
      facade.has_many_associations.each do |association|
        name = association.name
        facade_list = facade.send name
        persister_list = Import::PersisterList.new(session, facade_list: facade_list)
        persister_list.each(&:persist!)
      end
    end
  end
end
