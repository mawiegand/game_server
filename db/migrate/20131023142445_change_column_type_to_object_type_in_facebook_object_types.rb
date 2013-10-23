class ChangeColumnTypeToObjectTypeInFacebookObjectTypes < ActiveRecord::Migration
  def change
    rename_column :facebook_object_types, :type, :type_name
  end

end
