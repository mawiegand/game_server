require 'test_helper'

class Messaging::InboxEntriesControllerTest < ActionController::TestCase
  setup do
    @messaging_inbox_entry = messaging_inbox_entries(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

end
