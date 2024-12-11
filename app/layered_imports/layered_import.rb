module LayeredImport
  def self.initiate(import_order)
    import_order
      # TODO: remove #downcase and titleize. This requires MusicBrainzImportOrder to be renamed
      .type
      .delete_suffix("ImportOrder")
      # delete
      .downcase
      .titleize
      # /delete
      .prepend("LayeredImport::")
      .concat("Workflow")
      .constantize
      .new(import_order)
      .start
  end
end
