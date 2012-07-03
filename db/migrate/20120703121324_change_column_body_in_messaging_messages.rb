class ChangeColumnBodyInMessagingMessages < ActiveRecord::Migration
  def up
    change_column  :messaging_messages, :body, :text, :limit => nil
  end

  def down
    change_column  :messaging_messages, :body, :string
  end
end
