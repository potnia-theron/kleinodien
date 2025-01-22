module LayeredImport
  def self.ignite(import_order)
    order = Order.new(import_order)
    workflow = order.create_workflow
    workflow.start
  end
end
