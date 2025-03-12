module Import
  def self.ignite(import_order)
    order = Order.new(import_order)
    workflow = order.build_workflow
    workflow.call
  end
end
