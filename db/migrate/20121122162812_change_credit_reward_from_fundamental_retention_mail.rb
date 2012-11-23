class ChangeCreditRewardFromFundamentalRetentionMail < ActiveRecord::Migration
  def up
    remove_column  :fundamental_retention_mails,   :credit_reward 

    add_column     :fundamental_retention_mails,   :credit_reward,   :integer,  {:default => 0, :null => false}    
  end

  def down
    remove_column  :fundamental_retention_mails,   :credit_reward 

    add_column     :fundamental_retention_mails,   :credit_reward,   :integer,  {:default => 1, :null => false}    
  end
end
