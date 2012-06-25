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

  attr_accessor :version, :resource_types, :unit_types, :building_types, :science_types, :unit_categories, :building_categories, :queue_types, :settlement_types
  
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
      'queue_types'    => queue_types,  
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

  
# ## RESOURCE TYPES ##########################################################
  
      :resource_types => [  # ALL RESOURCE TYPES

        {               #   resource_wood
          :id          => 0, 
          :symbolic_id => :resource_wood,
          :stealable   => true,
          :rating_value=> 1,
          :name        => {
            
            :de_DE => "Holz",
  
            :en_US => "Wood",
                
          },
          :flavour     => {
            
            :de_DE => "Ein Brett in Ehren kann niemand verwehren.",
  
            :en_US => "Hard as wood.",
                
          },
          :description => {
            
            :de_DE => "<p>Holz war bereits in der Steinzeit in allen Varianten verfügbar: Nadelholz, Laubholz, Kantholz und natürlich Brettholz. Als Rohtoff spielt Holz eine wichtige Rolle bei der Konstruktion von Gebäuden und Belagerungswaffe.</p>",
  
            :en_US => "<p>Basic resource for constructing buildings and siege machines.</p>",
                
          },          
        },              #   END OF resource_wood
        {               #   resource_stone
          :id          => 1, 
          :symbolic_id => :resource_stone,
          :stealable   => true,
          :rating_value=> 1,
          :name        => {
            
            :de_DE => "Stein",
  
            :en_US => "Stone",
                
          },
          :flavour     => {
            
            :de_DE => "Grau, hart, überall zu finden.",
  
            :en_US => "Harder than wood.",
                
          },
          :description => {
            
            :de_DE => "<p>Steine -- in der STEINzeit DER Rohstoff schlechthin. Kann gesammelt, gestapelt, geschärft und geworfen werden. Mehr muss man nicht sagen.</p>",
  
            :en_US => "<p>Basic resource for constructing buildings and weapons.</p>",
                
          },          
        },              #   END OF resource_stone
        {               #   resource_fur
          :id          => 2, 
          :symbolic_id => :resource_fur,
          :stealable   => true,
          :rating_value=> 1,
          :name        => {
            
            :de_DE => "Fell",
  
            :en_US => "Fur",
                
          },
          :flavour     => {
            
            :de_DE => "In der gesamten Steinzeit wurden Kunstfelle verwendet, es kamen keine Tiere zu schaden. Natürlich!",
  
            :en_US => "Softer than wood.",
                
          },
          :description => {
            
            :de_DE => "<p>Hällt warm, hällt Wasser ab, verhängt Löcher und taugt im Notfall auch als rudimentäre Dachbedeckung.</p>",
  
            :en_US => "<p>Basic resource to be worn by warriors and also utilized in buildings..</p>",
                
          },          
        },              #   END OF resource_fur
        {               #   resource_cash
          :id          => 3, 
          :symbolic_id => :resource_cash,
          :stealable   => false,
          :rating_value=> 0,
          :name        => {
            
            :de_DE => "Kröte",
  
            :en_US => "Toad",
                
          },
          :flavour     => {
            
            :de_DE => "Jeder mag Kröten! Die Steinzeitwährung.",
  
            :en_US => "Everybody loves toads! Stoneage-Cash.",
                
          },
          :description => {
            
            :de_DE => "<p>Quasi-Wärhung in der Steinzeit. Gerne genommen in jeglichen Tauschhandeln.</p>",
  
            :en_US => "<p>Currency of the stone-age.</p>",
                
          },          
        },              #   END OF resource_cash
      ],                # END OF RESOURCE TYPES

  
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
          :effectiveness => {
            
            :infantry => 1,
  
            :cavalry => 0.3,
  
            :artillery => 0.75,
  
            :siege => 0.75,
                
          },
          :attack      => 18,
          :armor       => 2,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 10,
          :critical_hit_chance => 0.01,

          :production_time => '500',

          :costs      => {
            1 => '12',
            2 => '2',
            
          },


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
          :effectiveness => {
            
            :infantry => 0.6,
  
            :cavalry => 1,
  
            :artillery => 1,
  
            :siege => 1,
                
          },
          :attack      => 14,
          :armor       => 14,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 6,
          :critical_hit_chance => 0.01,

          :production_time => '300',

          :costs      => {
            1 => '2',
            0 => '10',
            2 => '4',
            
          },


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
          :effectiveness => {
            
            :infantry => 0.3,
  
            :cavalry => 0.75,
  
            :artillery => 1,
  
            :siege => 0.4,
                
          },
          :attack      => 16,
          :armor       => 3,
          :hitpoints   => 95,

          :overrunnable => true,

          :critical_hit_damage => 10,
          :critical_hit_chance => 0.01,

          :production_time => '300',

          :costs      => {
            1 => '2',
            0 => '10',
            2 => '4',
            
          },


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
          :effectiveness => {
            
            :infantry => 0.8,
  
            :cavalry => 1,
  
            :artillery => 0.8,
  
            :siege => 1,
                
          },
          :attack      => 20,
          :armor       => 4,
          :hitpoints   => 140,

          :overrunnable => true,

          :critical_hit_damage => 9,
          :critical_hit_chance => 0.02,

          :production_time => '300',

          :costs      => {
            1 => '2',
            0 => '10',
            2 => '4',
            
          },


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
          :effectiveness => {
            
            :infantry => 0.4,
  
            :cavalry => 0.6,
  
            :artillery => 1,
  
            :siege => 0.4,
                
          },
          :attack      => 21,
          :armor       => 15,
          :hitpoints   => 140,

          :overrunnable => true,

          :critical_hit_damage => 14,
          :critical_hit_chance => 0.02,

          :production_time => '300',

          :costs      => {
            1 => '2',
            0 => '10',
            2 => '4',
            
          },


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
          :effectiveness => {
            
            :infantry => 1,
  
            :cavalry => 0.4,
  
            :artillery => 0.7,
  
            :siege => 0.4,
                
          },
          :attack      => 19,
          :armor       => 0,
          :hitpoints   => 100,

          :overrunnable => true,

          :critical_hit_damage => 19,
          :critical_hit_chance => 0.2,

          :production_time => '300',

          :costs      => {
            1 => '2',
            0 => '10',
            2 => '4',
            
          },


        },              #   END OF Squirrel-Hunters
        {               #   Club Warrior
          :id          => 6, 
          :symbolic_id => :clubbers,
					:category    => 0,
          :db_field    => :unit_clubbers,
          :name        => {
            
            :en_US => "Club Warrior",
  
            :de_DE => "Keulenkrieger",
                
          },
          :description => {
            
            :de_DE => "<p>Alternative T1, besser gegen Inf, anfälliger.</p>",
  
            :en_US => "<p>Decription goes here.</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :infantry => 0.9,
  
            :cavalry => 0.9,
  
            :artillery => 0.7,
  
            :siege => 0.8,
                
          },
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,

          :production_time => '1200',

          :costs      => {
            1 => '40',
            0 => '20',
            2 => '12',
            
          },


        },              #   END OF Club Warrior
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
          :effectiveness => {
            
            :infantry => 0.2,
  
            :cavalry => 0.1,
  
            :artillery => 0.2,
  
            :siege => 1,
                
          },
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,

          :production_time => '300',

          :costs      => {
            1 => '2',
            0 => '10',
            2 => '4',
            
          },


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
          :effectiveness => {
            
            :infantry => 0.2,
  
            :cavalry => 0.1,
  
            :artillery => 0.2,
  
            :siege => 1,
                
          },
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,

          :production_time => '300',

          :costs      => {
            1 => '2',
            0 => '10',
            2 => '4',
            
          },


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
        {               #   Defensive Barricade 
          :id          => 2, 
          :symbolic_id => :building_category_wall,
          :name        => {
            
            :en_US => "Defensive Barricade ",
  
            :de_DE => "Verteidigungswall",
                
          },
          :description => {
            
            :de_DE => "<p>Grundlegende Verteidigungseinrichtung einer jeden Siedlung.</p>",
  
            :en_US => "<p>Fundamental defensive building of any settlement.</p>",
                
          },

        },              #   END OF Defensive Barricade 
        {               #   Large Buildings
          :id          => 3, 
          :symbolic_id => :building_category_large_building,
          :name        => {
            
            :en_US => "Large Buildings",
  
            :de_DE => "Große Gebäude",
                
          },
          :description => {
            
            :de_DE => "<p>Wichtige Gebäude, die eine große Grundfläche benötigen.</p>",
  
            :en_US => "<p>Advanced buildings that must be build on a large lot.</p>",
                
          },

        },              #   END OF Large Buildings
        {               #   Standard Buildings
          :id          => 4, 
          :symbolic_id => :building_category_small_building,
          :name        => {
            
            :en_US => "Standard Buildings",
  
            :de_DE => "Einfache Gebäude",
                
          },
          :description => {
            
            :de_DE => "<p>Grundlegende Gebäude, die überall, auf großen und kleinen Bauplätzen, gebaut werden können.</p>",
  
            :en_US => "<p>Fundamental buildings of any settlement that can be build on large as well as small lots.</p>",
                
          },

        },              #   END OF Standard Buildings
      ],                # END OF BUILDING CATEGORIES

# ## BUILDING TYPES ##########################################################
  
      :building_types => [  # ALL BUILDING TYPES

        {               #   Festungsanlagen
          :id          => 0, 
          :symbolic_id => :building_fortress_fortification,
					:category    => 0,
          :db_field    => :building_fortress_fortification,
          :name        => {
            
            :de_DE => "Festungsanlagen",
  
            :en_US => "Fortifications",
                
          },
          :description => {
            
            :de_DE => "<p>Hauptgebäude, Befestigungs- und Verteidigungsanlagen der Festung. Beschleunigt alle anderen Gebäudeausbauten und erhöht die Wehrhaftigkeit der Festung.</p>",
  
            :en_US => "<p>Main Building and Fortifications of the fortress. Speeds-up all other constructions and increases the defense abilities.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,

          :costs      => {
            1 => 'LEVEL*100',
            0 => 'LEVEL*10',
            
          },

          :production_time => '2*(LEVEL+1)+10',
          :production  => [
            
          ],

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :domain            => :settlement,
                :speedup_formula   => "POW(MAX(LEVEL-1,0),2.0)*0.10",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :level             => 1,
              },

            ],

            :unlock_garrison => {
              :level             => 1,            
            },

            :command_points => {
              :formula   => "1+(MAX(LEVEL-4,0)*1-MAX(LEVEL-5,0)*1)+(MAX(LEVEL-9,0)*1-MAX(LEVEL-10,0)*1)",
            },
    
          },

        },              #   END OF Festungsanlagen
        {               #   Truppenunterkunft
          :id          => 1, 
          :symbolic_id => :building_infantry_tower,
					:category    => 1,
          :db_field    => :building_infantry_tower,
          :name        => {
            
            :de_DE => "Truppenunterkunft",
  
            :en_US => "Vertical Barracks",
                
          },
          :description => {
            
            :de_DE => "<p>Unterkunft für Fußtruppen.</p>",
  
            :en_US => "<p>Hosts troops.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 1,

            },

          ],          

          :costs      => {
            1 => 'LEVEL*100',
            0 => 'LEVEL*10',
            
          },

          :production_time => '2*(LEVEL+1)+10',
          :production  => [
            
          ],

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 2,
                :queue_type_id_sym => :queue_infantry,
                :domain            => :settlement,
                :speedup_formula   => "POW(MAX(LEVEL-1,0),2.0)*0.10",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 2,
                :queue_type_id_sym => :queue_infantry,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Truppenunterkunft
        {               #   Ballistisches Erprobungszentrum
          :id          => 2, 
          :symbolic_id => :building_artillery_tower,
					:category    => 1,
          :db_field    => :building_artillery_tower,
          :name        => {
            
            :de_DE => "Ballistisches Erprobungszentrum",
  
            :en_US => "Ballistic R+D",
                
          },
          :description => {
            
            :de_DE => "<p>Schulungszentrum für alle Distanzkämpfer.</p>",
  
            :en_US => "<p>Trains artillery.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'science_ballistics',
              :id => 0,
              :type => '',

              :min_level => 1,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 1,

            },

          ],          

          :costs      => {
            1 => 'LEVEL*100',
            0 => 'LEVEL*10',
            
          },

          :production_time => '2*(LEVEL+1)+10',
          :production  => [
            
          ],

        },              #   END OF Ballistisches Erprobungszentrum
        {               #   Reitmeisterrei
          :id          => 3, 
          :symbolic_id => :building_cavalry_tower,
					:category    => 1,
          :db_field    => :building_cavalry_tower,
          :name        => {
            
            :de_DE => "Reitmeisterrei",
  
            :en_US => "Cavalry Command",
                
          },
          :description => {
            
            :de_DE => "<p>In der Reitmeisterrei werden alle berittenen Einheiten geschult.</p>",
  
            :en_US => "<p>Trains Cavalry Units.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'science_riding',
              :id => 0,
              :type => '',

              :min_level => 1,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 1,

            },

          ],          

          :costs      => {
            1 => 'LEVEL*100',
            0 => 'LEVEL*10',
            
          },

          :production_time => '2*(LEVEL+1)+11',
          :production  => [
            
          ],

          :abilities   => {
    
          },

        },              #   END OF Reitmeisterrei
        {               #   Tüftler
          :id          => 4, 
          :symbolic_id => :building_siege_tower,
					:category    => 1,
          :db_field    => :building_siege_tower,
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

          :requirements=> [
            
            {
              :symbolic_id => 'science_mechanics',
              :id => 0,
              :type => '',

              :min_level => 1,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 1,

            },

          ],          

          :costs      => {
            1 => 'LEVEL*100',
            0 => 'LEVEL*10',
            
          },

          :production_time => '2*(LEVEL+1)*0+10',
          :production  => [
            
          ],

          :abilities   => {
    
          },

        },              #   END OF Tüftler
        {               #   Steinbruch
          :id          => 5, 
          :symbolic_id => :building_quarry,
					:category    => 4,
          :db_field    => :building_quarry,
          :name        => {
            
            :de_DE => "Steinbruch",
  
            :en_US => "Quarry",
                
          },
          :description => {
            
            :de_DE => "<p>Durch eine komplizierte Kette von Arbeitsvorgängen (kompliziert in der Steinzeit), werden im Steinbruch Steine gewonnen. Größere Steinbrüche produzieren mehr Steine pro Stunde. Unglaublich, oder?</p>",
  
            :en_US => "<p>Advanced technology building (ok, advanced in the stone age) that somehow produces stones. Larger buildings produce more stones per hour. Unbelievable, isn't it?</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'science_simple_tools',
              :id => 0,
              :type => '',

              :min_level => 1,

            },

            {
              :symbolic_id => 'building_palace',
              :id => 10,
              :type => 'building',

              :min_level => 1,

            },

          ],          

          :costs      => {
            1 => 'LEVEL*30',
            0 => 'LEVEL*100+10',
            
          },

          :production_time => '20*(LEVEL*LEVEL)+10',
          :production  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_stone,
                :formula            => "LEVEL*5*POW(1.1, LEVEL)+1",
              },
            
          ],

          :abilities   => {
    
          },

        },              #   END OF Steinbruch
        {               #   Holzfäller
          :id          => 6, 
          :symbolic_id => :building_logger,
					:category    => 4,
          :db_field    => :building_logger,
          :name        => {
            
            :de_DE => "Holzfäller",
  
            :en_US => "Logger",
                
          },
          :description => {
            
            :de_DE => "<p>Unter Ausnutzung purer Gewalt aber auch modernster Steinwerkzeuge gelingt es dem Holzfäller mehr oder weniger große Stämme zu fällen und zu wertvollen Rohstoffen zu verarbeiten.</p>",
  
            :en_US => "<p>Cuts trees, produces logs.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'science_simple_tools',
              :id => 0,
              :type => '',

              :min_level => 1,

            },

            {
              :symbolic_id => 'building_palace',
              :id => 10,
              :type => 'building',

              :min_level => 1,

            },

          ],          

          :costs      => {
            1 => 'LEVEL*100+10',
            0 => 'LEVEL*30',
            
          },

          :production_time => '20*(LEVEL*LEVEL)+10',
          :production  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_wood,
                :formula            => "LEVEL*5*POW(1.1, LEVEL)+1",
              },
            
          ],

          :abilities   => {
    
          },

        },              #   END OF Holzfäller
        {               #   Kürschner
          :id          => 7, 
          :symbolic_id => :building_furrier,
					:category    => 4,
          :db_field    => :building_furrier,
          :name        => {
            
            :de_DE => "Kürschner",
  
            :en_US => "Furrier",
                
          },
          :description => {
            
            :de_DE => "<p>Verarbeitet Häute zu Leder und hat manchmal auch ein paar schöne Säbelzahntigerfelle für die Dame von Welt im Angebot.</p>",
  
            :en_US => "<p>Provides Leather.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'science_simple_tools',
              :id => 0,
              :type => '',

              :min_level => 1,

            },

            {
              :symbolic_id => 'building_palace',
              :id => 10,
              :type => 'building',

              :min_level => 1,

            },

          ],          

          :costs      => {
            1 => 'LEVEL*100+100',
            0 => 'LEVEL*100+100',
            
          },

          :production_time => '20*(LEVEL*LEVEL)+10',
          :production  => [
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "LEVEL*POW(1.1, LEVEL)+1",
              },
            
          ],

          :abilities   => {
    
          },

        },              #   END OF Kürschner
        {               #   Jäger und Sammler
          :id          => 8, 
          :symbolic_id => :building_gatherer,
					:category    => 4,
          :db_field    => :building_gatherer,
          :name        => {
            
            :de_DE => "Jäger und Sammler",
  
            :en_US => "Hunter-Gatherer",
                
          },
          :description => {
            
            :de_DE => "<p>Sammelt und jagt alles, was ihm for die Flinte, äh, die Steinschleuder kommt. Auf seinem Gelände können die Stammesangehörigen alles finden, was sie zur Abdeckungen des täglichen Bedarfs benötigen; er findet alles von Knochen und Steinen über Wurzeln bis hin zu Kröten (natürlich nur bei ausreichend großem Gelände).</p>",
  
            :en_US => "<p>Collects resources for the daily needs.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_palace',
              :id => 10,
              :type => 'building',

              :min_level => 1,

            },

          ],          

          :costs      => {
            1 => 'LEVEL*10+5',
            0 => 'LEVEL*10+5',
            
          },

          :production_time => '20*(LEVEL*LEVEL)+10',
          :production  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_stone,
                :formula            => "LEVEL",
              },
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_wood,
                :formula            => "LEVEL",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "LEVEL/4",
              },
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_toad,
                :formula            => "MAX(LEVEL-10,0)*1-MAX(LEVEL-11,0)*1+MAX(LEVEL-19,0)*1-MAX(LEVEL-20,0)*1",
              },
            
          ],

          :abilities   => {
    
          },

        },              #   END OF Jäger und Sammler
        {               #   Feuerstelle
          :id          => 9, 
          :symbolic_id => :building_embassy,
					:category    => 4,
          :db_field    => :building_embassy,
          :name        => {
            
            :de_DE => "Feuerstelle",
  
            :en_US => "Fire Pit",
                
          },
          :description => {
            
            :de_DE => "<p>Die Feuerstelle übernimmt in der Steinzeit die Rolle einer Botschaft.</p><p>An der Feuerstelle trifft sich allabendlich der Stamm mit seinen freiwilligen und unfreiwilligen Gästen. Hier ist der Ort, um  Entsandte von benachbarten und weit entfernten Stämmen zu bewirten, Kontakte zu pflegen und die wichtigen Dinge zu besprechen. Hier ist aber auch der Ort, um an den gutgläubigen Entsandten oder eingefangenen Gegnern ein Exempel zu statuieren oder sie kurzerhand zu verspeisen.</p>",
  
            :en_US => "<p>Embassy</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_palace',
              :id => 10,
              :type => 'building',

              :min_level => 5,

            },

          ],          

          :costs      => {
            1 => 'LEVEL*200+200',
            0 => 'LEVEL*100+100',
            
          },

          :production_time => '600*LEVEL+30',
          :production  => [
            
          ],

          :abilities   => {
    
          },

        },              #   END OF Feuerstelle
        {               #   Stammeslager
          :id          => 10, 
          :symbolic_id => :building_palace,
					:category    => 3,
          :db_field    => :building_palace,
          :name        => {
            
            :de_DE => "Stammeslager",
  
            :en_US => "Clan camp",
                
          },
          :description => {
            
            :de_DE => "<p>Hauptgebäude.</p>",
  
            :en_US => "<p>Main building.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,

          :requirements=> [
            
            {
              :symbolic_id => 'building_palace',
              :id => 10,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

          ],          

          :costs      => {
            1 => 'MAX(LEVEL-3,0)*1000+LEVEL*10',
            0 => 'MAX(LEVEL-3,0)*1000+LEVEL*10',
            
          },

          :production_time => '120*MAX(LEVEL-3,0)+10',
          :production  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_wood,
                :formula            => "10",
              },
            
          ],

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :domain            => :settlement,
                :speedup_formula   => "POW(MAX(LEVEL-1,0),2.0)*0.05",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :level             => 1,
              },

            ],

            :command_points => {
              :formula   => "2",
            },
    
          },

        },              #   END OF Stammeslager
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
              
              :building  => 0,
              
              :level  => 1,
              
              :options   => [
              0,
              
              ],
            },
            1 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              1,
              
              ],
            },
            2 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              1,
              
              ],
            },
            
          },



        },              #   END OF Festung
        {               #   Heimatstadt
          :id          => 2, 
          :symbolic_id => :settlement_home_base,
          :name        => {
            
            :de_DE => "Heimatstadt",
  
            :en_US => "Home Town",
                
          },
          :description => {
            
            :de_DE => "Die Hauptsiedlung eines Stammes.",
  
            :en_US => "English Description.",
                
          },

          :building_slots => {
            0 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              2,
              
              ],
            },
            1 => {
              :max_level => 20,
              
              :building  => 10,
              
              :level  => 1,
              
              :options   => [
              3,
              4,
              
              ],
            },
            2 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              3,
              4,
              
              ],
            },
            3 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              3,
              4,
              
              ],
            },
            4 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              3,
              4,
              
              ],
            },
            5 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            6 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            7 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            8 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            9 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            10 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            11 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            12 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            13 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            14 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            15 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            16 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            17 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            18 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            19 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            20 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            21 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            22 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            23 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            24 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            25 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            26 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            27 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            28 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            29 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            30 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            31 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            32 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            33 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            34 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            35 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            36 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            37 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            38 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            39 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            40 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            
          },



        },              #   END OF Heimatstadt
        {               #   Außenposten
          :id          => 3, 
          :symbolic_id => :settlement_outpost,
          :name        => {
            
            :de_DE => "Außenposten",
  
            :en_US => "Outpost",
                
          },
          :description => {
            
            :de_DE => "Außenlager eines Stammes.",
  
            :en_US => "English Description.",
                
          },

          :building_slots => {
            0 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              3,
              4,
              
              ],
            },
            1 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              3,
              4,
              
              ],
            },
            2 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            3 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            4 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            
          },



        },              #   END OF Außenposten
      ],                # END OF SETTLEMENT TYPES

# ## QUEUE TYPES #############################################################
  
      :queue_types => [  # ALL QUEUE TYPES

        {               #   queue_buildings
          :id          => 0, 
          :symbolic_id => :queue_buildings,
          :unlock_field=> :settlement_queue_buildings_unlock_count,
          :category_id => 0,
					:category    => :queue_category_construction,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 4,
          :name        => {
            
            :en_US => "Construction of Buildings",
  
            :de_DE => "Gebäudeproduktion",
                
          },
          :produces    => [
            0,
            1,
            3,
            4,
            
          ],
        },              #   END OF queue_buildings
        {               #   queue_fortifications
          :id          => 1, 
          :symbolic_id => :queue_fortifications,
          :unlock_field=> :settlement_queue_fortifications_unlock_count,
          :category_id => 0,
					:category    => :queue_category_construction,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 4,
          :name        => {
            
            :en_US => "Construction of Fortifications",
  
            :de_DE => "Aufbau von Verteidigungsanlagen",
                
          },
          :produces    => [
            
          ],
        },              #   END OF queue_fortifications
        {               #   queue_infantry
          :id          => 2, 
          :symbolic_id => :queue_infantry,
          :unlock_field=> :settlement_queue_infantry_unlock_count,
          :category_id => 1,
					:category    => :queue_category_training,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 4,
          :name        => {
            
            :en_US => "Training of Infantry",
  
            :de_DE => "Infanterieausbildung",
                
          },
          :produces    => [
            0,
            
          ],
        },              #   END OF queue_infantry
        {               #   queue_research
          :id          => 3, 
          :symbolic_id => :queue_research,
          :unlock_field=> :character_queue_research_unlock_count,
          :category_id => 2,
					:category    => :queue_category_research,
          :domain      => :character,
          :base_threads=> 1,
          :base_slots  => 4,
          :name        => {
            
            :en_US => "Forschung",
  
            :de_DE => "Research",
                
          },
          :produces    => [
            0,
            
          ],
        },              #   END OF queue_research
        {               #   queue_alliance_research
          :id          => 4, 
          :symbolic_id => :queue_alliance_research,
          :unlock_field=> :alliance_queue_alliance_research_unlock_count,
          :category_id => 2,
					:category    => :queue_category_research,
          :domain      => :alliance,
          :base_threads=> 1,
          :base_slots  => 1,
          :name        => {
            
            :en_US => "Allianzweite Forschung",
  
            :de_DE => "Alliance Research",
                
          },
          :produces    => [
            0,
            
          ],
        },              #   END OF queue_alliance_research
      ],                # END OF QUEUE TYPES

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts GameRules::Rules.the_rules.to_json
#GameRules.rules.unit_types.each do |value| 
#  puts value[:name][:de_DE] 
#end

