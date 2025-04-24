class ImportMusicbrainzReleaseJob < ApplicationJob
  queue_as :default

  def perform(import_order)
    # TODO: remove all the dirty tricks
    # import_order.type = "MusicbrainzImportOrder"
    # import_order.save!

    # order = Import::Order.new(import_order)
    order = Import::Order.new(ImportOrder.find(import_order.id))
    Rails.logger.info("==== ImportOrder: #{order.inspect}")

    order.build_workflow.call
  end
end
