module SharedLinkableTests
  extend ActiveSupport::Testing::Declarative

  test "subject is linkable" do
    assert_instance_of Link, @subject.links.build
  end
end
