class Fundamental::DiplomacyRelation < ActiveRecord::Base
  RELATION_TYPE_NEUTRAL      = 0
  RELATION_TYPE_ULTIMATUM    = 1
  RELATION_TYPE_WAR          = 2
  RELATION_TYPE_SURRENDER    = 3
  RELATION_TYPE_OCCUPATION   = 4

  belongs_to :source_alliance, :class_name => "Fundamental::Alliance", :foreign_key => "source_alliance_id", :inverse_of => :diplomacy_source_relations
  belongs_to :target_alliance, :class_name => "Fundamental::Alliance", :foreign_key => "target_alliance_id", :inverse_of => :diplomacy_target_relations
  
  scope :neutral, where(diplomacy_status: RELATION_TYPE_NEUTRAL)
  scope :ultimatum, where(diplomacy_status: RELATION_TYPE_ULTIMATUM)
  scope :war, where(diplomacy_status: RELATION_TYPE_WAR)
  scope :surrender, where(diplomacy_status: RELATION_TYPE_SURRENDER)
  scope :occupation, where(diplomacy_status: RELATION_TYPE_OCCUPATION)
  
end
