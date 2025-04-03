class ImportMusicbrainzReleaseJob < ApplicationJob
  queue_as :default

  def perform(import_order)
    # Import::MusicbrainzWorkflow.call(...)
    Rails.logger.info("=================================================")
    order = Import::Order.new(import_order)
    Rails.logger.info(order.inspect)
    # Import.ignite(import_order)
    order.build_workflow.call
  end
end
