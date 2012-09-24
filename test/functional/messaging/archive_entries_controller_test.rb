require 'test_helper'

class Messaging::ArchiveEntriesControllerTest < ActionController::TestCase
  setup do
    @messaging_archive_entry = messaging_archive_entries(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

end
