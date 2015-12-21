class Fundamental::DiplomacyRelation < ActiveRecord::Base
  RELATION_TYPE_NEUTRAL             = 0
  RELATION_TYPE_ULTIMATUM           = 1
  RELATION_TYPE_WAR                 = 2
  RELATION_TYPE_SURRENDER           = 3
  RELATION_TYPE_OCCUPATION          = 4
  RELATION_TYPE_ALLIANCE_REQUEST    = 5
  RELATION_TYPE_ALLIANCE            = 6
  RELATION_TYPE_ALLIANCE_CONCLUSION = 7
  
  has_one    :event,  :class_name => "Event::Event",    :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'diplomacy_relation'"

  belongs_to :source_alliance, :class_name => "Fundamental::Alliance", :foreign_key => "source_alliance_id", :inverse_of => :diplomacy_source_relations
  belongs_to :target_alliance, :class_name => "Fundamental::Alliance", :foreign_key => "target_alliance_id", :inverse_of => :diplomacy_target_relations
  
  after_create :create_event
  
  scope :neutral,             where(diplomacy_status: RELATION_TYPE_NEUTRAL)
  scope :ultimatum,           where(diplomacy_status: RELATION_TYPE_ULTIMATUM)
  scope :war,                 where(diplomacy_status: RELATION_TYPE_WAR)
  scope :surrender,           where(diplomacy_status: RELATION_TYPE_SURRENDER)
  scope :occupation,          where(diplomacy_status: RELATION_TYPE_OCCUPATION)
  scope :alliance_request,    where(diplomacy_status: RELATION_TYPE_ALLIANCE_REQUEST)
  scope :alliance,            where(diplomacy_status: RELATION_TYPE_ALLIANCE)
  scope :alliance_conclusion, where(diplomacy_status: RELATION_TYPE_ALLIANCE_CONCLUSION)
  
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
    return true if alliance1.nil? || alliance2.nil?
    relations = Fundamental::DiplomacyRelation.where("(source_alliance_id = ? AND target_alliance_id = ?) OR (source_alliance_id = ? AND target_alliance_id = ?)", alliance1.id, alliance2.id, alliance2.id, alliance1.id)
    relations.destroy_all
  end
  
  def next_status(manual = false)
    return if manual && !is_manual_status_change_allowed?

    Fundamental::DiplomacyRelation.destroy_relations_between(self.source_alliance, self.target_alliance)
    if self.relation_status[:next_relations].present?
      next_diplomacy_status = nil
      self.relation_status[:next_relations].each do |next_relation|
        if manual && next_relation[:manual]
          next_diplomacy_status = next_relation
          break
        elsif !manual && !next_relation[:manual]
          next_diplomacy_status = next_relation
          break
        end
      end

      if !next_diplomacy_status.nil?
        new_relation = Fundamental::DiplomacyRelation.create(source_alliance: self.source_alliance,
                                                             target_alliance: self.target_alliance,
                                                             diplomacy_status: next_diplomacy_status[:id],
                                                             initiator: self.initiator
        )

        if next_diplomacy_status[:opposite].present?
          new_relation.create_inverse_relation(next_diplomacy_status[:opposite])
        else
          new_relation.create_inverse_relation(next_diplomacy_status[:id])
        end
      end
    end
  end
  
  def is_manual_status_change_allowed?
    victim_bonus = self.relation_status[:min] && !self.initiator && self.relation_status[:decrease_duration_for_victim] && (Time.now >= (self.created_at + (self.relation_status[:victim_duration] ||0).seconds))
    min_duration = self.relation_status[:min] && (Time.now >= (self.created_at + self.relation_status[:duration].seconds))
    manual_initiator = self.relation_status[:manual_change].present? && self.relation_status[:manual_change] == 'initiator' && self.initiator
    manual_victim = self.relation_status[:manual_change].present? && self.relation_status[:manual_change] == 'victim' && !self.initiator
    manual_both = self.relation_status[:manual_change].present? && self.relation_status[:manual_change] == 'both'
    victim_bonus || min_duration || manual_initiator || manual_victim || manual_both
  end

  def create_event
    self.create_ticker_event if !self.relation_status[:min] && self.initiator
  end
  
  def create_inverse_relation(diplomacy_status)
    copy = self.dup
    copy.source_alliance = self.target_alliance
    copy.target_alliance = self.source_alliance
    copy.diplomacy_status = diplomacy_status
    copy.initiator = !self.initiator
    copy.save
  end
end
