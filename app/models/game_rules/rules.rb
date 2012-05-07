# encoding: utf-8  

require 'active_model'

# A module containing the game rules of a particular game instance using the
# Augmented Worlds Engine. The rules define all entities and their attributes 
# in the game.
#
# This particular file does hold the following set of rules:
# Game:    Wack-A-Doo
# Branch:  development (alpha)
# Version: 1.0.0
#
# ATTENTION: this file is auto-generated from rules/rules.xml . DO NOT EDIT 
# THIS FILE, as all your edits will be overwritten.
#
# This file is auto-generated. See the 'original' files (rules/rules.xml and 
# rules/rules.ruby.xsl) for the list of authors.
#
# All rights reserved. Copyright (C) 2012 5D Lab GmbH.



# Object holding all the configurable game rules. Comes with a version number
# in order to allow to check for recency of the rules. Contains several 
# hashes that have all the details regarding resources, units, buildings and
# sciences in this particular game.
class GameRules::Rules
  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  self.include_root_in_json = false

  attr_accessor :version, :resource_types, :unit_types, :building_types, :science_types, :unit_categories
  
  def attributes 
    { 
      'version'        => version,
      'unit_categories'=> unit_categories,
      'unit_types'     => unit_types,
      'resource_types' => resource_types,
      'building_types' => building_types,
      'science_types'  => science_types,  
    }
  end
  
  def initialize(attributes = {})
    if !Rails.logger.nil?
      Rails.logger.debug('RULES: running game rules initializer.')
    end
  
    attributes.each do | name, value |
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
  

  # returns the rules-singleton containing all the present rules. Should not
  # be modified by the program. Uses conditional assignment to construct the
  # rules object on first access.
  def self.the_rules
    @the_rules ||= GameRules::Rules.new(
  
        :version => { :major => 1, 
                      :minor => 0, 
                      :build => 0, 
        },

  
  
      :unit_categories => [  # ALL UNIT CATEGORIES

        {               #   Infantry
          :numeric_id  => 0, 
          :id          => :infantry,
          :db_field    => :unitcategory_infantry,
          :name        => {
            
            :en_US => "Infantry",
  
            :de_DE => "Fußtruppen",
                
          },
          :description => {
            
            :en_US => "<p>English description here.</p>",
  
            :de_DE => "<p>Infanterie ist die Basiseinheit in jeder Truppe. Sie schützt Fernkämpfer vor direkt Angriffen und kann, wenn in ausreichender Zahl vorhanden, auch Flankenangriffe abwehren.</p>",
                
          },

          :target_priorities => {
            :test_type => :no_test,

            :results => [
              
              [
                
                  :infantry,
                
                  :cavalry,
                
                  :artillery,
                
              ],
       
            ],
          },
        },              #   END OF Infantry
        {               #   cavalry
          :numeric_id  => 1, 
          :id          => :cavalry,
          :db_field    => :unitcategory_cavalry,
          :name        => {
            
            :en_US => "cavalry",
  
            :de_DE => "Reiter",
                
          },
          :description => {
            
            :en_US => "<p>English description here.</p>",
  
            :de_DE => "<p>Berittene Einheiten bewegen sich schnell auf dem Schlachtfeld, und sind als einzige in der Lage, die gegnerischen Fußtruppen zu umgehen und feindliche Fernkämpfer direkt anzugreifen (Flankenangriff).</p>",
                
          },

          :target_priorities => {
            :test_type => :line_size_test,

            :test_category => :infantry,

            :results => [
              
              [
                
                  :cavalry,
                
                  :artillery,
                
                  :infantry,
                
              ],

              [
                
                  :cavalry,
                
                  :infantry,
                
                  :artillery,
                
              ],
       
            ],
          },
        },              #   END OF cavalry
        {               #   artillery
          :numeric_id  => 2, 
          :id          => :artillery,
          :db_field    => :unitcategory_artillery,
          :name        => {
            
            :en_US => "artillery",
  
            :de_DE => "Fernkämpfer",
                
          },
          :description => {
            
            :en_US => "<p>English description here.</p>",
  
            :de_DE => "<p>Die Fernkämpfer schießen aus sicherer Distanz auf den Gegner, vorzugsweise auf Fußsoldaten. Im Nahkampf sind sie extrem anfällig.</p>",
                
          },

          :target_priorities => {
            :test_type => :no_test,

            :results => [
              
              [
                
                  :infantry,
                
                  :artillery,
                
                  :cavalry,
                
              ],
       
            ],
          },
        },              #   END OF artillery
      ],                # END OF UNIT CATEGORIES

  
      :unit_types => [  # ALL UNIT TYPES

        {               #   Stone Hurler
          :numeric_id  => 0, 
          :id          => :thrower,
					:category    => :artillery,
          :db_field    => :unit_thrower,
          :name        => {
            
            :en_US => "Stone Hurler",
  
            :de_DE => "Kieselsteinwerfer",
                
          },
          :description => {
            
            :de_DE => "<p>Große Steine, kleine Steine, ein Kieselsteinwerfer mag sie alle, solange er sie jemandem an den Kopf werfen kann. Ok, zugegeben, die kleinen mag er ein bisschen lieber. Nichtsdestotrotz kann er moderaten kritischen Schaden zufügen - denn, wie jeder weiß, das kann auch ins Auge gehen.</p>",
  
            :en_US => "<p>Small Stones, big Stones, a Stone Hurler likes them all, as long as he can throw them at people. Ok, granted, the small ones are slightly prefered... Nevertheless, he may inflict moderate critical damage by sometimes hitting an opponent's eye.'</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :attack      => 18,
          :armor       => 2,
          :hitpoints   => 90,
          :overrunnable => true,
          :critical_hit_damage => 10,
          :critical_hit_chance => 0.01,


        },              #   END OF Stone Hurler
        {               #   Skewer
          :numeric_id  => 1, 
          :id          => :skewer,
					:category    => :infantry,
          :db_field    => :unit_skewer,
          :name        => {
            
            :en_US => "Skewer",
  
            :de_DE => "Bratspießträger",
                
          },
          :description => {
            
            :de_DE => "<p>Der Umgang mit der Waffe ist schnell gelernt: Das spitze Ende muss nach vorn!</p>",
  
            :en_US => "<p>Skewer Crew training 101: stick'em with the pointy end!</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 15,
          :attack      => 14,
          :armor       => 14,
          :hitpoints   => 90,
          :overrunnable => true,
          :critical_hit_damage => 6,
          :critical_hit_chance => 0.01,


        },              #   END OF Skewer
        {               #   Ostrich Riders
          :numeric_id  => 2, 
          :id          => :light_cavalry,
					:category    => :cavalry,
          :db_field    => :unit_light_cavalry,
          :name        => {
            
            :en_US => "Ostrich Riders",
  
            :de_DE => "Straußenreiter",
                
          },
          :description => {
            
            :de_DE => "<p>Die Straußenreiter sind äußerst schnell, dafür aber nur schwach gepanzert.</p>",
  
            :en_US => "<p>Ostrich riders are very quick, but only lightly armored.</p>",
                
          },

          :velocity    => 1.5,
          :action_points => 5,
          :initiative  => 26,
          :attack      => 16,
          :armor       => 3,
          :hitpoints   => 95,
          :overrunnable => true,
          :critical_hit_damage => 10,
          :critical_hit_chance => 0.01,


        },              #   END OF Ostrich Riders
        {               #   Tree Huggers
          :numeric_id  => 3, 
          :id          => :tree_huggers,
					:category    => :infantry,
          :db_field    => :unit_tree_huggers,
          :name        => {
            
            :en_US => "Tree Huggers",
  
            :de_DE => "Baum-Brutalos",
                
          },
          :description => {
            
            :de_DE => "<p>Baum-Brutalos sind Tier2-Einheiten</p>",
  
            :en_US => "<p>What Tree-Huggers lack in brains, they make up for with sheer strength.</p>",
                
          },

          :velocity    => 0.95,
          :action_points => 4,
          :initiative  => 14,
          :attack      => 20,
          :armor       => 4,
          :hitpoints   => 140,
          :overrunnable => true,
          :critical_hit_damage => 9,
          :critical_hit_chance => 0.02,


        },              #   END OF Tree Huggers
        {               #   Sabretooth-Riders
          :numeric_id  => 4, 
          :id          => :sabre_riders,
					:category    => :cavalry,
          :db_field    => :unit_sabre_riders,
          :name        => {
            
            :en_US => "Sabretooth-Riders",
  
            :de_DE => "Säbelzahnreiter",
                
          },
          :description => {
            
            :de_DE => "<p>Viele fürchten die Reittiere mehr als die eigentlichen Reiter...</p>",
  
            :en_US => "<p>It's not so much the riders themselves that are feared...</p>",
                
          },

          :velocity    => 1.4,
          :action_points => 4,
          :initiative  => 28,
          :attack      => 21,
          :armor       => 15,
          :hitpoints   => 140,
          :overrunnable => true,
          :critical_hit_damage => 14,
          :critical_hit_chance => 0.02,


        },              #   END OF Sabretooth-Riders
        {               #   Squirrel-Hunters
          :numeric_id  => 5, 
          :id          => :squirrel_hunters,
					:category    => :artillery,
          :db_field    => :unit_squirrel_hunters,
          :name        => {
            
            :en_US => "Squirrel-Hunters",
  
            :de_DE => "Hörnchen-Jäger",
                
          },
          :description => {
            
            :de_DE => "<p>T2 Sniper-Einheit, braucht noch guten Namen.</p>",
  
            :en_US => "<p>Used to shooting at small furry animals, these guys are great at aiming.</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 7,
          :attack      => 19,
          :armor       => 0,
          :hitpoints   => 100,
          :overrunnable => true,
          :critical_hit_damage => 19,
          :critical_hit_chance => 0.2,


        },              #   END OF Squirrel-Hunters
        {               #   Squirrel-Hunters
          :numeric_id  => 6, 
          :id          => :clubbers,
					:category    => :infantry,
          :db_field    => :unit_clubbers,
          :name        => {
            
            :en_US => "Squirrel-Hunters",
  
            :de_DE => "Keulenkrieger",
                
          },
          :description => {
            
            :de_DE => "<p>Alternative T1, besser gegen Inf, anfälliger.</p>",
  
            :en_US => "<p>Decription goes here.</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,
          :overrunnable => true,
          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,


        },              #   END OF Squirrel-Hunters
      ],                # END OF UNIT TYPES

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts GameRules::Rules.the_rules.to_json
#GameRules.rules.unit_types.each do |value| 
#  puts value[:name][:de_DE] 
#end

