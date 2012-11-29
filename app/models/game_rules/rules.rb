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

  attr_accessor :version, :battle, :character_creation, :building_conversion, :building_experience_formula, :resource_types, :unit_types, :building_types, :science_types, :unit_categories, :building_categories, :queue_types, :settlement_types, :construction_speedup, :training_speedup, :character_ranks, :alliance_max_members
  
  def attributes 
    { 
      'version'                     => version,
      'battle'                      => battle,
      'character_creation'          => character_creation,
      'construction_speedup'        => construction_speedup,
      'training_speedup'            => training_speedup,
      'building_conversion'         => building_conversion,
      'building_experience_formula' => building_experience_formula,
      'unit_categories'             => unit_categories,
      'building_categories'         => building_categories,
      'unit_types'                  => unit_types,
      'resource_types'              => resource_types,
      'building_types'              => building_types,
      'science_types'               => science_types,  
      'settlement_types'            => settlement_types,  
      'queue_types'                 => queue_types,  
      'character_ranks'             => character_ranks,
      'alliance_max_members'        => alliance_max_members,
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
        :battle => {
          :calculation => {
            :round_time => 30,
            :retreat_probability => 0.6,
            },
        },
        :character_creation => {
          :start_resources => {
            1 => 200,
            0 => 200,
            2 => 100,
            3 => 0,
            
          },
        },
        :building_conversion => {
          :cost_factor => 0.3,
          :time_factor => 0.3,
        },
        :building_experience_formula => '2*LEVEL',
        :alliance_max_members => 100,
  
# ## CONSTRUCTION SPEEDUP ####################################################
  
      :construction_speedup => [  # ALL CONSTRUCTION SPEEDUPS

        {               #   less than 1 hours
          :resource_id => 3, 
          :amount      => 1,
          :hours     => 1,
        },              #   END OF 1 hours

        {               #   less than 3 hours
          :resource_id => 3, 
          :amount      => 2,
          :hours     => 3,
        },              #   END OF 3 hours

        {               #   less than 7 hours
          :resource_id => 3, 
          :amount      => 4,
          :hours     => 7,
        },              #   END OF 7 hours

        {               #   less than 12 hours
          :resource_id => 3, 
          :amount      => 6,
          :hours     => 12,
        },              #   END OF 12 hours

        {               #   less than 18 hours
          :resource_id => 3, 
          :amount      => 8,
          :hours     => 18,
        },              #   END OF 18 hours

        {               #   less than 30 hours
          :resource_id => 3, 
          :amount      => 12,
          :hours     => 30,
        },              #   END OF 30 hours

        {               #   less than 9999 hours
          :resource_id => 3, 
          :amount      => 20,
          :hours     => 9999,
        },              #   END OF 9999 hours

      ],                # END OF CONSTRUCTION SPEEDUP

# ## TRAINING SPEEDUP ##########################################################
  
      :training_speedup => [  # ALL TRAINING SPEEDUPS

        {               #   less than 3 hours
          :resource_id => 3, 
          :amount      => 1,
          :hours     => 3,
        },              #   END OF 3 hours

        {               #   less than 6 hours
          :resource_id => 3, 
          :amount      => 2,
          :hours     => 6,
        },              #   END OF 6 hours

        {               #   less than 11 hours
          :resource_id => 3, 
          :amount      => 3,
          :hours     => 11,
        },              #   END OF 11 hours

        {               #   less than 17 hours
          :resource_id => 3, 
          :amount      => 4,
          :hours     => 17,
        },              #   END OF 17 hours

        {               #   less than 36 hours
          :resource_id => 3, 
          :amount      => 6,
          :hours     => 36,
        },              #   END OF 36 hours

        {               #   less than 56 hours
          :resource_id => 3, 
          :amount      => 8,
          :hours     => 56,
        },              #   END OF 56 hours

        {               #   less than 96 hours
          :resource_id => 3, 
          :amount      => 12,
          :hours     => 96,
        },              #   END OF 96 hours

        {               #   less than 9999 hours
          :resource_id => 3, 
          :amount      => 20,
          :hours     => 9999,
        },              #   END OF 9999 hours

      ],                # END OF TRAINING SPEEDUP

# ## RESOURCE TYPES ##########################################################
  
      :resource_types => [  # ALL RESOURCE TYPES

        {               #   resource_stone
          :id          => 0, 
          :symbolic_id => :resource_stone,
          :stealable   => true,
          :taxable     => true,
          :tradable    => true,
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
        {               #   resource_wood
          :id          => 1, 
          :symbolic_id => :resource_wood,
          :stealable   => true,
          :taxable     => true,
          :tradable    => true,
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
            
            :de_DE => "<p>Holz war bereits in der Steinzeit in allen Varianten verfügbar: Nadelholz, Laubholz, Kantholz und natürlich Brettholz. Als Rohstoff spielt Holz eine wichtige Rolle bei der Konstruktion von Gebäuden und Belagerungswaffen.</p>",
  
            :en_US => "<p>Basic resource for constructing buildings and siege machines.</p>",
                
          },          
        },              #   END OF resource_wood
        {               #   resource_fur
          :id          => 2, 
          :symbolic_id => :resource_fur,
          :stealable   => true,
          :taxable     => true,
          :tradable    => true,
          :rating_value=> 2.0,
          :name        => {
            
            :de_DE => "Fell",
  
            :en_US => "Fur",
                
          },
          :flavour     => {
            
            :de_DE => "In der gesamten Steinzeit wurden Kunstfelle verwendet, es kamen keine Tiere zu schaden. Natürlich!",
  
            :en_US => "Softer than wood.",
                
          },
          :description => {
            
            :de_DE => "<p>Hält warm, hält Wasser ab, verhängt Löcher und taugt im Notfall auch als rudimentäre Dachbedeckung.</p>",
  
            :en_US => "<p>Basic resource to be worn by warriors and also utilized in buildings..</p>",
                
          },          
        },              #   END OF resource_fur
        {               #   resource_cash
          :id          => 3, 
          :symbolic_id => :resource_cash,
          :stealable   => false,
          :taxable     => false,
          :tradable    => false,
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
            
            :de_DE => "<p>Quasi-Währung in der Steinzeit. Gerne genommen bei jeglichem Tauschhandel.</p>",
  
            :en_US => "<p>Currency of the stone-age.</p>",
                
          },          
        },              #   END OF resource_cash
      ],                # END OF RESOURCE TYPES

  
      :unit_categories => [  # ALL UNIT CATEGORIES

        {               #   Infantry
          :id          => 0, 
          :symbolic_id => :unitcategory_infantry,
          :db_field    => :unitcategory_infantry,
          :name        => {
            
            :en_US => "Infantry",
  
            :de_DE => "Fußtruppen",
                
          },
          :description => {
            
            :en_US => "<p>English description here.</p>",
  
            :de_DE => "<p>Infanterie ist die Basiseinheit in jeder Truppe. Sie schützt Fernkämpfer vor direkten Angriffen und kann, wenn in ausreichender Zahl vorhanden, auch Flankenangriffe abwehren.</p>",
                
          },

          :target_priorities => {
            :test_type => :no_test,

            :results => [
              
              [
                0,
                1,
                2,
                3,
                4,
                
              ],
       
            ],
          },
        },              #   END OF Infantry
        {               #   cavalry
          :id          => 1, 
          :symbolic_id => :unitcategory_cavalry,
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
                4,
                
              ],

              [
                1,
                0,
                2,
                3,
                4,
                
              ],
       
            ],
          },
        },              #   END OF cavalry
        {               #   Ranged Troops
          :id          => 2, 
          :symbolic_id => :unitcategory_artillery,
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
                4,
                
              ],
       
            ],
          },
        },              #   END OF Ranged Troops
        {               #   Siege Weapons
          :id          => 3, 
          :symbolic_id => :unitcategory_siege,
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
                4,
                
              ],
       
            ],
          },
        },              #   END OF Siege Weapons
        {               #   Special Units
          :id          => 4, 
          :symbolic_id => :unitcategory_special,
          :db_field    => :unitcategory_special,
          :name        => {
            
            :en_US => "Special Units",
  
            :de_DE => "Spezialeinheiten",
                
          },
          :description => {
            
            :en_US => "<p>English description here.</p>",
  
            :de_DE => "<p>Spezialeinheiten werden zum Beispiel für die Siedlungsgründung benötigt.</p>",
                
          },

          :target_priorities => {
            :test_type => :no_test,

            :results => [
              
              [
                0,
                1,
                2,
                3,
                4,
                
              ],
       
            ],
          },
        },              #   END OF Special Units
      ],                # END OF UNIT CATEGORIES

  
# ## UNIT TYPES ##############################################################

      :unit_types => [  # ALL UNIT TYPES

        {               #   Club Warrior
          :id          => 0, 
          :symbolic_id => :clubbers,
					:category    => 0,
          :db_field    => :unit_clubbers,
          :name        => {
            
            :en_US => "Club Warrior",
  
            :de_DE => "Keulenkrieger",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Eine Keule in der Hand und immer an vorderster Front. Keulenkrieger brauchen nicht viel für ein glückliches Leben. Zudem ist dieses meist sehr kurz.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Keulenkrieger sind der Grundbestandteil jeder Armee. Sie stehen an der Front und beschützen die Fernkämpfer vor der Kavallerie. Keulenkrieger sind zähe Burschen und nur schwer klein zu kriegen, allerdings finden sie nur zu oft den Tod durch feindliche Fernkämpfer.</p>",
  
            :en_US => "<p>Actually armed with a club, the mace-men are in the front rank of all armies.</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 0.75,
  
            :unitcategory_cavalry => 1.5,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 6,
          :armor       => 5,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.01,

          :production_time => '600',

          :costs      => {
            0 => '25',
            1 => '30',
            2 => '40',
            
          },


        },              #   END OF Club Warrior
        {               #   Thick-skinned Clubber
          :id          => 1, 
          :symbolic_id => :clubbers_2,
					:category    => 0,
          :db_field    => :unit_clubbers_2,
          :name        => {
            
            :en_US => "Thick-skinned Clubber",
  
            :de_DE => "Dickhäutiger Keulenkrieger",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Erfahrene Keulenkrieger erkennt man an ihrer dicken Haut und ihrer großen Keule und natürlich an ihren Ausrufen. „Ihr zwei? Holt euch noch drei dazu, damit es ein halbwegs fairer Kampf wird!“</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die dicke Haut schützt sie zwar vor Keulenschlägen, aber die spitzen Steine der Fernkämpfer hält sie nicht ab. Dafür tut es weniger weh, wenn man von einem Strauß überrannt wird und die Zeitspanne bis zur Bewusstlosigkeit muss nicht in Schmerzen durchstanden werden.</p>",
  
            :en_US => "<p>Actually armed with a club, the mace-men are in the front rank of all armies.</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 0.75,
  
            :unitcategory_cavalry => 1.5,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 6,
          :armor       => 6,
          :hitpoints   => 100,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.01,

          :production_time => '800',

          :costs      => {
            0 => '35',
            1 => '45',
            2 => '60',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_infantry_tower',
              :id => 1,
              :type => 'building',

              :min_level => 7,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 6,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_barracks',
              :id => 8,
              :type => 'building',

              :min_level => 10,

            },

            ],

          ],          


        },              #   END OF Thick-skinned Clubber
        {               #   Drunk Clubber
          :id          => 2, 
          :symbolic_id => :clubbers_3,
					:category    => 0,
          :db_field    => :unit_clubbers_3,
          :name        => {
            
            :en_US => "Drunk Clubber",
  
            :de_DE => "Betrunkener Keulenkrieger",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Sehr wenige Keulenkrieger überleben ihre ersten Schlachten, fast keiner überlebt einen Krieg. Durch ausreichend Bier erhöht sich die Kampfkraft und verringert sich das Schmerzempfinden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Manche Keulenkrieger tauchen sogar mit ihrem Bierfaß auf dem Schlachtfeld auf. Nichts geht über einen guten Schluck vor, nach und während der Schlacht. Leicht wankend gibt der betrunkene Keulenkrieger auch ein schwierigeres Ziel für die Fernkämpfer ab. Nur leider zielen diese sowieso nicht, so dass sie weiterhin sehr tödlich für die Keulenkrieger sind.</p>",
  
            :en_US => "<p>Actually armed with a club, the mace-men are in the front rank of all armies.</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 0.75,
  
            :unitcategory_cavalry => 1.5,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 6,
          :armor       => 7,
          :hitpoints   => 110,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.01,

          :production_time => '1000',

          :costs      => {
            0 => '70',
            1 => '90',
            2 => '120',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_infantry_tower',
              :id => 1,
              :type => 'building',

              :min_level => 15,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 14,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_barracks',
              :id => 8,
              :type => 'building',

              :min_level => 15,

            },

            ],

          ],          


        },              #   END OF Drunk Clubber
        {               #   Tree Huggers
          :id          => 3, 
          :symbolic_id => :tree_huggers,
					:category    => 0,
          :db_field    => :unit_tree_huggers,
          :name        => {
            
            :en_US => "Tree Huggers",
  
            :de_DE => "Baum-Brutalo",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Wozu einen Ast vom Baum schlagen und zu einer Keule verarbeiten, wenn man einfach den ganzen Baum schwingen kann?</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Groß, stark, sauber rasierter Bart. Ein Baum-Brutalo legt sehr großen Wert auf sein Äußeres.</p><p>In der Schlacht bietet der Baum-Brutalo ein seltsames Schauspiel. Umhüllt von den rauschenden Blättern seines Kampfbaumes wirbelt der Baum-Brutalo durch die gegnerischen Reihen wie ein Säbelzahntiger, der sich den Schwanz geklemmt hat. Nicht den flauschigen, den anderen...</p>",
  
            :en_US => "<p>What Tree-Huggers lack in brains, they make up for with sheer strength.</p><p>Telling by an unverified legend, those guys are brought up in a tree-nursery.</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 0.75,
  
            :unitcategory_cavalry => 1.5,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 7,
          :armor       => 9,
          :hitpoints   => 135,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.02,

          :production_time => '1200',

          :costs      => {
            0 => '140',
            1 => '180',
            2 => '240',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_barracks',
              :id => 8,
              :type => 'building',

              :min_level => 20,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 1,

            },

            ],

          ],          


        },              #   END OF Tree Huggers
        {               #   Pebble Thrower
          :id          => 4, 
          :symbolic_id => :thrower,
					:category    => 2,
          :db_field    => :unit_thrower,
          :name        => {
            
            :en_US => "Pebble Thrower",
  
            :de_DE => "Kieselsteinwerfer",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Diese Fernkämpfer könnten zwar eine Zielscheibe nicht aus zehn Meter Entfernung treffen, aber zum Glück sind Schlachtreihen meist viel größer als Zielscheiben.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Große Steine, kleine Steine, ein Kieselsteinwerfer mag sie alle, solange er sie jemandem an den Kopf werfen kann. Ok, zugegeben, die kleinen mag er ein bisschen lieber. Zwar zielt ein Kieselsteinwerfer nicht, aber sowas kann schnell ins Auge gehen.</p><p>Kieselsteinwerfer fürchten nicht den Tod an sich, nur die Straußenreiter, die diesen bringen.</p>",
  
            :en_US => "<p>Small Stones, big Stones, a Peeble Thrower likes them all, as long as he can throw them at people. Ok, granted, the small ones are slightly prefered... Nevertheless, he may inflict moderate critical damage by sometimes hitting an opponent's eye.'</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :effectiveness => {
            
            :unitcategory_infantry => 1.5,
  
            :unitcategory_cavalry => 0.75,
  
            :unitcategory_artillery => 0.75,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 8,
          :armor       => 3,
          :hitpoints   => 50,

          :overrunnable => true,

          :critical_hit_damage => 5,
          :critical_hit_chance => 0.05,

          :production_time => '750',

          :costs      => {
            0 => '35',
            1 => '35',
            2 => '60',
            
          },


        },              #   END OF Pebble Thrower
        {               #   Pebble Thrower2
          :id          => 5, 
          :symbolic_id => :thrower_2,
					:category    => 2,
          :db_field    => :unit_thrower_2,
          :name        => {
            
            :en_US => "Pebble Thrower2",
  
            :de_DE => " Zielsicherer Kieselsteinwerfer",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Einen Stein auf fünfzig Meter Entfernung genau auf ein Ziel zu werfen, ist eine beeindruckende Leistung. Dummerweise stehen die Gegner meistens weiter weg.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein sicherer Wurf führt zu besseren Treffern. Nicht dass der Unterschied bemerkbar wäre, meist sind eh genug gegnerische Nahkämpfer da, aber es führt doch zu ein oder zwei kritischen Treffern.</p><p>Ein bewegliches Ziel wie einen Straußenreiter zu treffen, ist eine große Leistung und der Unterschied zwischen Leben und Tod für einen Fernkämpfer.</p>",
  
            :en_US => "<p>Small Stones, big Stones, a Peeble Thrower likes them all, as long as he can throw them at people. Ok, granted, the small ones are slightly prefered... Nevertheless, he may inflict moderate critical damage by sometimes hitting an opponent's eye.'</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :effectiveness => {
            
            :unitcategory_infantry => 1.5,
  
            :unitcategory_cavalry => 0.75,
  
            :unitcategory_artillery => 0.75,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 9,
          :armor       => 3,
          :hitpoints   => 50,

          :overrunnable => true,

          :critical_hit_damage => 6,
          :critical_hit_chance => 0.05,

          :production_time => '900',

          :costs      => {
            0 => '45',
            1 => '45',
            2 => '75',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_artillery_tower',
              :id => 2,
              :type => 'building',

              :min_level => 7,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 6,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_firing_range',
              :id => 13,
              :type => 'building',

              :min_level => 10,

            },

            ],

          ],          


        },              #   END OF Pebble Thrower2
        {               #   Pebble Thrower3
          :id          => 6, 
          :symbolic_id => :thrower_3,
					:category    => 2,
          :db_field    => :unit_thrower_3,
          :name        => {
            
            :en_US => "Pebble Thrower3",
  
            :de_DE => "Steinschleuderer",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Zielen ist was für Anfänger. Das Motto der Steinschleuderer: 'Je weiterer der Stein geworfen wird, desto besser!' Stimmt sogar manchmal.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Mit der Schleuder können größere Steine weiter geworfen werden. So trifft der Steinschleuderer oft die unvorbereiteten Kämpfer in der zweiten Reihe wodurch insgesamt deutlich mehr Opfer zu beklagen bzw. zu bejubeln sind. Je nach der Seite des Kampfes auf der man gerade steht. Was durchaus nicht immer eindeutig ist.</p>",
  
            :en_US => "<p>Small Stones, big Stones, a Peeble Thrower likes them all, as long as he can throw them at people. Ok, granted, the small ones are slightly prefered... Nevertheless, he may inflict moderate critical damage by sometimes hitting an opponent's eye.'</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :effectiveness => {
            
            :unitcategory_infantry => 1.5,
  
            :unitcategory_cavalry => 0.75,
  
            :unitcategory_artillery => 0.75,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 10,
          :armor       => 3,
          :hitpoints   => 50,

          :overrunnable => true,

          :critical_hit_damage => 7,
          :critical_hit_chance => 0.05,

          :production_time => '1050',

          :costs      => {
            0 => '90',
            1 => '90',
            2 => '140',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_artillery_tower',
              :id => 2,
              :type => 'building',

              :min_level => 15,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 14,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_firing_range',
              :id => 13,
              :type => 'building',

              :min_level => 15,

            },

            ],

          ],          


        },              #   END OF Pebble Thrower3
        {               #   Pebble Thrower4
          :id          => 7, 
          :symbolic_id => :thrower_4,
					:category    => 2,
          :db_field    => :unit_thrower_4,
          :name        => {
            
            :en_US => "Pebble Thrower4",
  
            :de_DE => " Speerschleuderer ",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Wieso jemand einen Stock an einen Stein gebunden hat, ist unverständlich, denn Steine sind doch schon hervorragende Wurfgeschosse. Aber der Effekt ist großartig, größere Reichweite, zielgenauer und einfacher einzusammeln. Was will man mehr?</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein Speer ist auch im Nahkampf, vor allem gegen Reiter, effektiv. Dumm nur, wenn man schon alle Speere weggeworfen hat, bevor ein Reiter angreift. Im Leitfaden für Speerwerfer steht, dass man immer einen Speer weniger werfen sollte, als man hat. Leider kann kein Speerwerfer zählen, geschweige denn lesen.</p>",
  
            :en_US => "<p>Small Stones, big Stones, a Peeble Thrower likes them all, as long as he can throw them at people. Ok, granted, the small ones are slightly prefered... Nevertheless, he may inflict moderate critical damage by sometimes hitting an opponent's eye.'</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :effectiveness => {
            
            :unitcategory_infantry => 1.5,
  
            :unitcategory_cavalry => 0.75,
  
            :unitcategory_artillery => 0.75,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 12,
          :armor       => 3,
          :hitpoints   => 50,

          :overrunnable => true,

          :critical_hit_damage => 8,
          :critical_hit_chance => 0.1,

          :production_time => '1300',

          :costs      => {
            0 => '180',
            1 => '180',
            2 => '280',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_firing_range',
              :id => 13,
              :type => 'building',

              :min_level => 20,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 1,

            },

            ],

          ],          


        },              #   END OF Pebble Thrower4
        {               #   Ostrich Riders
          :id          => 8, 
          :symbolic_id => :light_cavalry,
					:category    => 1,
          :db_field    => :unit_light_cavalry,
          :name        => {
            
            :en_US => "Ostrich Riders",
  
            :de_DE => "Zweihändiger Straußenreiter",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Die zweihändigen Straußenreiter legen ihre ganze Konzentration auf das Führen ihres Reittieres. Selber unbewaffnet stellen sie neben den Schnäbeln und Klauen der Strauße wirklich keine zusätzliche Gefahr dar.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Strauße sind nicht nur lecker, sondern auch gute und schnelle Reittiere. Straußenreiter sind die Furcht jedes Fernkämpfers. Schnell genug, um an der Infanterie vorbeizukommen, bleibt ihren Gegnern nur zu hoffen, dass die Sträuße den Kopf in den Sand stecken oder der Reiter von seinem Strauß fällt, auch wenn dies meist wenig Unterschied macht.</p>",
  
            :en_US => "<p>Ostrichs are not only delicious but also excellent and fast animals to be used in combats. Ostrich riders are very quick, but only lightly armored.</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 26,
          :effectiveness => {
            
            :unitcategory_infantry => 0.75,
  
            :unitcategory_cavalry => 1,
  
            :unitcategory_artillery => 1.5,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 6,
          :armor       => 5,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.02,

          :production_time => '600',

          :costs      => {
            0 => '30',
            1 => '25',
            2 => '40',
            
          },


        },              #   END OF Ostrich Riders
        {               #   Ostrich Riders2
          :id          => 9, 
          :symbolic_id => :light_cavalry_2,
					:category    => 1,
          :db_field    => :unit_light_cavalry_2,
          :name        => {
            
            :en_US => "Ostrich Riders2",
  
            :de_DE => "Einhändiger Straußenreiter",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Mit ausreichend Erfahrung braucht der Reiter nur noch eine Hand zum Festhalten und hat so die andere Hand für sinnvollere Tätigkeiten frei. Zum Beispiel um den Mädels zuzuwinken oder seinen Feinden den Schädel einzuhauen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Eine handliche Keule in der freien Hand sind einhändige Straußenkrieger der Todfeind aller Fernkämpfer.</p><p>Im Kampf gegen Keulenkrieger ziehen sie allerdings den Kürzeren, da sie nur eine kleine, nicht so schwere Keule bei sich führen.</p>",
  
            :en_US => "<p>Ostrichs are not only delicious but also excellent and fast animals to be used in combats. Ostrich riders are very quick, but only lightly armored.</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 26,
          :effectiveness => {
            
            :unitcategory_infantry => 0.75,
  
            :unitcategory_cavalry => 1,
  
            :unitcategory_artillery => 1.5,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 7,
          :armor       => 5,
          :hitpoints   => 100,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.02,

          :production_time => '800',

          :costs      => {
            0 => '40',
            1 => '35',
            2 => '50',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_cavalry_tower',
              :id => 3,
              :type => 'building',

              :min_level => 7,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 6,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_stud',
              :id => 14,
              :type => 'building',

              :min_level => 10,

            },

            ],

          ],          


        },              #   END OF Ostrich Riders2
        {               #   Ostrich Riders3
          :id          => 10, 
          :symbolic_id => :light_cavalry_3,
					:category    => 1,
          :db_field    => :unit_light_cavalry_3,
          :name        => {
            
            :en_US => "Ostrich Riders3",
  
            :de_DE => " Freihändiger Straußenreiter ",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Besonders talentierte Reiter halten in einer Hand eine Keule und werfen mit der anderen Hand kleine Steine. Sieht beeindruckend aus, aber die meisten Gegner metzelt weiterhin der Strauß nieder.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Auf blitzschnelle Angriffe spezialisiert, bleiben diese Reiter nie lange auf einem Fleck. Freihändig können die Reiter auch auf ihren Reittiere manövrieren und gezielt kleine Steine auf ungeschützte Fernkämpfer werfen.</p><p>Gegnerische Reittiere gelten als Spielverderber. Sie blockieren den Weg zu den leichten Zielen, sprichwörtlich auch Fleischtöpfe genannt.</p>",
  
            :en_US => "<p>Ostrichs are not only delicious but also excellent and fast animals to be used in combats. Ostrich riders are very quick, but only lightly armored.</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 26,
          :effectiveness => {
            
            :unitcategory_infantry => 0.75,
  
            :unitcategory_cavalry => 1,
  
            :unitcategory_artillery => 1.5,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 8,
          :armor       => 5,
          :hitpoints   => 110,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.02,

          :production_time => '1000',

          :costs      => {
            0 => '80',
            1 => '70',
            2 => '100',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_cavalry_tower',
              :id => 3,
              :type => 'building',

              :min_level => 15,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 14,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_stud',
              :id => 14,
              :type => 'building',

              :min_level => 15,

            },

            ],

          ],          


        },              #   END OF Ostrich Riders3
        {               #   Ostrich Riders4
          :id          => 11, 
          :symbolic_id => :light_cavalry_4,
					:category    => 1,
          :db_field    => :unit_light_cavalry_4,
          :name        => {
            
            :en_US => "Ostrich Riders4",
  
            :de_DE => "Dinoreiter",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Der Traum eines jeden neuen Reiters. Einen Dino reiten. Wenn man es endlich geschafft hat wünscht man sich, doch lieber Fernkämpfer geworden zu sein. Ein Dino stinkt! Und die Dinowäsche nach einer Schlacht kann auch mal Tage dauern.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Als Reiter eines Dinos hat man genau zwei Aufgaben. Erstens nicht abgeworfen zu werden und zweitens den Dino immer wieder auf das Schlachtfeld zurückzulenken, wenn er erstmal durch die Schlachtreihen durchgebrochen ist. Mit Füßen, Schwanz und Zähnen werden die hilflosen Gegner niedergemäht.</p><p>Kein Wunder, gibt es zu Hause doch nichts zu fressen.</p>",
  
            :en_US => "<p>Ostrichs are not only delicious but also excellent and fast animals to be used in combats. Ostrich riders are very quick, but only lightly armored.</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 26,
          :effectiveness => {
            
            :unitcategory_infantry => 0.75,
  
            :unitcategory_cavalry => 1,
  
            :unitcategory_artillery => 1.5,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 10,
          :armor       => 6,
          :hitpoints   => 125,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.02,

          :production_time => '1200',

          :costs      => {
            0 => '160',
            1 => '140',
            2 => '200',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_stud',
              :id => 14,
              :type => 'building',

              :min_level => 20,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 1,

            },

            ],

          ],          


        },              #   END OF Ostrich Riders4
        {               #   Neandertal
          :id          => 12, 
          :symbolic_id => :neanderthal,
					:category    => 0,
          :db_field    => :unit_neanderthal,
          :name        => {
            
            :en_US => "Neandertal",
  
            :de_DE => "Neandertaler",
                
          },
          :flavour     => {
            
            :en_US => "<p>Don't talk, fight.</p>",
  
            :de_DE => "<p>Neandertaler reden nicht, sie handeln äh, schlagen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Neandertaler sind ein wilder Stamm prähistorischer Menschen.</p><p>Sie sind zwar ziemlich beeindruckende Kämpfer, haben aber keine Ahnung von Taktik. Wenn Schreien und Zuschlagen nicht mehr ausreichen, ist es meist schon zu spät für den Neandertaler.</p>",
  
            :en_US => "<p>Fierce Fighters.</p>",
                
          },

          :trainable   => false,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 0.75,
  
            :unitcategory_cavalry => 1.5,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 5,
          :armor       => 3,
          :hitpoints   => 80,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.01,

          :production_time => '1200',

          :costs      => {
            0 => '40',
            1 => '20',
            2 => '12',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_stud',
              :id => 14,
              :type => 'building',

              :min_level => 100,

            },

            ],

          ],          


        },              #   END OF Neandertal
        {               #   Little Chief
          :id          => 13, 
          :symbolic_id => :little_chief,
					:category    => 4,
          :db_field    => :unit_little_chief,
          :name        => {
            
            :en_US => "Little Chief",
  
            :de_DE => "Kleiner Häuptling",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Ein Kleiner Häuptling darf im Namen des richtigen Häuptlings eine Lagerstätte gründen. Tatsächlich ist das nur die einfachste Möglichkeit ihn aus der Siedlung zu bekommen. Eine Neugründung wäre ein Bonus.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein Kleiner Häuptling ist ungefähr so beliebt wie die Begegnung mit einem hungrigen Dinosaurier. Als integranter, karrieresüchtiger, aalglatter Möchtegern ist der Kleine Häuptling das Rollenvorbild für ganze Generationen an Wichtigtuern. Zum Glück kann der Kleine Häuptling unter dem Vorwand der Gründung einer Lagerstätte aus der Siedlung verbannt werden.</p>",
  
            :en_US => "<p>Little Chiefs are in charge of expansions.</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 10,
          :effectiveness => {
            
            :unitcategory_infantry => 0.1,
  
            :unitcategory_cavalry => 0.1,
  
            :unitcategory_artillery => 0.1,
  
            :unitcategory_siege => 0.1,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 1,
          :armor       => 1,
          :hitpoints   => 100,

          :overrunnable => true,

          :critical_hit_damage => 0,
          :critical_hit_chance => 0.01,

          :production_time => '28800',

          :costs      => {
            0 => '5000',
            1 => '5000',
            2 => '2000',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_campfire',
              :id => 9,
              :type => 'building',

              :min_level => 10,

            },

            ],

          ],          

          :can_create => [
3,

          ],


        },              #   END OF Little Chief
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
        {               #   Advanced Fortress Buildings
          :id          => 2, 
          :symbolic_id => :building_category_fortress_special,
          :name        => {
            
            :en_US => "Advanced Fortress Buildings",
  
            :de_DE => "Spezielle Festungsgebäude",
                
          },
          :description => {
            
            :de_DE => "<p>Spezialgebäude von Festungen.</p>",
  
            :en_US => "<p>Towers that extend the military abilities of fortresses.</p>",
                
          },

        },              #   END OF Advanced Fortress Buildings
        {               #   Defensive Barricade 
          :id          => 3, 
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
          :id          => 4, 
          :symbolic_id => :building_category_large_building,
          :name        => {
            
            :en_US => "Large Buildings",
  
            :de_DE => "Große Gebäude",
                
          },
          :description => {
            
            :de_DE => "<p>Wichtige Gebäude, die eine große Grundfläche benötigen.</p>",
  
            :en_US => "<p>Advanced buildings that must be built on a large building slot.</p>",
                
          },

        },              #   END OF Large Buildings
        {               #   Standard Buildings
          :id          => 5, 
          :symbolic_id => :building_category_small_building,
          :name        => {
            
            :en_US => "Standard Buildings",
  
            :de_DE => "Einfache Gebäude",
                
          },
          :description => {
            
            :de_DE => "<p>Grundlegende Gebäude, die überall, auf großen und kleinen Bauplätzen, gebaut werden können.</p>",
  
            :en_US => "<p>Fundamental buildings of any settlement that can be built on large as well as small building slots.</p>",
                
          },

        },              #   END OF Standard Buildings
        {               #   Special Buildings
          :id          => 6, 
          :symbolic_id => :building_category_special_building,
          :name        => {
            
            :en_US => "Special Buildings",
  
            :de_DE => "Spezialgebäude",
                
          },
          :description => {
            
            :de_DE => "<p>Spezielle Gebäude die nur auf kleinen Bauplätzen gebaut werden können.</p>",
  
            :en_US => "<p>Special buildings that can only be built on small building slots.</p>",
                
          },

        },              #   END OF Special Buildings
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
          :flavour     => {
            
            :en_US => "<p>The fortification is controlling the region. Therefore armed forces are deployed to collect empathically the taxes and in case of attacks to protect the fortress. Prepare for battle!</p>",
  
            :de_DE => "<p>Die Festung beherrscht die Region. Dafür werden Truppen aufgestellt, die die Steuern der Siedlungen eintreiben und die Festung vor Angriffen beschützen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein paar aufgetürmte Steinbrocken, zusammengebundene Baumstämme, ein provisorisches Tor. Fertig ist die Festung. Die Festungsanlagen bestehen aus einen Hauptgebäude, einem kleinen Versammlungsplatz und Mauern zur Verteidigung.</p><p>In der Festung werden Krieger ausgebildet, Steuern eingetrieben und sich hinter Verteidigungsanlagen verschanzt.</p>",
  
            :en_US => "<p>Some debris, tied tree trunks, a provisional gate, small parade-ground, main building and some walls; rudimentary stronghold finished. Improving the fortification results in a higher maximum size of the garrison, speeding-up all other construction sites and increases the defensive abilities.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(99*POW(2.71828,0.11*LEVEL))",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :experience_factor => 6,

          :costs      => {
            0 => '(MIN(LEVEL+1,3)-MIN(LEVEL,3))*2000+(MIN(LEVEL,3)-MIN(LEVEL,2))*FLOOR((POW(MAX(LEVEL-2,1),1.6)*4000)+0.5)',
            1 => '(MIN(LEVEL+1,3)-MIN(LEVEL,3))*2000+(MIN(LEVEL,3)-MIN(LEVEL,2))*FLOOR((POW(MAX(LEVEL-2,1),1.6)*4000)+0.5)',
            2 => '(MIN(LEVEL+1,3)-MIN(LEVEL,3))*100+(MIN(LEVEL,3)-MIN(LEVEL,2))*FLOOR((POW(MAX(LEVEL-2,1),1.6)*4000)*0.5+0.5)',
            3 => 'MAX(LEVEL-14,0)*2',
            
          },

          :production_time => '58400+(FLOOR(1.88*POW(LEVEL-1,1.8)+0.5)*6/100+1)*25000',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :domain            => :settlement,
                :speedup_formula   => "2*FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :level             => 1,
              },

            ],

            :defense_bonus => "0.5*LEVEL",

            :unlock_garrison => 1,            

            :command_points => "1",

            :unlock_building_slots => "MIN(LEVEL,1)*2",

            :garrison_size_bonus => "1000",

            :army_size_bonus => "1000",
    
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
          :flavour     => {
            
            :en_US => "<p>Hooray! Strike first then talk, is the overall principle the instructors drum into the recruits‘ brains.</p>",
  
            :de_DE => "<p>Hier ist kein Platz für Denker! Kraft und Ausdauer braucht ein Nahkämpfer, egal ob er mit Knüppel, Keule oder Speer bewaffnet ist.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>In dem Turm der Truppenunterkunft werden die Nahkämpfer in der Kunst des Kampfes unterwiesen. Der überaus sadistische Ausbilder legt höchsten Wert auf Gehorsam und Disziplin.</p><p>Wer den Befehlen nicht gehorcht oder sich im Training noch dümmer anstellt als die anderen, der muss im Turm der Reitmeisterei putzen. Wer es zurück schafft, kämpft anschließend mit deutlich größerem Elan.</p>",
  
            :en_US => "<p>Training center for close combat warriors. Without the infantry every army becomes useless - and this is the place where the backbone of every stone-aged and postmodern army composition gets finishing. Reckless. Ruthless. Relentless.</p>",
                
          },
          :hidden      => 0,

	        :population  => "2.5*POW(LEVEL,2)-2.5*LEVEL+5",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 4.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 2,

            },

            ],

          ],          

          :costs      => {
            0 => '(MIN(LEVEL+1,2)-MIN(LEVEL,2))*900+(MIN(LEVEL,2)-MIN(LEVEL,1))*FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*3*1.5+0.5)',
            1 => '(MIN(LEVEL+1,2)-MIN(LEVEL,2))*900+(MIN(LEVEL,2)-MIN(LEVEL,1))*((MIN(LEVEL,2)-MIN(LEVEL,1))*0.5+0.5)*FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*1.5*1.5+0.5)',
            2 => '(MIN(LEVEL,3)-MIN(LEVEL,2))*FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*0.5*1.5+0.5)',
            3 => 'MAX(LEVEL-14,0)',
            
          },

          :production_time => '43200+(FLOOR(1.88*POW(LEVEL-1,1.8)+0.5)*6/100.0+1)*9000',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 2,
                :queue_type_id_sym => :queue_infantry,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)*0.5+0.5)/100.0",
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
        {               #   Turm der Ballistik
          :id          => 2, 
          :symbolic_id => :building_artillery_tower,
					:category    => 1,
          :db_field    => :building_artillery_tower,
          :name        => {
            
            :de_DE => "Turm der Ballistik",
  
            :en_US => "Ballistic Tower",
                
          },
          :flavour     => {
            
            :en_US => "<p>Everything which can be shoot flies around here. So, watch yourself and duck in time! Training of long-range combat fighter is in progress.</p>",
  
            :de_DE => "<p>Hier fliegt alles, was man werfen oder abschießen kann! Kopf runter! Die Ausbildung der Fernkämpfer ist in vollem Gang.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Von außen betrachtet ist der Turm der Ballistik eine Augenweide. Von innen betrachtet ist der Turm ein Trümmerfeld. Kleine Kieselsteine liegen auf dem ganzen Boden verteilt, Bratspieße, Speere und Pfeile haben sich in sämtliche Stützpfeiler gebohrt und an den Wänden spuren hinterlassen.</p><p>Nicht weiter verwunderlich ist da die Helmpflicht. Die Ausbilder und Auszubildenden haben sich feste Tierhäute um den Kopf gebunden, damit sie den Aufprall kleiner Steiner oder Splitter halbwegs überstehen.</p><p>Verglichen mit der Ordnung einer Fernkämpfer-Kampfreihe auf dem Schlachtfeld ist das herrschende Chaos überraschend. Auf ein Kommando werden alle Arten von Wurfgeschossen in die Luft gesandt. Nur leider wissen die Wenigsten, auf welches Kommando sie eigentlich gerade achten sollen.</p>",
  
            :en_US => "<p>Trains artillery.</p>",
                
          },
          :hidden      => 0,

	        :population  => "2.5*POW(LEVEL,2)-2.5*LEVEL+5",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 4.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 5,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*1.5*1.5*2.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*3*1.5*2.5+0.5)',
            2 => '(MIN(LEVEL,3)-MIN(LEVEL,2))*FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*0.5*1.5*2.5+0.5)',
            3 => 'MAX(LEVEL-14,0)',
            
          },

          :production_time => '43200+(FLOOR(1.88*POW(LEVEL-1,1.8)+0.5)*6/100.0+1)*9000',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 3,
                :queue_type_id_sym => :queue_artillery,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)*0.5+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 3,
                :queue_type_id_sym => :queue_artillery,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Turm der Ballistik
        {               #   Turm der Reitmeisterei
          :id          => 3, 
          :symbolic_id => :building_cavalry_tower,
					:category    => 1,
          :db_field    => :building_cavalry_tower,
          :name        => {
            
            :de_DE => "Turm der Reitmeisterei",
  
            :en_US => "Cavalry Tower",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Hier sind Unmengen an Tieren und verschwitzten Männern untergebracht. Vorsicht vor Dung und penetrantem Geruch!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Turm der Reitmeisterei dient der Ausbildung aller berittenen Einheiten. Dabei wird vor allem Wert auf den Umgang mit den Tieren wie auch auf die Reittechnik gelegt.</p><p>Der Zutritt ist streng begrenzt auf ausgebildete Reiter und Tierpfleger. Wenn das Tor der Reitmeisterei kurzzeitig offen steht, schleichen sich oftmals neugierige halbstarke Jungs hinein. Zwar beeindruckt das die Mädchen ungemein, aber die Jungs haben keine Zeit mehr sich in der Aufmerksamkeit zu sonnen. Die Tierpfleger entsorgen die blutigen Überreste ohne großes Aufheben.</p>",
  
            :en_US => "<p>Training center for all mounted units. Horse-back riding is not vanilla, so, 101-riding courses, how to put spur on horses and domesticating them; all this is done here.</p><p>Access is only granted to equestrians and zookeepers.</p>",
                
          },
          :hidden      => 0,

	        :population  => "2.5*POW(LEVEL,2)-2.5*LEVEL+5",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 4.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 7,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*3*1.5*2.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*1.5*1.5*2.5+0.5)',
            2 => '(MIN(LEVEL,3)-MIN(LEVEL,2))*FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*0.5*1.5*2.5+0.5)',
            3 => 'MAX(LEVEL-14,0)',
            
          },

          :production_time => '43200+(FLOOR(1.88*POW(LEVEL-1,1.8)+0.5)*6/100.0+1)*9000',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 4,
                :queue_type_id_sym => :queue_cavalry,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)*0.5+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 4,
                :queue_type_id_sym => :queue_cavalry,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Turm der Reitmeisterei
        {               #   Garnison
          :id          => 4, 
          :symbolic_id => :building_fortress_garrison,
					:category    => 2,
          :db_field    => :building_fortress_garrison,
          :name        => {
            
            :de_DE => "Garnison",
  
            :en_US => "Garrison",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Hier werden die Entscheidungen getroffen! Je größer die Häuptlingshütte desto größer und vielfältiger die Siedlung und die Anzahl der Armeen, die ins Feld geführt werden können.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Häuptlingshütte spiegelt die Größe des Dorfes wieder. Jede Erweiterung der Häuptlingshütte ermöglicht neue Arten und eine größere Anzahl von Gebäuden zu bauen.
Hinter der Häuptlingshütte ist ein kleiner Lagerplatz, auf dem Rohstoffe zwischengelagert werden können, so lange es kein Lager gibt.</p><p>Außerdem ermöglicht die Häuptlingshütte Armeen aufzustellen.</p><p>Eine prunkvolle, mit Trophäen der Feinde geschmückte Hütte verringert die Moral möglicher Angreifer und erhöht die Moral der Verteidiger.</p>",
  
            :en_US => "<p>At start it is more a hut or but later an area to represent the chieftain‘s glory, advancement and power.</p><p>Symbols of triumph, the banners and iconic loot is shown off here. Rumor has it that the chieftain uses his hall for excessive orgies from time to time!</p>",
                
          },
          :hidden      => 1,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :experience_factor => 1,

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*1*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*2*1.5+0.5)',
            3 => 'MAX(LEVEL-14,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*2+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :garrison_size_bonus => "20*LEVEL",

            :army_size_bonus => "10*LEVEL",
    
          },

        },              #   END OF Garnison
        {               #   Häuptlingshütte
          :id          => 5, 
          :symbolic_id => :building_chief_cottage,
					:category    => 4,
          :db_field    => :building_chief_cottage,
          :name        => {
            
            :de_DE => "Häuptlingshütte",
  
            :en_US => "Chieftain‘s Hall",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Hier werden die Entscheidungen getroffen! Zeig mir Deine Häuptlingshütte und ich sag Dir wer Du bist! Mehr Gebäude, mehr Armeen, mehr Glanz. Häuptlinge sind wirklich berechenbar.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Lange Zeit ist die Häuptlingshütte das einzig halbwegs befestigte Gebäude der Siedlung. Allein an ihrer Größe läßt sich der Fortschritt der Siedlung ablesen. Je größer die Häuptlingshütte, desto mehr und bessere Gebäude und desto mehr Armeen kann eine Siedlung haben. Selbstverständlich hat der Häuptling in seiner Hütte auch ein kleines Lager für schwere Zeiten.</p><p>Eine prunkvolle, mit Trophäen gefallener Feinde geschmückte Hütte sieht nicht nur schick aus, sondern erhöht auch die Moral der Verteidiger.</p>",
  
            :en_US => "<p>At start it is more a hut or but later an area to represent the chieftain‘s glory, advancement and power.</p><p>Symbols of triumph, the banners and iconic loot is shown off here. Rumor has it that the chieftain uses his hall for excessive orgies from time to time!</p>",
                
          },
          :hidden      => 0,

	        :population  => "1+MIN(MAX(LEVEL-3,0),1)+MIN(MAX(LEVEL-6,0),1)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :experience_factor => 6,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2*1.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1*1.5+0.5)',
            
          },

          :production_time => '(MIN(LEVEL+1,2)-MIN(LEVEL,2))*10+(MIN(LEVEL,2)-MIN(LEVEL,1))*(MIN(LEVEL+1,4)-MIN(LEVEL,4))*(40*(LEVEL-1)-10)+(MIN(LEVEL,4)-MIN(LEVEL,3))*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*4+0.5)',
          :production  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "2",
              },
            
          ],
          :production_bonus  => [
            
          ],          

          :capacity  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "1600+100*(FLOOR((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(110*POW(LEVEL,2)-105*LEVEL)+(MAX(LEVEL+1,11)-MAX(LEVEL,11))*(20*POW((LEVEL),2)+9000))/100)",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "1600+100*(FLOOR((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(110*POW(LEVEL,2)-105*LEVEL)+(MAX(LEVEL+1,11)-MAX(LEVEL,11))*(20*POW((LEVEL),2)+9000))/100)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "(1600+100*(FLOOR((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(110*POW(LEVEL,2)-105*LEVEL)+(MAX(LEVEL+1,11)-MAX(LEVEL,11))*(20*POW((LEVEL),2)+9000))/100))*0.5",
              },
            
              {
                :id                 => 3,
                :symbolic_id        => :resource_cash,
                :formula            => "10000",
              },
            
          ],

          :abilities   => {

            :unlock_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :level             => 1,
              },

            ],

            :defense_bonus => "0.5*LEVEL",

            :unlock_garrison => 2,            

            :command_points => "MAX(LEVEL+1,3)-MAX(LEVEL,3)+MAX(LEVEL+1,6)-MAX(LEVEL,6)+MAX(LEVEL+1,12)-MAX(LEVEL,12)",

            :unlock_building_slots => "MIN(LEVEL,10)*4-1",

            :garrison_size_bonus => "1000",

            :army_size_bonus => "1000",
    
          },

        },              #   END OF Häuptlingshütte
        {               #   Jäger und Sammler
          :id          => 6, 
          :symbolic_id => :building_gatherer,
					:category    => 5,
          :db_field    => :building_gatherer,
          :name        => {
            
            :de_DE => "Jäger und Sammler",
  
            :en_US => "Hunter-Gatherer",
                
          },
          :flavour     => {
            
            :en_US => "<p>Collecs resources for the daily needs.</p>",
  
            :de_DE => "<p>Holz und Steine, ein paar Kaninchen oder andere Nager und ganz selten auch mal eine Kröte. Die wahren Schätze aus Sicht des Jägers und Sammlers sind aber Pilze. Vor allem die weißen mit den roten Punkten.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Primitivster aller Steinzeitbewohner. Um sein Gebiet im Auge zu behalten, schläft er niemals in einer Hütte, sondern davor, oder auch oben drauf. Alle seine Schätze werden fein säuberlich auf seinem Gelände zur Schau gestellt.</p><p>Er jagt und sammelt einfach alles was ihm vor die Flinte - äh Steinschleuder - kommt.Neben vielen völlig unbrauchbaren Sachen finden die Bewohner alles von Ästen und Steinen über Wurzeln und bei ausreichend großem Gelände sogar ein paar Kröten.</p>",
  
            :en_US => "<p>Hunting and gathering everything useful which comes in sight and is accordingly the collector of basic resources for the daily needs. He comes home with wood, stones and easily slain animals.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 0.49,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 1,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 1,

            },

            ],

          ],          

          :costs      => {
            0 => '(MIN(LEVEL+1,2)-MIN(LEVEL,2))*3+(MIN(LEVEL,2)-MIN(LEVEL,1))*FLOOR((((MIN(LEVEL,6)-MIN(LEVEL,5))*0.2+0.8)*(0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.33+0.5)',
            1 => '(MIN(LEVEL+1,2)-MIN(LEVEL,2))*3+(MIN(LEVEL,2)-MIN(LEVEL,1))*FLOOR((((MIN(LEVEL,6)-MIN(LEVEL,5))*0.2+0.8)*(0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.33+0.5)',
            2 => '(MIN(LEVEL+1,2)-MIN(LEVEL,2))*0+(MIN(LEVEL,2)-MIN(LEVEL,1))*FLOOR((((MIN(LEVEL,6)-MIN(LEVEL,5))*0.2+0.8)*(0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.16+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => '(MIN(LEVEL+1,3)-MIN(LEVEL,3))*LEVEL*10+(MIN(LEVEL,3)-MIN(LEVEL,2))*(MIN(LEVEL+1,4)-MIN(LEVEL,4))*115+(MIN(LEVEL,4)-MIN(LEVEL,3))*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*0.7+0.5)',
          :production  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)*0.25+0.5)",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)*0.25+0.5)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)*0.125+0.5)",
              },
            
              {
                :id                 => 3,
                :symbolic_id        => :resource_cash,
                :formula            => "(MIN(LEVEL,11)-MIN(LEVEL,10))*1/48.0+(MIN(LEVEL,20)-MIN(LEVEL,19))*1/48.0",
              },
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {
    
          },

        },              #   END OF Jäger und Sammler
        {               #   Kleine Hütte
          :id          => 7, 
          :symbolic_id => :building_cottage,
					:category    => 5,
          :db_field    => :building_cottage,
          :name        => {
            
            :de_DE => "Kleine Hütte",
  
            :en_US => "Small Hut",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>In den kleinen Hütten leben eure Untertanen. Je mehr Untertanen, desto schneller geht auch der Bau von Gebäuden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die kleine Hütte schützt Eure Untertanen gerade mal vor Sonne und Regen. Hauptsache, sie sind fleißig und beschweren sich nicht. Je mehr Hütten, desto mehr Untertanen habt ihr, die wiederum schneller arbeiten und Eure Siedlung schneller ausbauen. Wenn Chef sein immer so einfach wäre!</p>",
  
            :en_US => "<p>Provides shelter for your subjects. No-one is as demanding as you are, so your people only need basic fit-outs inside their own four walls.</p><p>Your grace and foreseeing leadership is fullfilling all their needs of luxury. The good old times!</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 2,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 2,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.75*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.125*1.5+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*1.43*(25*POW(LEVEL,2)-50*LEVEL+40)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*0.7+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)*1.5+0.5)/100.0",
              },

            ],
    
          },

          :conversion_option => {
            :building              => :building_cottage_2,
            :target_level_formula  => "LEVEL-(MIN(LEVEL,5)-MIN(LEVEL,4))-(MIN(LEVEL,10)-MIN(LEVEL,9))-(MIN(LEVEL,14)-MIN(LEVEL,13))", 
          },

        },              #   END OF Kleine Hütte
        {               #   Ausbildungsgelände
          :id          => 8, 
          :symbolic_id => :building_barracks,
					:category    => 5,
          :db_field    => :building_barracks,
          :name        => {
            
            :de_DE => "Ausbildungsgelände",
  
            :en_US => "Barracks",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Auf der Suche nach einem kleinen Kampf? Lange nicht mehr verprügelt worden? In der Kaserne finden sich alle, die sich gerne mitten ins Getümmel stürzen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Auf dem Ausbildungsgelände werden alle Arten von Nahkämpfern ausgebildet. Große Keule, Bratspieß oder doch die bloßen Fäuste, alles ist erlaubt.</p><p>In zahlreichen Wettbewerben messen sich die kommenden Krieger, um sich im Zweikampf zu stählen. Einmal im Mondumlauf wird ein öffentliches Turnier veranstaltet. Der Sieger bekommt alles. Ruhm, Essen, einen Tag frei und Männer soviel sie wollen. Ja Männer! Denn zumeist gewinnt eine Frau dieses Turnier. Wie? Mit den tödlichen Waffen einer Frau natürlich!</p>",
  
            :en_US => "<p>Training facility for all kinds of groud units and also hosts troops. It has its own drill ground and from to time to time you can see magnificient parades.</p><p>Don´t get mistaken for one of the punching dummies or you won´t leave the barracks alive! Training of beserkers is in progress.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 4.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 3,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 3,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5*1.5+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => '(MIN(LEVEL+1,2)-MIN(LEVEL,2))*40+(MIN(LEVEL,2)-MIN(LEVEL,1))*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*3+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 2,
                :queue_type_id_sym => :queue_infantry,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
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

        },              #   END OF Ausbildungsgelände
        {               #   Lagerfeuer
          :id          => 9, 
          :symbolic_id => :building_campfire,
					:category    => 6,
          :db_field    => :building_campfire,
          :name        => {
            
            :de_DE => "Lagerfeuer",
  
            :en_US => "Campfire",
                
          },
          :flavour     => {
            
            :en_US => "<p>Diplomatic bla-bla or alliance conferences can be held in the embassies. And a good conversation is not a monologue!</p>",
  
            :de_DE => "<p> Ort diplomatischen Austauschs oder Besprechungen innerhalb der Allianz. Zu einer guten Unterhaltung gehören mindestens zwei, auch wenn oft nur einer redet. Reden, das kann der Kleine Häuptling wie kein zweiter.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Am Lagerfeuer versammeln sich die Bewohner in geselligen Runden oder für wichtige Absprachen. Auch die Gäste werden wahlweise ans Feuer gebeten oder am Marterpfahl aufgestellt.</p><p>Verhandlungen mit Nachbarn oder Allianzen, alles findet bei reichlich Gerstensaft am Lagerfeuer statt.</p><p>Am Lagerfeuer beginnen auch die Karrieren der Kleinen Häuptlinge. Ein paar nette Worte hier, eine kleine Intrige da, schmücken mit fremden Federn und schon kann man sich den Status des kleinen Häuptlings erwerben und vielleicht eine eigene Lagerstätte gründen.</p><p>Vorsicht: Ein Lagerfeuer kann nur auf einem kleinen Bauplatz erreicht und nicht abgerissen werden!</p>",
  
            :en_US => "<p>Assembly area for the locals and also the district of foreign embassies. Random guests are normally invited to sit by the fire while hostile messengers get hammered at the stake.</p><p>The place to be in every settlement for networking and discussing the really important matters, like whether a stranger gets eaten alive or tickled to ecstasy.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 4,

            },

            {
              :symbolic_id => 'building_campfire',
              :id => 9,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1*1.5+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => '(MIN(LEVEL+1,2)-MIN(LEVEL,2))*20+(MIN(LEVEL,2)-MIN(LEVEL,1))*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*2+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :unlock_queue => [

              {
                :queue_type_id     => 6,
                :queue_type_id_sym => :queue_special,
                :level             => 1,
              },

            ],

            :unlock_diplomacy     => 1,

            :unlock_alliance_creation => 5,
    
          },

        },              #   END OF Lagerfeuer
        {               #   Holzfäller
          :id          => 10, 
          :symbolic_id => :building_logger,
					:category    => 5,
          :db_field    => :building_logger,
          :name        => {
            
            :de_DE => "Holzfäller",
  
            :en_US => "Lumberjack",
                
          },
          :flavour     => {
            
            :en_US => "<p>Wood! Even more wood!</p>",
  
            :de_DE => "<p>Ein Mann und seine Steinaxt! Neben losem Holz bringt er ab und zu sogar einen selbst gefällten Baum mit ins Lager.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Unter Ausnutzung purer Gewalt aber auch modernster Steinwerkzeuge gelingt es dem Holzfäller, mehr oder weniger große Stämme zu fällen und zu wertvollen Rohstoffen zu verarbeiten.</p><p>Große Holzfäller lassen nur die kleinen Bäume übrig und reduzieren so die Frustration der kleineren Holzfäller, was sich sehr positiv auf ihren Ertrag auswirkt.</p>",
  
            :en_US => "<p>Specialized in cutting trees more efficiently than the gatherer and produces logs. Is by definition permanently competing with the quarry man.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 5,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 5,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*1.1+0.5)',
          :production  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)+0.5)",
              },
            
          ],
          :production_bonus  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "MAX(LEVEL-10,0)*0.01+MAX(0,LEVEL-19)*0.05",
              },
            
          ],          

          :abilities   => {
    
          },

          :conversion_option => {
            :building              => :building_logger_2,
            :target_level_formula  => "(MIN(LEVEL+1,5)-MIN(LEVEL,5))*FLOOR((LEVEL+1)/2.0+0.5)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,15)-MIN(LEVEL,15))*(LEVEL-2)+(MIN(LEVEL,15)-MIN(LEVEL,14))*(LEVEL-3)", 
          },

        },              #   END OF Holzfäller
        {               #   Steinbruch
          :id          => 11, 
          :symbolic_id => :building_quarry,
					:category    => 5,
          :db_field    => :building_quarry,
          :name        => {
            
            :de_DE => "Steinbruch",
  
            :en_US => "Quarry",
                
          },
          :flavour     => {
            
            :en_US => "<p>Stones, even more stones!</p>",
  
            :de_DE => "<p>Steine, nichts als Steine! Verschwitzte Arbeiter und der monotone Schlag der schweren Werkzeuge. Genau, was man von einem Steinbruch erwartet.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Durch eine aus Sicht der Steinzeit komplizierte Kette von Arbeitsvorgängen werden im Steinbruch Steine gewonnen.</p><p>Ein richtig großer Steinbruch treibt den Wettkampf unter den Steinbrechern an und sorgt so für noch schnelleren Abbau auch bei den anderen Steinbrüchen.</p>",
  
            :en_US => "<p>Specialized in rock cutting more efficiently than the gatherer and produces stones. It is still not clear, if lumberjacks and quarry men are akin to each other or not.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 5,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 5,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1*1.5+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*1.1+0.5)',
          :production  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)+0.5)",
              },
            
          ],
          :production_bonus  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "MAX(LEVEL-10,0)*0.01+MAX(0,LEVEL-19)*0.05",
              },
            
          ],          

          :abilities   => {
    
          },

          :conversion_option => {
            :building              => :building_quarry_2,
            :target_level_formula  => "(MIN(LEVEL+1,5)-MIN(LEVEL,5))*FLOOR((LEVEL+1)/2.0+0.5)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,15)-MIN(LEVEL,15))*(LEVEL-2)+(MIN(LEVEL,15)-MIN(LEVEL,14))*(LEVEL-3)", 
          },

        },              #   END OF Steinbruch
        {               #   Kürschner
          :id          => 12, 
          :symbolic_id => :building_furrier,
					:category    => 5,
          :db_field    => :building_furrier,
          :name        => {
            
            :de_DE => "Kürschner",
  
            :en_US => "Peltmonger",
                
          },
          :flavour     => {
            
            :en_US => "<p>The peltmonger is literally flaying all day long!</p>",
  
            :de_DE => "<p>Der Kürschner zieht dem Tier das Fell über die Ohren. Hier gibt es schöne Felle und hochwertige Lederwaren für die Dame von Welt, dazu immer mal ein leckeres Tier auf dem Feuer.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Kürschner verarbeitet Häute zu Leder und macht selbst aus den kleinsten Nagern noch ein brauchbares Fell. Und wenn tatsächlich mal ein Säbelzahntiger erlegt wird, dann zaubert er auch etwas für die Dame von Welt im Angebot.</p><p>Die Abfälle von großen Kürschnereien werden von kleineren Kürschnereien mit geringem Aufwand weiterverarbeitet und erhöht damit die Fellproduktion deutlich.</p>",
  
            :en_US => "<p>Manufacturing hides into leather. Sometimes there are also must-have sabre cat furs as ready-to-wear fashion for the lady or cosy brontosaurus regulation underwear.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 8,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 8,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5)',
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.25*1.5+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*1.1+0.5)',
          :production  => [
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)*0.5+0.5)",
              },
            
          ],
          :production_bonus  => [
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "MAX(LEVEL-10,0)*0.01+MAX(0,LEVEL-19)*0.05",
              },
            
          ],          

          :abilities   => {
    
          },

          :conversion_option => {
            :building              => :building_furrier_2,
            :target_level_formula  => "(MIN(LEVEL+1,5)-MIN(LEVEL,5))*FLOOR((LEVEL+1)/2.0+0.5)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,15)-MIN(LEVEL,15))*(LEVEL-2)+(MIN(LEVEL,15)-MIN(LEVEL,14))*(LEVEL-3)", 
          },

        },              #   END OF Kürschner
        {               #   Schießstand
          :id          => 13, 
          :symbolic_id => :building_firing_range,
					:category    => 5,
          :db_field    => :building_firing_range,
          :name        => {
            
            :de_DE => "Schießstand",
  
            :en_US => "Firing Range",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Keine Lust auf Prügeleien oder stinkende Tiere? Du willst deinen Gegner am liebsten aus sicherer Entfernung töten? Dann ist Fernkampf dein Ding!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Steine, Speere und alles, was man werfen oder schießen kann, fliegt auf dem Ausbildungsgelände für Fernkämpfer durch die Luft.</p><p>Ein größerer Aufbau sorgt für eine beschleunigte Ausbildung und sogar für die Entwicklung völlig neuer Techniken, auf deren Basis neue Einheiten ausgebildet werden können.</p>",
  
            :en_US => "<p>Training area for ranged units. Stones and javelins fill the air with a whiring buzz.</p><p>If some-one lacks courage to fight face-to-face, the firing range is the place to make a career in the army. Accidents that go pear-shaped are possible!</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 4.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 3,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 13,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*1.5*1.5)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*3*1.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(1800+200*LEVEL)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*3+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 3,
                :queue_type_id_sym => :queue_artillery,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 3,
                :queue_type_id_sym => :queue_artillery,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Schießstand
        {               #   Stinkender Stall
          :id          => 14, 
          :symbolic_id => :building_stud,
					:category    => 5,
          :db_field    => :building_stud,
          :name        => {
            
            :de_DE => "Stinkender Stall",
  
            :en_US => "Stable",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Stinkende Tiere und eine kleine Katze. Ein Leben auf dem Ponyhof könnte nicht schöner sein.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kein Ort in der Siedlung stinkt so sehr wie der Stall. Nicht weiter verwunderlich, werden hier doch Straußen, Säbelzahntiger, kleine Dinosaurier und als Maskottchen eine Katze gehalten.</p><p>Vorrangig werden die Tiere dressiert und den Reitern der richtige Umgang beigebracht. Die wenigsten Reiter führen im Kampf selber Waffen, um sich ganz auf das Reiten zu konzentrieren. Das Reittier ist die Waffe!</p><p>Größere Ställe stinken noch stärker, beschleunigen aber auch die Ausbildung und können noch stärkere Tiere abrichten.</p>",
  
            :en_US => "<p>Hosts troops.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 4.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 6,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 16,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*3*1.5)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*1.5*1.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(1800+200*LEVEL)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*3+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 4,
                :queue_type_id_sym => :queue_cavalry,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 4,
                :queue_type_id_sym => :queue_cavalry,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Stinkender Stall
        {               #   Rohstofflager
          :id          => 15, 
          :symbolic_id => :building_storage,
					:category    => 5,
          :db_field    => :building_storage,
          :name        => {
            
            :de_DE => "Rohstofflager",
  
            :en_US => "Storage",
                
          },
          :flavour     => {
            
            :en_US => "<p>Stores your resources.</p>",
  
            :de_DE => "<p>Steincontainer, Saurierkräne und seit neuestem, Karren. Soviel Stil muss sein!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Steinzeitliches Logistikzentrum zum Lagern und Versenden von Rohstoffen. Je größer das Lager, desto mehr Karren können versendet werden.</p><p>Ein Rohstofflager erhöht die maximale Lagermenge und ermöglicht den Handel mit anderen Spielern. Mehere Rohstofflager wirken kumulativ und  erhöhen sowohl die Lager- als auch die Handelsmenge.</p>",
  
            :en_US => "<p>Storage space.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 4,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 4,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1*1.5+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => '(MIN(LEVEL+1,2)-MIN(LEVEL,2))*15+(MIN(LEVEL,2)-MIN(LEVEL,1))*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*1.1*1.5+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :capacity  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*1)",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*1)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*0.5)",
              },
            
          ],

          :abilities   => {

            :trading_carts => "10*LEVEL*LEVEL",

            :unlock_p2p_trade => 1,            
    
          },

          :conversion_option => {
            :building              => :building_storage_2,
            :target_level_formula  => "LEVEL-(MIN(LEVEL,5)-MIN(LEVEL,4))-(MIN(LEVEL,10)-MIN(LEVEL,9))-(MIN(LEVEL,14)-MIN(LEVEL,13))", 
          },

        },              #   END OF Rohstofflager
        {               #   Winddichte Hütte
          :id          => 16, 
          :symbolic_id => :building_cottage_2,
					:category    => 5,
          :db_field    => :building_cottage_2,
          :name        => {
            
            :de_DE => "Winddichte Hütte",
  
            :en_US => "Hut",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Ein Feuerplatz, eingezäunter Vorgarten und eine Fußmatte vor der Tür. Ein Traum!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>In der fortschrittlichen winddichten Hütten wohnen die verdienten sprich fleißigen Bewohner. Diese Hütte hat neben Wände, die diesen Namen auch verdienen, sogar einen Feuerplatz, wodurch die Bewohner noch zufriedener werden. Und sie ist natürlich größer, denn seien wir mal ehrlich, zwei Arbeiter sind immer besser als ein zufriedener.</p>",
  
            :en_US => "<p>Provides shelter for your subjects. No-one is as demanding as you are, so your people only need basic fit-outs inside their own four walls.</p><p>Your grace and foreseeing leadership is fullfilling all their needs of luxury. The good old times!</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 3.3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 1,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 11,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.75*1.5*8.05+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5*8.05+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.125*1.5*8.05+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*0.7)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)*1.5*1.75+0.5)/100.0",
              },

            ],
    
          },

        },              #   END OF Winddichte Hütte
        {               #   Kommandozentrale
          :id          => 17, 
          :symbolic_id => :building_command_post,
					:category    => 4,
          :db_field    => :building_command_post,
          :name        => {
            
            :de_DE => "Kommandozentrale",
  
            :en_US => "Command Post",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Die Koordination von Armeen ist die hohe Kunst des Krieges. Selbst wenn alle Armeen nur in eine Richtung mit dem Auftrag „immer feste druff“ geschickt werden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein paar Äste zwischen drei Bäume gespannt, darauf Rinde und Blätter und fertig ist das Sonnensegel. Ein schöner großer Sitz für den Häuptling und fertig ist der Kommandoposten. Hier wird die Taktik bestimmt und Befehle erteilt. Meist immer derselbe: Haut sie feste!</p><p>Der Kommandoposten erhöht auf den Leveln 1, 10 und 20 die maximale Anzahl an Armeen. Zudem wird die Produktionszeit aller Einheiten gesenkt.</p>",
  
            :en_US => "<p>At start it is more a hut or but later an area to represent the chieftain‘s glory, advancement and power.</p><p>Symbols of triumph, the banners and iconic loot is shown off here. Rumor has it that the chieftain uses his hall for excessive orgies from time to time!</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :experience_factor => 10,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 5,

            },

            {
              :symbolic_id => 'building_command_post',
              :id => 17,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*4*1.5)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*4*1.5)',
            
          },

          :production_time => 'FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*4)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 2,
                :queue_type_id_sym => :queue_infantry,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

              {
                :queue_type_id     => 3,
                :queue_type_id_sym => :queue_artillery,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

              {
                :queue_type_id     => 4,
                :queue_type_id_sym => :queue_cavalry,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

            ],

            :command_points => "1+FLOOR(LEVEL/10.0)",
    
          },

        },              #   END OF Kommandozentrale
        {               #   Kupferschmelze
          :id          => 18, 
          :symbolic_id => :building_copper_smelter,
					:category    => 6,
          :db_field    => :building_copper_smelter,
          :name        => {
            
            :de_DE => "Kupferschmelze",
  
            :en_US => "Copper Smelter",
                
          },
          :flavour     => {
            
            :en_US => "<p>Flavour here</p>",
  
            :de_DE => "<p>Kupfer glitzert zwar auch schon im Rohzustand, aber erst nach dem Schmelzen kann es zu Schmuck verarbeitet werden. Ab und zu stellt man auch hilfreiche Werkzeuge damit her.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kupfer ist DIE Entdeckung der Steinzeit und führte zu schönerem Schmuck und tödlicheren Waffen und auch dem ein oder anderen Fortschritt bei Werkzeugen.</p><p>Der Kupferschmelzer ermöglicht den Fortschritt in die Kupferzeit und den Zugriff auf neue fortschrittlichere Gebäude. Ein Kupferschmelzer kann nur auf einem kleinen Bauplatz gebaut und nicht wieder abgerissen werden.</p>",
  
            :en_US => "<p>Description here</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :experience_factor => 12,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*4*1.5)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*4*1.5)',
            2 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*2*1.5)',
            3 => 'MAX(LEVEL-8,0)',
            
          },

          :production_time => '43200+3600*MAX(0,LEVEL)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {
    
          },

        },              #   END OF Kupferschmelze
        {               #   Feldlager
          :id          => 19, 
          :symbolic_id => :building_field_camp,
					:category    => 4,
          :db_field    => :building_field_camp,
          :name        => {
            
            :de_DE => "Feldlager",
  
            :en_US => "Field Camp",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Feldlager verwandeln Lagerstätten mit größeren und auch einer Armee mehr in militärische Stützpunkte. Durch all das Gerede über die Sicherheit, die Feldlager für die Lagerstätte bieten, ziehen Feldlager Feinde erst recht an.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Mit Bau des Feldlagers ist es endgültig klar: „Wir sind nicht zum Spass hier, wir wollen kämpfen!“</p><p>Das Feldlager erhöht die Garnison und die Armee um 300 Einheiten plus 50 pro Level auf Level 1-10 und 20 pro Level auf Level 11-20.</p><p>Auf Level 10 ermöglicht das Feldlager einen zweiten Kommandopunkt.</p>",
  
            :en_US => "<p>Training facility for all kinds of ground units and also hosts troops. It has its own drill ground and from to time to time you can see magnificient parades.</p><p>Don´t get mistaken for one of the punching dummies or you won´t leave the barracks alive! Training of beserkers is in progress.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => false,
          :demolishable=> true,
          :destructable=> false,
          :experience_factor => 8,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 3,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'EQUAL(LEVEL,1)*32*3600+GREATER(LEVEL,1)*FLOOR((EQUAL(LEVEL,2)*1200+
	(GREATER(LEVEL,2)*GREATER(10,LEVEL))*30*POW(LEVEL+1,3.2)+GREATER(LEVEL,9)*47547*(0.06*(LEVEL+1-10)+0.98))*1.5+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :command_points => "MAX(LEVEL+1,10)-MAX(LEVEL,10)",

            :garrison_size_bonus => "300+50*LEVEL-GREATER(LEVEL,10)*(LEVEL-10)*30",

            :army_size_bonus => "300+50*LEVEL-GREATER(LEVEL,10)*(LEVEL-10)*30",
    
          },

        },              #   END OF Feldlager
        {               #   Verrückter Kürschner
          :id          => 20, 
          :symbolic_id => :building_furrier_2,
					:category    => 5,
          :db_field    => :building_furrier_2,
          :name        => {
            
            :de_DE => "Verrückter Kürschner",
  
            :en_US => "Peltmonger",
                
          },
          :flavour     => {
            
            :en_US => "<p>The peltmonger is literally flaying all day long!</p>",
  
            :de_DE => "<p>Einem Kürschner mit Kupfermesser sollte man besser nicht zu nahe kommen. Kein Krieger kann so gut mit einer Waffe umgehen wie ein verrückter Kürschner.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Kupfermesser waren ein Geschenk der Götter. Zumindest glauben das die Kürschner, die mit den Kupfermessern herausragende Mode entwerfen. Leider mit den bekannten Nebeneffekten: Fächer wedeln, nasale Stimme und sonstigem Irrsinn.</p><p>Genau deswegen sind die verrückten Kürschner natürlich große Vorbilder für andere Kürschner.</p>",
  
            :en_US => "<p>Manufacturing hides into leather. Sometimes there are also must-have sabre cat furs as ready-to-wear fashion for the lady or cosy brontosaurus regulation underwear.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 3.3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 7,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 17,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5*8.05+0.5)',
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5*8.05+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.25*1.5*8.05+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*1)',
          :production  => [
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)*0.5*2.25+0.5)",
              },
            
          ],
          :production_bonus  => [
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "MAX(LEVEL-10,0)*0.01+MAX(0,LEVEL-19)*0.05",
              },
            
          ],          

          :abilities   => {
    
          },

        },              #   END OF Verrückter Kürschner
        {               #   Holzfäller mit Kupferaxt
          :id          => 21, 
          :symbolic_id => :building_logger_2,
					:category    => 5,
          :db_field    => :building_logger_2,
          :name        => {
            
            :de_DE => "Holzfäller mit Kupferaxt",
  
            :en_US => "Lumberjack",
                
          },
          :flavour     => {
            
            :en_US => "<p>Wood! Even more wood!</p>",
  
            :de_DE => "<p>Ein Mann und seine Kupferaxt! Obwohl die Kupferaxt ständig verbiegt, bringt er tatsächlich selbst gefällte Bäume und weniger loses Gestrüpp mit.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kupferäxte fällen einen Baum deutlich schneller. Leider sind Kupferäxte auch sehr reparaturbedürftig. Dennoch sind Holzfäller effektiver und leiten ab einer bestimmten Größe auch die normalen Holzfäller zu erhöhtem Bäume fällen an.</p>",
  
            :en_US => "<p>Specialized in cutting trees more efficiently than the gatherer and produces logs. Is by definition permanently competing with the quarry man.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 3.3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 4,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 14,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1*1.5*8.05+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5*8.05+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*1)',
          :production  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)*2.25+0.5)",
              },
            
          ],
          :production_bonus  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "MAX(LEVEL-10,0)*0.01+MAX(0,LEVEL-19)*0.05",
              },
            
          ],          

          :abilities   => {
    
          },

        },              #   END OF Holzfäller mit Kupferaxt
        {               #   Altehrwürdiger Steinbruch
          :id          => 22, 
          :symbolic_id => :building_quarry_2,
					:category    => 5,
          :db_field    => :building_quarry_2,
          :name        => {
            
            :de_DE => "Altehrwürdiger Steinbruch",
  
            :en_US => "Quarry",
                
          },
          :flavour     => {
            
            :en_US => "<p>Stones, even more stones!</p>",
  
            :de_DE => "<p>In der Kupferzeit würde man erwarten, kupferne Spitzhacken bei den Arbeitern zu finden. Doch die Arbeiter haben das Kupfer lieber in Schmuck für ihre Frauen investiert. Offensichtlich die bessere Investition, denn die Belohnung der glücklichen Frauen ist umso größer.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Wie die Steinbrüche in der Kupferzeit mehr Steine abbauen können, bleibt rätselhaft. Denn sie sind die einzigen, die keine Kupferwerkzeuge bekommen haben. Aber trotzdem geht der Abbau spürbar schneller.</p><p>Ab einer gewissen Größe werden die Arbeiter noch schneller und treiben sogar andere Steinbrüche zu schnellerer Arbeit an.</p>",
  
            :en_US => "<p>Specialized in rock cutting more efficiently than the gatherer and produces stones. It is still not clear, if lumberjacks and quarry men are akin to each other or not.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 3.3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 4,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 14,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5*8.05+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1*1.5*8.05+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*1)',
          :production  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)*2.25+0.5)",
              },
            
          ],
          :production_bonus  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "MAX(LEVEL-10,0)*0.01+MAX(0,LEVEL-19)*0.05",
              },
            
          ],          

          :abilities   => {
    
          },

        },              #   END OF Altehrwürdiger Steinbruch
        {               #   Garnisonsgebäude
          :id          => 23, 
          :symbolic_id => :building_garrison,
					:category    => 5,
          :db_field    => :building_garrison,
          :name        => {
            
            :de_DE => "Garnisonsgebäude",
  
            :en_US => "Garrison",
                
          },
          :flavour     => {
            
            :en_US => "<p>This is THE place for warriors of all kinds to repeatedly bash their heads in.</p>",
  
            :de_DE => "<p>Krieger aller Art sollten getrennt von der normalen arbeitenden Bevölkerung gehalten werden. In der Garnison können sie sich gegenseitig die Schädel einschlagen und die armen Siedlungsbewohner in Ruhe lassen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Mit größere Garnisonen können größere Armeen aufgestellt werden. Jedes Level der Garnison erhöht die maximale Anzahl der Einheiten in der Garnison und in den Armeen um 25.</p>",
  
            :en_US => "<p>Bigger garrisons lead to… bigger garrison armies who would have thought that. They also affect the effective field army size.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :experience_factor => 3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 8,

            },

            {
              :symbolic_id => 'building_garrison',
              :id => 23,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*4*1.5)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*4*1.5)',
            
          },

          :production_time => 'FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*4)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :garrison_size_bonus => "25*LEVEL",

            :army_size_bonus => "25*LEVEL",
    
          },

        },              #   END OF Garnisonsgebäude
        {               #   Rohstofflager mit Kupferkarren
          :id          => 24, 
          :symbolic_id => :building_storage_2,
					:category    => 5,
          :db_field    => :building_storage_2,
          :name        => {
            
            :de_DE => "Rohstofflager mit Kupferkarren",
  
            :en_US => "Storage",
                
          },
          :flavour     => {
            
            :en_US => "<p>Stores your resources.</p>",
  
            :de_DE => "<p>Steincontainer, Saurierkräne und, seit neuestem, Kupferkarren. Endlich können Rohstoffe mit Stil transportiert werden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kupferkarren! DAS Statussymbol für den Häuptling. Neben den Karren gibt es auch größeren Lagerraum, aber wen interessiert das neben in der Sonne blinkenden Kupferkarren.</p>",
  
            :en_US => "<p>Storage space.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :experience_factor => 3.3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 2,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 12,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2*8.05+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1*1.5*8.05+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*1)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :capacity  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*1*1.75)",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*1*1.75)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*0.5*1.75)",
              },
            
          ],

          :abilities   => {

            :trading_carts => "FLOOR(10*LEVEL*LEVEL*1.75+0.5)",

            :unlock_p2p_trade => 1,            
    
          },

        },              #   END OF Rohstofflager mit Kupferkarren
        {               #   Ritualstein
          :id          => 25, 
          :symbolic_id => :building_altar,
					:category    => 4,
          :db_field    => :building_altar,
          :name        => {
            
            :de_DE => "Ritualstein",
  
            :en_US => "Altar",
                
          },
          :flavour     => {
            
            :en_US => "<p>Ritual sacrifices are made on the altar to appease the gods. Because no one wants to be struck down by an angry god.</p>",
  
            :de_DE => "<p>Die auf dem Ritualstein durchgeführten Zeremonien und regelmäßigen Opfergaben besänftigen die Götter. Eine derart von den Göttern gesegnete Lagerstätte kann von Feinden nicht erobert werden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Ritualstein ist ein von Fackeln umringter von blutigen Opfergaben verschmierter und mit den Gaben der Felder und den Köpfen der Feinde dekorierter Steintisch. Dieser Steintisch begeistert auch die Götter. Zumindest ist die Lagerstätte mit einem Ritualstein vor einer feindlichen Übernahme sicher. Wenn das kein Wink der  Götter ist!</p>",
  
            :en_US => "<p>At the altar the tribe prays and makes ritual sacrifices. Legend tells of great wars, in which half-gods lead tribes against each other battling for dominance over the valley.</p><p>The next war is coming and every tribe is competing to get the attention of the gods.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => false,
          :demolishable=> true,
          :destructable=> false,
          :experience_factor => 8,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 3,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5*1.5+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'EQUAL(LEVEL,1)*32*3600+GREATER(LEVEL,1)*FLOOR((EQUAL(LEVEL,2)*1200+
	(GREATER(LEVEL,2)*GREATER(10,LEVEL))*30*POW(LEVEL+1,3.2)+GREATER(LEVEL,9)*47547*(0.06*(LEVEL+1-10)+0.98))*1.5+0.5)
',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :unlock_prevent_takeover => 1,            
    
          },

        },              #   END OF Ritualstein
        {               #   Versammlungsplatz
          :id          => 26, 
          :symbolic_id => :building_haunt,
					:category    => 4,
          :db_field    => :building_haunt,
          :name        => {
            
            :de_DE => "Versammlungsplatz",
  
            :en_US => "Haunt",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Hier treffen sich alle wichtigen Personen der Lagerstätte jeden Abend, um die wichtigen Probleme zu besprechen. Zum Beispiel, wie man die Bierflaute lösen kann.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Versammlungsplatz ist der zentrale Ort einer neu gegründeten Lagerstätte. Ein großer Pfahl mit den Insignien der Macht sowie ein bißchen Platz für die Ablage von ein paar Rohstoffe.</p><p>Der Ausbau des Versammlungsplatzes ermöglicht den Bau von zusätzlichen Gebäuden in der gründbaren Lagerstätte.</p>",
  
            :en_US => "<p>At start it is more a hut or but later an area to represent the chieftain‘s glory, advancement and power.</p><p>Symbols of triumph, the banners and iconic loot is shown off here. Rumor has it that the chieftain uses his hall for excessive orgies from time to time!</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :experience_factor => 6,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 26,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2*1.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1*1.5+0.5)',
            
          },

          :production_time => '8*3600+4*LEVEL*3600',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :unlock_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :level             => 1,
              },

            ],

            :defense_bonus => "0.25*LEVEL",

            :unlock_garrison => 2,            

            :command_points => "1",

            :unlock_building_slots => "MIN(LEVEL,1)*7+(MIN(LEVEL,11)-MIN(LEVEL,10))*2+(MIN(LEVEL,20)-MIN(LEVEL,19))*2",

            :garrison_size_bonus => "200",

            :army_size_bonus => "200",
    
          },

        },              #   END OF Versammlungsplatz
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

	        :conquerable => false,
	        :destroyable => false,





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

	        :conquerable => true,
	        :destroyable => false,



          :building_slots => {
            0 => {
              :max_level => 15,
              
              :building  => 0,
              
              :level  => 1,
              
              :options   => [
              0,
              
              ],
            },
            1 => {
              :max_level => 15,
              
              :level  => 0,
              
              :options   => [
              1,
              
              ],
            },
            2 => {
              :max_level => 15,
              
              :level  => 0,
              
              :options   => [
              1,
              
              ],
            },
            3 => {
              :max_level => 15,
              
              :level  => 0,
              
              :options   => [
              2,
              
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

	        :conquerable => false,
	        :destroyable => false,



          :building_slots => {
            0 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              3,
              
              ],
            },
            1 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              4,
              5,
              
              ],
            },
            2 => {
              :max_level => 20,
              
              :building  => 5,
              
              :level  => 1,
              
              :options   => [
              4,
              5,
              
              ],
            },
            3 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              4,
              5,
              
              ],
            },
            4 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              4,
              5,
              
              ],
            },
            5 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            6 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            7 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            8 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            9 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            10 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            11 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            12 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            13 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            14 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            15 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            16 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            17 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            18 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            19 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            20 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            21 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            22 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            23 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            24 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            25 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            26 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            27 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            28 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            29 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            30 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            31 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            32 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            33 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            34 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            35 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            36 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            37 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            38 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            39 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            40 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            
          },



        },              #   END OF Heimatstadt
        {               #   Lagerstätte
          :id          => 3, 
          :symbolic_id => :settlement_outpost,
          :name        => {
            
            :de_DE => "Lagerstätte",
  
            :en_US => "Camp",
                
          },
          :description => {
            
            :de_DE => "Außenlager eines Stammes.",
  
            :en_US => "a small encampment of a tribe.",
                
          },

	        :conquerable => true,
	        :destroyable => true,



          :building_slots => {
            0 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              3,
              
              ],
            },
            1 => {
              :max_level => 20,
              
              :building  => 26,
              
              :level  => 1,
              
              :options   => [
              4,
              5,
              
              ],
            },
            2 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              4,
              5,
              
              ],
            },
            3 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              
              ],
            },
            4 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              
              ],
            },
            5 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              
              ],
            },
            6 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              
              ],
            },
            7 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              
              ],
            },
            8 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              
              ],
            },
            9 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              
              ],
            },
            10 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              
              ],
            },
            11 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              
              ],
            },
            12 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              
              ],
            },
            
          },



        },              #   END OF Lagerstätte
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
          :base_slots  => 2,
          :name        => {
            
            :en_US => "Construction of Buildings",
  
            :de_DE => "Gebäudeproduktion",
                
          },
          :produces    => [
            0,
            1,
            2,
            4,
            5,
            6,
            
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
          :base_slots  => 2,
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
          :base_slots  => 1,
          :name        => {
            
            :en_US => "Training of Infantry",
  
            :de_DE => "Infanterieausbildung",
                
          },
          :produces    => [
            0,
            
          ],
        },              #   END OF queue_infantry
        {               #   queue_artillery
          :id          => 3, 
          :symbolic_id => :queue_artillery,
          :unlock_field=> :settlement_queue_artillery_unlock_count,
          :category_id => 1,
					:category    => :queue_category_training,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 1,
          :name        => {
            
            :en_US => "Training of Artillery",
  
            :de_DE => "Ausbildung von Fernkämpfern",
                
          },
          :produces    => [
            2,
            
          ],
        },              #   END OF queue_artillery
        {               #   queue_cavalry
          :id          => 4, 
          :symbolic_id => :queue_cavalry,
          :unlock_field=> :settlement_queue_cavalry_unlock_count,
          :category_id => 1,
					:category    => :queue_category_training,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 1,
          :name        => {
            
            :en_US => "Training of Cavalry",
  
            :de_DE => "Ausbildung von berittenen Einheiten",
                
          },
          :produces    => [
            1,
            
          ],
        },              #   END OF queue_cavalry
        {               #   queue_siege
          :id          => 5, 
          :symbolic_id => :queue_siege,
          :unlock_field=> :settlement_queue_siege_unlock_count,
          :category_id => 1,
					:category    => :queue_category_training,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 1,
          :name        => {
            
            :en_US => "Training of Siege",
  
            :de_DE => "Bau von Belagerungsgeräten",
                
          },
          :produces    => [
            3,
            
          ],
        },              #   END OF queue_siege
        {               #   queue_special
          :id          => 6, 
          :symbolic_id => :queue_special,
          :unlock_field=> :settlement_queue_special_unlock_count,
          :category_id => 1,
					:category    => :queue_category_training,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 1,
          :name        => {
            
            :en_US => "Training of Special Units",
  
            :de_DE => "Bau von Spezialeinheiten",
                
          },
          :produces    => [
            4,
            
          ],
        },              #   END OF queue_special
        {               #   queue_research
          :id          => 7, 
          :symbolic_id => :queue_research,
          :unlock_field=> :character_queue_research_unlock_count,
          :category_id => 2,
					:category    => :queue_category_research,
          :domain      => :character,
          :base_threads=> 1,
          :base_slots  => 2,
          :name        => {
            
            :en_US => "Forschung",
  
            :de_DE => "Research",
                
          },
          :produces    => [
            1,
            
          ],
        },              #   END OF queue_research
        {               #   queue_alliance_research
          :id          => 8, 
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

        :character_ranks => {
          
# ## MUNDANE CHARACTER RANKS #################################################
      :skill_points_per_mundane_rank => 5,
  
      :mundane => [  # ALL MUNDANE CHARACTER RANKS

        {              #  0
          :id          => 0, 
          :exp         => 0,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Fellflohdompteur",
  
            :en_US => "Newbie",
                
          },
        },             #   END OF 
        {              #  1
          :id          => 1, 
          :exp         => 2000,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Steinzeitrattenkuschler",
  
            :en_US => "Newbie",
                
          },
        },             #   END OF 
        {              #  2
          :id          => 2, 
          :exp         => 5000,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Unter-Steinzeitrattenkuschler",
  
            :en_US => "Feeble Leader",
                
          },
        },             #   END OF 
        {              #  3
          :id          => 3, 
          :exp         => 9500,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Ober-Steinzeitrattenkuschler",
  
            :en_US => "Junior Leader",
                
          },
        },             #   END OF 
        {              #  4
          :id          => 4, 
          :exp         => 16200,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Steinzeitrattenkuschler",
  
            :en_US => "Leader",
                
          },
        },             #   END OF 
        {              #  5
          :id          => 5, 
          :exp         => 25750,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Mähnenwolfschmuser",
  
            :en_US => "Known Leader",
                
          },
        },             #   END OF 
        {              #  6
          :id          => 6, 
          :exp         => 38250,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Unter-Mähnenwolfschmuser",
  
            :en_US => "Great Leader",
                
          },
        },             #   END OF 
        {              #  7
          :id          => 7, 
          :exp         => 54250,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Ober-Mähnenwolfschmuser",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  8
          :id          => 8, 
          :exp         => 74250,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Mähnenwolfschmuser",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  9
          :id          => 9, 
          :exp         => 98750,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Urschweinbesänftiger",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  10
          :id          => 10, 
          :exp         => 128250,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Unter-Urschweinbesänftiger",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  11
          :id          => 11, 
          :exp         => 163250,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Ober-Urschweinbesänftiger",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  12
          :id          => 12, 
          :exp         => 204250,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Urschweinbesänftiger",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  13
          :id          => 13, 
          :exp         => 251750,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Wildpferdflüsterer",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  14
          :id          => 14, 
          :exp         => 306000,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Unter-Wildpferdflüsterer",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  15
          :id          => 15, 
          :exp         => 367500,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Ober-Wildpferdflüsterer",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  16
          :id          => 16, 
          :exp         => 436750,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Wildpferdflüsterer",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  17
          :id          => 17, 
          :exp         => 514000,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Wollnashornknuddler",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  18
          :id          => 18, 
          :exp         => 599500,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Unter-Wollnashornknuddler",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  19
          :id          => 19, 
          :exp         => 693500,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Ober-Wollnashornknuddler",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  20
          :id          => 20, 
          :exp         => 796250,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Wollnashornknuddler",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  21
          :id          => 21, 
          :exp         => 907250,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Steppenwisentliebkoser",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  22
          :id          => 22, 
          :exp         => 1028250,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Unter-Steppenwisentliebkoser",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  23
          :id          => 23, 
          :exp         => 1157750,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Ober-Steppenwisentliebkoser",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  24
          :id          => 24, 
          :exp         => 1296250,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Steppenwisentliebkoser",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  25
          :id          => 25, 
          :exp         => 1443500,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Riesenhirschtätschler",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  26
          :id          => 26, 
          :exp         => 1599500,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Unter-Riesenhirschtätschler",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  27
          :id          => 27, 
          :exp         => 1764000,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Ober-Riesenhirschtätschler",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  28
          :id          => 28, 
          :exp         => 1936750,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Riesenhirschtätschler",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  29
          :id          => 29, 
          :exp         => 2117250,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Säbelzahntigerbändiger",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  30
          :id          => 30, 
          :exp         => 2305250,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Unter-Säbelzahntigerbändiger",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  31
          :id          => 31, 
          :exp         => 2500250,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Ober-Säbelzahntigerbändiger",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  32
          :id          => 32, 
          :exp         => 2701750,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Säbelzahntigerbändiger",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  33
          :id          => 33, 
          :exp         => 2909250,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Mammuttreiber",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  34
          :id          => 34, 
          :exp         => 3122250,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Unter-Mammuttreiber",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  35
          :id          => 35, 
          :exp         => 3340000,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Ober-Mammuttreiber",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  36
          :id          => 36, 
          :exp         => 3562000,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Mammuttreiber",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  37
          :id          => 37, 
          :exp         => 3787500,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Dinosaurierdressierer",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  38
          :id          => 38, 
          :exp         => 4016000,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Unter-Dinosaurierdressierer",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  39
          :id          => 39, 
          :exp         => 4246750,
          :settlement_points   => 0,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Unter-Ober-Dinosaurierdressierer",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
        {              #  40
          :id          => 40, 
          :exp         => 4479250,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Ober-Dinosaurierdressierer",
  
            :en_US => "Fantastic Leader",
                
          },
        },             #   END OF 
      ],             # END OF MUNDANE CHARACTER RANKS

# ## SACRED CHARACTER RANKS ##################################################
      :skill_points_per_sacred_rank => 5,
  
      :sacred => [   # ALL SACRED CHARACTER RANKS

        {              #  0
          :id          => 0, 
          :name        => {
            
            :de_DE => "Unerkannt",
  
            :en_US => "Unrecognized",
                
          },
        },             #   END OF 
        {              #  1
          :id          => 1, 
          :name        => {
            
            :de_DE => "Weitgehend ignoriert",
  
            :en_US => "Almost always ignored",
                
          },
        },             #   END OF 
      ],             # END OF SACRED CHARACTER RANKS

        },
  
    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts GameRules::Rules.the_rules.to_json
#GameRules.rules.unit_types.each do |value| 
#  puts value[:name][:de_DE] 
#end

