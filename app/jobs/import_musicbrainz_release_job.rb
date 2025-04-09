class ImportMusicbrainzReleaseJob < ApplicationJob
  queue_as :default

  def perform(import_order)
    # TODO: remove all the dirty tricks
    import_order.type = "MusicbrainzImportOrder"
    import_order.save!

    # order = Import::Order.new(import_order)
    order = Import::Order.new(MusicbrainzImportOrder.find(import_order.id))
    Rails.logger.info("==== ImportOrder: #{order.inspect}")
    Rails.logger.info("==== ImportOrder#uri#import_order_type: #{order.uri.import_order_type}")
    Rails.logger.info("=== ImportOrder.target_kind: #{order.target_kind}")

    order.build_workflow.call
  end
end
