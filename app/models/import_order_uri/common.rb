module ImportOrderUri
  module Common
    def kind_and_code = nil

    def import_order_class = ImportOrder

    def code
      kind_and_code&.named_captures&.dig("code")
    end

    def kind
      kind_and_code&.named_captures&.dig("kind")
    end
  end
end
