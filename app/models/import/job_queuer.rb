module Import
  class JobQueuer
    include Callable

    def initialize(import_order)
      @import_order = import_order
    end

    def call
      job_class.perform_later(import_order)
    end

    private

    attr_reader :import_order

    def job_class
      x = inferred_order_type
        .then { it.delete_suffix("ImportOrder") }
        .then { "Import#{it}#{kind_title}Job" }

      Rails.logger.info("inferred_order_type: #{inferred_order_type}")
      Rails.logger.info("import_order.uri: #{import_order.uri.inspect}")
      Rails.logger.info("import_order.uri.class: #{import_order.uri.class}")
      Rails.logger.info(import_order.inspect)
      Rails.logger.info("Class Name: #{x}")
      # debugger
      x.constantize
    end

    def inferred_order_type = import_order.inferred_type

    def kind_title = import_order.kind.to_s.titleize

    # def order = Import::Order.new(import_order)
  end
end
