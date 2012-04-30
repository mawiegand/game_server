class Military::BattleFaction < ActiveRecord::Base

  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id", :counter_cache => true

end
