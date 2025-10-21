require "minitest/assertions"

module Minitest
  module Assertions
    def assert_deeply_persisted(record, msg = nil, already_checked: [])
      return true if already_checked.include? record
      msg = message(msg) { "Expected #{mu_pp(record)} to be persisted" }
      assert record.persisted?, msg

      already_checked << record

      record.class.reflect_on_all_associations.each do |association|
        associated = record.send(association.name)

        case associated
        when ActiveRecord::Base
          assert_deeply_persisted(associated, already_checked: already_checked)
        when ActiveRecord::Associations::CollectionProxy, Array
          associated.each { assert_deeply_persisted(it, already_checked: already_checked) }
        else
          true
        end
      end
    end
  end
end
