class AddHighestConversionStateToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :max_conversion_state, :string
  end
end
