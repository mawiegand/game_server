class AddInvitationCodeToFundamentalAlliance < ActiveRecord::Migration
  def up
    add_column :fundamental_alliances, :invitation_code, :string

    Fundamental::Alliance.all.each do |alliance|
      alliance.add_unique_invitation_code
      alliance.save
    end
  end
  
  def down
    remove_column :fundamental_alliances, :invitation_code
  end  
end
