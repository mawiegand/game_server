class Fundamental::DiplomacyRelation < ActiveRecord::Base
  RELATION_TYPE_NEUTRAL      = 0
  RELATION_TYPE_ULTIMATUM    = 1
  RELATION_TYPE_WAR          = 2
  RELATION_TYPE_SURRENDER    = 3
  RELATION_TYPE_OCCUPATION   = 4
  
  has_one    :event,  :class_name => "Event::Event",    :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'diplomacy_relation'"

  belongs_to :source_alliance, :class_name => "Fundamental::Alliance", :foreign_key => "source_alliance_id", :inverse_of => :diplomacy_source_relations
  belongs_to :target_alliance, :class_name => "Fundamental::Alliance", :foreign_key => "target_alliance_id", :inverse_of => :diplomacy_target_relations
  
  after_create :create_event
  after_create :create_copy
  
  scope :neutral, where(diplomacy_status: RELATION_TYPE_NEUTRAL)
  scope :ultimatum, where(diplomacy_status: RELATION_TYPE_ULTIMATUM)
  scope :war, where(diplomacy_status: RELATION_TYPE_WAR)
  scope :surrender, where(diplomacy_status: RELATION_TYPE_SURRENDER)
  scope :occupation, where(diplomacy_status: RELATION_TYPE_OCCUPATION)
  
  def relation_status
    GameRules::Rules.the_rules.diplomacy_relation_types[self.diplomacy_status]
  end
  
  def create_ticker_event
    #create entry for event table
    event = self.build_event(
        character_id: self.source_alliance.leader_id,   # get leader id of source alliance
        execute_at: DateTime.now.advance(:seconds => self.relation_status[:duration]),
        event_type: "diplomacy_relation",
        local_event_id: self.id,
    )
    if !self.save  # this is the final step; this makes sure, something is actually executed
      raise ArgumentError.new('could not create event for diplomacy relation')
    end
  end
    
  def self.destroy_relations_between(alliance1, alliance2)
    relations = Fundamental::DiplomacyRelation.where("source_alliance_id = ? OR target_alliance_id = ? OR source_alliance_id = ? OR target_alliance_id = ?", alliance1.id, alliance1.id, alliance2.id, alliance2.id)
    relations.destroy_all
  end
  
  def next_status
    #Fundamental::DiplomacyRelation.destroy_relations_between(self.source_alliance, self.target_alliance)
    if self.relation_status[:next_relations].present?
      Fundamental::DiplomacyRelation.create(source_alliance: self.source_alliance,
                                            target_alliance: self.target_alliance,
                                            diplomacy_status: self.relation_status[:next_relations][0],
                                            initiator: self.initiator
                                           )
    end
    self.destroy
  end
  
  def create_event
    self.create_ticker_event if !self.relation_status[:min] && self.initiator
  end
  
  def create_copy
#    copy = self.dup
#    copy.source_alliance = self.target_alliance
#    copy.target_alliance = self.source_alliance
#    copy.diplomacy_status = self.diplomacy_status
#    copy.initiator = !self.initiator
#    copy.save
  end
end
