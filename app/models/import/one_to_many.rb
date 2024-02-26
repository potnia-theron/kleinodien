module Import
  class OneToMany
    def initialize(session, one:, many:)
      @session = session
      @one = one
      @many = many
    end

    attr_reader :many, :one, :session

    def many_presenters
      raw_items = one.send
    end

    def one_reflection
      one.reflect_on_association(many)
    end

    def any_class
      class_name = one_reflection.class
      class_name.constantize
    end
  end
end
