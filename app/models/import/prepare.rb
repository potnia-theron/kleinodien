module Import
  class Prepare
    def self.call(...)
      new(...).call
    end

    def initialize(session, model:, presenter:)
      @session = session
      @model = model
      @presenter = presenter
    end

    attr_reader :session, :model, :presenter

    def call
      find || buffer && nil
    end

    def find
      finder = session.build_finder(presenter)
      finder.call
    end

    def buffer
      # prepare_belongs_to
      prepare_has_many_associations
      prepare_has_and_belongs_to_many_associations
    end

    def prepare_belongs_to
      associations = model.belongs_to_associations

      associations.each do |association|
        # ???
      end
    end

    def prepare_has_many_associations
      presenter.has_many_associations.each do |assoc|
        # asso_class_name = asso.class_name
        # asso_column_name = asso.inverse_of.name

        # factory.build_presenter_list()
        name = asso.name
        raw_data = asso.send name
        list = factory.build_presenter_list(association: asso, data: raw_data)
        # list.each(&:pepare)
        list.each do |presenter_x|
          preparer = factory.build_preparer(presenter_x, skip: [name])
          preparer.prepare
        end
      end
    end

    def prepare_has_and_belongs_to_many_associations
    end
  end
end
