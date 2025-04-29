require "test_helper"

class ImportOrderTest < ActiveSupport::TestCase
  extend ActiveSupport::Testing::Declarative

  test "derive kind and code from a MusicBrainz uri" do
    import_order = ImportOrder.new(
      import_orderable: musicbrainz_import_orders(:one),
      user: users(:kim)
    )

    assert import_order.valid?
  end
end
