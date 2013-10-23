class CreateFacebookObjectTypes < ActiveRecord::Migration
  def change
    create_table :facebook_object_types do |t|
      t.string :url
      t.string :title
      t.string :image
      t.string :type
      t.string :locale
      t.string :description
      t.string :determiner
      t.string :restrictions
      t.string :see_also

      t.timestamps
    end
  end
end
