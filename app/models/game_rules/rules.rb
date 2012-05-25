# encoding: utf-8  

require 'active_model'

# A module containing the game rules of a particular game instance using the
# Augmented Worlds Engine. The rules define all entities and their attributes 
# in the game.
#
# This particular file does hold the following set of rules:
# Game:    Wack-A-Doo
# Branch:  development (alpha)
# Version: 0.0.1
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

  attr_accessor :version, :resource_types, :unit_types, :building_types, :science_types, :unit_categories, :building_categories, :settlement_types
  
  def attributes 
    { 
      'version'        => version,
      'unit_categories'=> unit_categories,
      'building_categories'=> building_categories,
      'unit_types'     => unit_types,
      'resource_types' => resource_types,
      'building_types' => building_types,
      'science_types'  => science_types,  
      'settlement_types'  => settlement_types,  
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
  
        :version => { :major => 0, 
                      :minor => 0, 
                      :build => 1, 
        },

  
  
      :unit_categories => [  # ALL UNIT CATEGORIES

        {               #   Infantry
          :id          => 0, 
          :symbolic_id => :infantry,
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
                0,
                1,
                2,
                3,
                
              ],
       
            ],
          },
        },              #   END OF Infantry
        {               #   cavalry
          :id          => 1, 
          :symbolic_id => :cavalry,
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

            :test_category => 0,

            :results => [
              
              [
                1,
                2,
                0,
                3,
                
              ],

              [
                1,
                0,
                2,
                3,
                
              ],
       
            ],
          },
        },              #   END OF cavalry
        {               #   Ranged Troops
          :id          => 2, 
          :symbolic_id => :artillery,
          :db_field    => :unitcategory_artillery,
          :name        => {
            
            :en_US => "Ranged Troops",
  
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
                0,
                2,
                1,
                3,
                
              ],
       
            ],
          },
        },              #   END OF Ranged Troops
        {               #   Siege Weapons
          :id          => 3, 
          :symbolic_id => :siege,
          :db_field    => :unitcategory_siege,
          :name        => {
            
            :en_US => "Siege Weapons",
  
            :de_DE => "Belagerungsgeräte",
                
          },
          :description => {
            
            :en_US => "<p>Siege Weapons support armies in battle against settlements.</p>",
  
            :de_DE => "<p>Belagerungsgerät dient der Unterstützung im Kampf gegen Siedlungen.</p>",
                
          },

          :target_priorities => {
            :test_type => :no_test,

            :results => [
              
              [
                3,
                2,
                0,
                1,
                
              ],
       
            ],
          },
        },              #   END OF Siege Weapons
      ],                # END OF UNIT CATEGORIES

  
# ## UNIT TYPES ##############################################################

      :unit_types => [  # ALL UNIT TYPES

        {               #   Stone Hurler
          :id          => 0, 
          :symbolic_id => :thrower,
					:category    => 2,
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
          :id          => 1, 
          :symbolic_id => :skewer,
					:category    => 0,
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
          :id          => 2, 
          :symbolic_id => :light_cavalry,
					:category    => 1,
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
          :id          => 3, 
          :symbolic_id => :tree_huggers,
					:category    => 0,
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
          :id          => 4, 
          :symbolic_id => :sabre_riders,
					:category    => 1,
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
          :id          => 5, 
          :symbolic_id => :squirrel_hunters,
					:category    => 2,
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
          :id          => 6, 
          :symbolic_id => :clubbers,
					:category    => 0,
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
        {               #   Catapult
          :id          => 7, 
          :symbolic_id => :catapult,
					:category    => 3,
          :db_field    => :unit_catapult,
          :name        => {
            
            :en_US => "Catapult",
  
            :de_DE => "Katapult",
                
          },
          :description => {
            
            :de_DE => "<p>Das Basismodell 'Catabilly' zum selber zusammenbauen, unschlagbar günstig.</p>",
  
            :en_US => "<p>Decription goes here.</p>",
                
          },

          :velocity    => 0.7,
          :action_points => 4,
          :initiative  => 16,
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,


        },              #   END OF Catapult
        {               #   Battering Ram
          :id          => 8, 
          :symbolic_id => :ram,
					:category    => 3,
          :db_field    => :unit_ram,
          :name        => {
            
            :en_US => "Battering Ram",
  
            :de_DE => "Rammbock",
                
          },
          :description => {
            
            :de_DE => "<p>Nur wenige wissen, dass der Name Rammbock von einem prähistorischen Tier aus der Unterfamilie der ziegenartigen (caprinae) abstammt.</p>",
  
            :en_US => "<p>It is a little known fact that the term battering ram originates from an actual and quite large pre-historic animal.</p>",
                
          },

          :velocity    => 0.9,
          :action_points => 4,
          :initiative  => 16,
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,


        },              #   END OF Battering Ram
      ],                # END OF UNIT TYPES

  
      :building_categories => [  # ALL BUILDING CATEGORIES

        {               #   Fortification
          :id          => 0, 
          :symbolic_id => :building_category_fortress_main,
          :name        => {
            
            :en_US => "Fortification",
  
            :de_DE => "Festungsanlagen",
                
          },
          :description => {
            
            :de_DE => "<p>Allgemeine Verbesserungen, die in Festungen gebaut werden können.</p>",
  
            :en_US => "<p>Improvements to be build in fortresses.</p>",
                
          },

        },              #   END OF Fortification
        {               #   Towers
          :id          => 1, 
          :symbolic_id => :building_category_fortress_tower,
          :name        => {
            
            :en_US => "Towers",
  
            :de_DE => "Türme",
                
          },
          :description => {
            
            :de_DE => "<p>In Türmen untergebrachte militärische Verbesserungen von Festungen.</p>",
  
            :en_US => "<p>Towers that extend the military abilities of fortresses.</p>",
                
          },

        },              #   END OF Towers
      ],                # END OF BUILDING CATEGORIES

# ## BUILDING TYPES ##########################################################
  
      :building_types => [  # ALL BUILDING TYPES

        {               #   Tüftler
          :id          => 0, 
          :symbolic_id => :building_inventor_tower,
					:category    => 1,
          :db_field    => :building_inventor_tower,
          :name        => {
            
            :de_DE => "Tüftler",
  
            :en_US => "Inventor",
                
          },
          :description => {
            
            :de_DE => "<p>Der Tüftler baut hammerharte Kriegsmaschinen.</p>",
  
            :en_US => "<p>Builds war machines.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

        },              #   END OF Tüftler
      ],                # END OF BUILDING TYPES

# ## SETTLEMENT TYPES ########################################################
  
      :settlement_types => [  # ALL SETTLEMENT TYPES

        {               #   Unbesiedelt
          :id          => 0, 
          :symbolic_id => :settlement_none,
          :name        => {
            
            :de_DE => "Unbesiedelt",
  
            :en_US => "Wilderness",
                
          },
          :description => {
            
            :de_DE => "Unbesiedeltes Gebiet. Spieler können hier siedeln.",
  
            :en_US => "Unclaimed location. Players can settle here.",
                
          },



        },              #   END OF Unbesiedelt
        {               #   Festung
          :id          => 1, 
          :symbolic_id => :settlement_fortress,
          :name        => {
            
            :de_DE => "Festung",
  
            :en_US => "Fortress",
                
          },
          :description => {
            
            :de_DE => "Beherrscht eine Region mit allen Einwohnern, erlaubt es Steuern zu erheben und den Gebietszugang zu reglementieren.",
  
            :en_US => "English Description.",
                
          },

          :building_slots => {
            0 => {
              :max_level => 10,
              :options   => {},
            },
            1 => {
              :max_level => 10,
              :options   => {},
            },
            2 => {
              :max_level => 10,
              :options   => {},
            },
            
          },



        },              #   END OF Festung
      ],                # END OF SETTLEMENT TYPES

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts GameRules::Rules.the_rules.to_json
#GameRules.rules.unit_types.each do |value| 
#  puts value[:name][:de_DE] 
#end

