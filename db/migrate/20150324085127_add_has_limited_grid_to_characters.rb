class AddHasLimitedGridToCharacters < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :has_limited_grid, :boolean, default: false
  end
end
