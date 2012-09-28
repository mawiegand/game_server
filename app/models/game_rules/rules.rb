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

  attr_accessor :version, :battle, :character_creation, :building_conversion, :resource_types, :unit_types, :building_types, :science_types, :unit_categories, :building_categories, :queue_types, :settlement_types, :construction_speedup, :training_speedup, :character_ranks
  
  def attributes 
    { 
      'version'              => version,
      'battle'               => battle,
      'character_creation'   => character_creation,
      'construction_speedup' => construction_speedup,
      'training_speedup'     => training_speedup,
      'building_conversion'  => building_conversion,
      'unit_categories'      => unit_categories,
      'building_categories'  => building_categories,
      'unit_types'           => unit_types,
      'resource_types'       => resource_types,
      'building_types'       => building_types,
      'science_types'        => science_types,  
      'settlement_types'     => settlement_types,  
      'queue_types'          => queue_types,  
      'character_ranks'      => character_ranks,  
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
            1 => 150,
            0 => 150,
            2 => 100,
            3 => 0,
            
          },
        },
        :building_conversion => {
          :cost_factor => 0.3,
          :time_factor => 0.3,
        },
  
# ## CONSTRUCTION SPEEDUP ####################################################
  
      :construction_speedup => [  # ALL CONSTRUCTION SPEEDUPS

        {               #   less than 1 hours
          :resource_id => 3, 
          :amount      => 1,
          :hours     => 1,
        },              #   END OF 1 hours

        {               #   less than 4 hours
          :resource_id => 3, 
          :amount      => 2,
          :hours     => 4,
        },              #   END OF 4 hours

        {               #   less than 10 hours
          :resource_id => 3, 
          :amount      => 4,
          :hours     => 10,
        },              #   END OF 10 hours

        {               #   less than 24 hours
          :resource_id => 3, 
          :amount      => 8,
          :hours     => 24,
        },              #   END OF 24 hours

        {               #   less than 48 hours
          :resource_id => 3, 
          :amount      => 12,
          :hours     => 48,
        },              #   END OF 48 hours

        {               #   less than 96 hours
          :resource_id => 3, 
          :amount      => 20,
          :hours     => 96,
        },              #   END OF 96 hours

        {               #   less than 9999 hours
          :resource_id => 3, 
          :amount      => 30,
          :hours     => 9999,
        },              #   END OF 9999 hours

      ],                # END OF CONSTRUCTION SPEEDUP

# ## TRAINING SPEEDUP ##########################################################
  
      :training_speedup => [  # ALL TRAINING SPEEDUPS

        {               #   less than 6 hours
          :resource_id => 3, 
          :amount      => 1,
          :hours     => 6,
        },              #   END OF 6 hours

        {               #   less than 12 hours
          :resource_id => 3, 
          :amount      => 2,
          :hours     => 12,
        },              #   END OF 12 hours

        {               #   less than 24 hours
          :resource_id => 3, 
          :amount      => 3,
          :hours     => 24,
        },              #   END OF 24 hours

        {               #   less than 48 hours
          :resource_id => 3, 
          :amount      => 4,
          :hours     => 48,
        },              #   END OF 48 hours

        {               #   less than 96 hours
          :resource_id => 3, 
          :amount      => 5,
          :hours     => 96,
        },              #   END OF 96 hours

        {               #   less than 192 hours
          :resource_id => 3, 
          :amount      => 6,
          :hours     => 192,
        },              #   END OF 192 hours

        {               #   less than 480 hours
          :resource_id => 3, 
          :amount      => 10,
          :hours     => 480,
        },              #   END OF 480 hours

        {               #   less than 9999 hours
          :resource_id => 3, 
          :amount      => 15,
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
            
            :de_DE => "<p>Holz war bereits in der Steinzeit in allen Varianten verfügbar: Nadelholz, Laubholz, Kantholz und natürlich Brettholz. Als Rohtoff spielt Holz eine wichtige Rolle bei der Konstruktion von Gebäuden und Belagerungswaffe.</p>",
  
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
            
            :de_DE => "<p>Hällt warm, hällt Wasser ab, verhängt Löcher und taugt im Notfall auch als rudimentäre Dachbedeckung.</p>",
  
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
            
            :de_DE => "<p>Quasi-Wärhung in der Steinzeit. Gerne genommen in jeglichen Tauschhandeln.</p>",
  
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
  
            :de_DE => "<p> Eine Keule in der Hand und immer an vorderster Front. Keulenkrieger brauchen nicht viel für ein glückliches Leben. Zudem ist dieses meist sehr kurz. </p>",
                
          },
          :description => {
            
            :de_DE => "<p>Keulenkrieger sind der Grundbestanteil jeder Armee. Sie stehen an der Front und beschützen die Fernkämpfer vor der Kavallerie. Keulenkrieger sind zähe Burschen und nur schwer klein zu kriegen, allerdings finden sie nur zu oft den Tod durch feindlichen Fernkämpfer.</p>",
  
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

          :production_time => '300',

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
  
            :de_DE => "<p> Nach ein paar Schlachten hat sich bei den Keulenkriegern eine dicke Haut gebildet, wodurch sie noch länger aufeinander einhauen können. </p>",
                
          },
          :description => {
            
            :de_DE => "<p> Die dicke Haut beschützt sie zwar vor Keulenschlägen, aber die spitzen Steine der Fernkämpfer hält sie nicht ab. Dafür tut es weniger weh, wenn man von einem Straußen überrannt wird.</p>",
  
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

          :production_time => '400',

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

              :min_level => 5,

            },

            {
              :symbolic_id => 'building_fortress_main',
              :id => 0,
              :type => '',

              :min_level => 5,

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
  
            :de_DE => "<p> Sehr wenige Keulenkrieger überleben ihre ersten Schlachten, fast keiner überlebt einen Krieg. Das viele Bier, das sie vor den Schlachten trinken, verschafft ihnen ein noch stärkeres Durchhaltevermögen. </p>",
                
          },
          :description => {
            
            :de_DE => "<p>Manche Keulenkrieger tauchen sogar mit ihrem Bierfaß auf dem Schlachtfeld auf, gibt es doch nichts besseres als ein paar Krüge vor und nach der Schlacht. Allein schon der Gestank schreckt Straußen und andere Reittiere ab, aber Steine und Speere finden weiterhin ein einfaches Ziel, nur ab und zu geht ein Schuß ins leere, wenn der Keulenkrieger über das Schlachtfeld wankt.</p>",
  
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

          :production_time => '600',

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

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_fortress_main',
              :id => 0,
              :type => '',

              :min_level => 10,

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
  
            :de_DE => "<p>Wozu den Baum zu einer Keule verarbeiten, wenn man einfach den ganzen Baum schwingen kann.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Groß, stark, sauber rasierter Bart. Ein Baum-Brutalo legt sehr großen Wert auf sein Äußeres.</p><p>In der Schlacht bietet der Baum-Brutalo ein seltsames Schauspiel. Umhüllt von den rauschen Blättern seines Kampfbaumes wirbelt der Baum-Brutalo durch die gegnerischen Reihen wie ein Säberlzahntiger, der sich den Schwanz geklammt hat. Nicht den flauschigen, den anderen...</p><p> Kein Feind kann einen Baum-Brutalo erreichen, wenn er erst einmal in Fahrt gekommen ist. Da bleibt nur wegrennen und hoffen, dass ihm irgendwann die Puste ausgeht, oder er von Steinen und Speeren gespickt zu Boden geht.</p>",
  
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

          :production_time => '900',

          :costs      => {
            0 => '140',
            1 => '180',
            2 => '240',
            
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
              :symbolic_id => 'building_fortress_main',
              :id => 0,
              :type => '',

              :min_level => 15,

            },

            ],

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
  
            :de_DE => "<p> Diese Fernkämpfer könnten eine Zielscheibe nicht aus 10 Meter Entfernung treffen, aber zum Glück sind Infanterieabteilungen meist viel größer als Zielscheiben. </p>",
                
          },
          :description => {
            
            :de_DE => "<p>Große Steine, kleine Steine, ein Kieselsteinwerfer mag sie alle, solange er sie jemandem an den Kopf werfen kann. Ok, zugegeben, die kleinen mag er ein bisschen lieber. Nichtsdestotrotz kann er moderaten kritischen Schaden zufügen - denn, wie jeder weiß, das kann auch ins Auge gehen.</p><p> Die größte Furcht eines Kieselsteinwerfers ist eine anstürmende Horde Straußenreiter, denn diese überrennen einfach alles was ihnen in den Weg kommt.</p>",
  
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

          :production_time => '450',

          :costs      => {
            0 => '35',
            1 => '35',
            2 => '50',
            
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
  
            :de_DE => "<p> Einen Stein auf 50 Meter Entfernung genau auf ein Ziel zu werfen ist eine beeindruckende Leistung. Dummerweise stehen die Gegner meistens weiter weg. </p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein sicherer Wurf führt zu besseren Treffern. Nicht dass der Unterschied bemerkbar wäre, meistens ist eh genug Infanterie da, sodass zielen unnötig wird, aber es führt doch zu ein oder zwei kritischen Treffern.</p><p> Ein bewegliches Ziel zu treffen, wie zum Beispiel einen Straußenreiter, ist eine große Leistung und derjenige, dem es gelingt, wird von seinen Kollegen sehr geschätzt... wenn er es überlebt.</p>",
  
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

          :production_time => '525',

          :costs      => {
            0 => '45',
            1 => '45',
            2 => '60',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_artillery_tower',
              :id => 2,
              :type => 'building',

              :min_level => 5,

            },

            {
              :symbolic_id => 'building_fortress_main',
              :id => 0,
              :type => '',

              :min_level => 5,

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
  
            :de_DE => "<p>Je größer der Stein, desto mehr tut es weh. Das meinen zumindest die Steinschleuderer und versuchen mit immer größeren Steinen nach ihren Gegnern zu werfen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p> Große Steine tuen tatsächlich mehr weh, auch wenn die Steinschleuderer die gleichen Schwächen, wie ihre kieselsteinwerfenden Kollegen haben. </p>",
  
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

          :production_time => '750',

          :costs      => {
            0 => '90',
            1 => '90',
            2 => '120',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_artillery_tower',
              :id => 2,
              :type => 'building',

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_fortress_main',
              :id => 0,
              :type => '',

              :min_level => 10,

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
  
            :de_DE => "<p> Wieso jemand einen Stock an einen Stein gebunden hat, ist unverständlich, sind Steine doch schon hervorragende Wurfgeschosse. Aber der Effekt ist großartig, größere Reichweite, zielgenauer und einfacher einzusammeln, was will man mehr. </p>",
                
          },
          :description => {
            
            :de_DE => "<p> Theoretisch ist ein Speer auch im Nahkampf, vor allem gegen Reiter, effektiv, aber die Speerschleuderer kommen erst gar nicht darauf ihn so einzusetzen, sie versuchen weiterhin alle ihre Speere zu werfen auch wenn es kaum von Speeren getötete Reiter gibt. Den ein oder anderen mit Speeren gespickten Straußen gibt es allerdings doch, denn ein guter Speertreffer fügt wirklich tiefe Wunden zu. </p>",
  
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

          :production_time => '950',

          :costs      => {
            0 => '180',
            1 => '180',
            2 => '240',
            
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
              :symbolic_id => 'building_fortress_main',
              :id => 0,
              :type => '',

              :min_level => 15,

            },

            ],

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
  
            :de_DE => "<p> Zweihändige Straußenreiter werden so genannt, weil sie beide Hände brauchen, um sich an ihrem Straußen festzuklammern. Sie sind trotzdem effektiv, denn Strauße haben zwar keine großen Klauen oder Fangzähne, aber ihr Schnabel ist ziemlich spitz. </p>",
                
          },
          :description => {
            
            :de_DE => "<p> Strauße sind nicht nur lecker sondern auch gute und schnelle Reittiere. Straußenreiter sind die Furcht jedes Fernkämpfers. Schnell genug um an der Infanterie vorbeizukommen und bleibt ihren Gegnern nur zu hoffen, dass die Sträuße den Kopf in den Sand stecken oder der Reiter von seinem Strauß fällt, auch wenn das meist wenig Unterschied macht. </p>",
  
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

          :production_time => '350',

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
  
            :de_DE => "<p> Mit etwas Übung schafft der erfahrene Reiter auch sich mit einer Hand festzuhalten, und so die andere für sinnvollere Tätigkeiten freizuhaben. Wie zum Beispiel seinen Feinden den Schädel einzuhauen. </p>",
                
          },
          :description => {
            
            :de_DE => "<p> Mit einer Keule in der freien Hand sind einhändige Straußenreiter natürlich effektiver im Angriff. Vor allem die Fernkämpfer fliehen meist beim Anblick einer Horde Straußenreiter. Im Kampf gegen Keulenkrieger ziehen sie allerdings den Kürzeren, da sie nur eine kleine, nicht so schwere Keule bei sich führen. </p>",
  
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

          :production_time => '450',

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

              :min_level => 5,

            },

            {
              :symbolic_id => 'building_fortress_main',
              :id => 0,
              :type => '',

              :min_level => 5,

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
  
            :de_DE => "<p> Besonders talentierte Reiter brüsten sich damit, freihändig reiten zu können. Wozu sie die zusätzliche Hand brauchen, da sie die Keule nur mit einer führen, können sie allerdings auch nicht sagen. </p>",
                
          },
          :description => {
            
            :de_DE => "<p> Auf blitzschnelle Angriffe spezialisiert, bleiben diese Reiter nie lange auf einem Fleck. Sie reiten durch die Gegnerreihen und führen präzise Schläge aus, die besonders Feinde mit schwachem Durchhaltevermögen, wie Kieselsteinwerfer, einfach umhauen. Da sie durch Keulenkriegerlinien nicht hindurchreiten können, vermeiden sie diese. Denn ein stehender Strauß ist ein toter Strauß. </p>",
  
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

          :production_time => '675',

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

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_fortress_main',
              :id => 0,
              :type => '',

              :min_level => 10,

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
  
            :de_DE => "<p> Der Traum eines jeden Reiters, der riesige Dino nimmt ihm die ganze Arbeit ab. Aber nach der Schlacht bleibt man besser im Sattel, bis der Dino sich beruhigt hat. </p>",
                
          },
          :description => {
            
            :de_DE => "<p> Der riesige Dino trampelt seine Feinde um, fegt sie mit dem Schwanz weg und ist so stark gepanzert, dass ihm Geschosse nichts anhaben können. Keulenkrieger mag der Dino gar nicht, hauen die fiesen Kerle ihm doch immer auf die Zehen, seine empfindsamste Stelle. </p>",
  
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

          :production_time => '950',

          :costs      => {
            0 => '160',
            1 => '140',
            2 => '200',
            
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
              :symbolic_id => 'building_fortress_main',
              :id => 0,
              :type => '',

              :min_level => 15,

            },

            ],

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
        {               #   Battering Ram
          :id          => 12, 
          :symbolic_id => :ram,
					:category    => 3,
          :db_field    => :unit_ram,
          :name        => {
            
            :en_US => "Battering Ram",
  
            :de_DE => "Rammbock",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Nur wenige wissen, dass der Name Rammbock von einem prähistorischen Tier aus der Unterfamilie der ziegenartigen (caprinae) abstammt.</p>",
  
            :en_US => "<p>The battering ram is the lockpick of choice to open doors, gates and cracking down fortifications.</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 0.2,
  
            :unitcategory_cavalry => 0.1,
  
            :unitcategory_artillery => 0.2,
  
            :unitcategory_siege => 1,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,

          :production_time => '300',

          :costs      => {
            0 => '2',
            1 => '10',
            2 => '4',
            
          },


        },              #   END OF Battering Ram
        {               #   Catapult
          :id          => 13, 
          :symbolic_id => :catapult,
					:category    => 3,
          :db_field    => :unit_catapult,
          :name        => {
            
            :en_US => "Catapult",
  
            :de_DE => "Katapult",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Das Basismodell 'Catabilly' zum selber zusammenbauen, unschlagbar günstig.</p>",
  
            :en_US => "<p>The catapults take the cake in every intense battle because of their devastating damage.</p>",
                
          },

          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 0.2,
  
            :unitcategory_cavalry => 0.1,
  
            :unitcategory_artillery => 0.2,
  
            :unitcategory_siege => 1,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,

          :production_time => '300',

          :costs      => {
            0 => '2',
            1 => '10',
            2 => '4',
            
          },

          :requirementGroups=> [
            [
              
            {
              :symbolic_id => 'building_workshop',
              :id => 0,
              :type => '',

              :min_level => 11,

            },

            ]
          ],          


        },              #   END OF Catapult
        {               #   Neanderthal
          :id          => 14, 
          :symbolic_id => :neanderthal,
					:category    => 0,
          :db_field    => :unit_neanderthal,
          :name        => {
            
            :en_US => "Neanderthal",
  
            :de_DE => "Neandertaler",
                
          },
          :flavour     => {
            
            :en_US => "<p>Don't talk, fight.</p>",
  
            :de_DE => "<p>Reden nicht, handeln. Äh, schlagen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Wilder Vormenschenstamm.</p>",
  
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
          :armor       => 4,
          :hitpoints   => 90,

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

            ]
          ],          


        },              #   END OF Neanderthal
        {               #   Little Chief
          :id          => 15, 
          :symbolic_id => :little_chief,
					:category    => 4,
          :db_field    => :unit_little_chief,
          :name        => {
            
            :en_US => "Little Chief",
  
            :de_DE => "Kleiner Häuptling",
                
          },
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Noch keine Funktion. Zwar kein richtiger Häuptling, aber führt immerhin eine Lagerstätte an.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kleine Häuptlinge haben ihr eigenes Lager, dass sie für den Häuptling führen.</p>",
  
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

          :production_time => '7200',

          :costs      => {
            0 => '3000',
            1 => '3000',
            2 => '1500',
            
          },

          :requirementGroups=> [
            [
              
            {
              :symbolic_id => 'building_campfire',
              :id => 9,
              :type => 'building',

              :min_level => 10,

            },

            ]
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
            
            :de_DE => "<p>Ein paar aufgetürmte Steinbrocken, zusammengebundene Baumstämme, ein provisorisches Tor. Fertig ist die Festung. Die Festungsanlagen bestehen aus einen Hauptgebäude, einem kleinen Versammlungsplatz und Mauern zur Verteidigung.</p><p>In der Sicherheit der Festung bauen die Arbeiter schneller und Krieger werden schneller ausgebildet.</p><p>Je größer die Festung wird, desto besser sind auch die Verteidigungsanlagen und Unterkünfte.</p>",
  
            :en_US => "<p>Some debris, tied tree trunks, a provisional gate, small parade-ground, main building and some walls; rudimentary stronghold finished. Improving the fortification results in a higher maximum size of the garrison, speeding-up all other construction sites and increases the defensive abilities.</p>",
                
          },
          :hidden      => 0,

	        :population  => "2.5*POW(LEVEL,2)-2.5*LEVEL+5",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,

          :costs      => {
            0 => 'FLOOR(30*POW(LEVEL,2.95)*(10*POW(LEVEL,-0.7))+0.5)',
            1 => 'FLOOR(30*POW(LEVEL,2.95)*(10*POW(LEVEL,-0.7))+0.5)',
            2 => 'FLOOR(((MIN(LEVEL,3)-MIN(LEVEL,2))*30*POW(LEVEL,2.95))*0.5*(10*POW(LEVEL,-0.7))+0.5)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(293.33*POW(LEVEL,3)-1760*POW(LEVEL,2)+3286.7*LEVEL-1760)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(6*POW(LEVEL,4.3)+250*LEVEL))*(10*POW(LEVEL,-0.7))+0.5)',
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
            
            :de_DE => "<p>Im Turm der Infanterie werden die Nahkämpfer in der Kunst des Kampfes unterwiesen. Der überaus sadistische Ausbilder legt höchsten Wert auf Gehorsam und Disziplin.</p><p>Wer den Befehlen nicht gehorcht, oder sich im Training noch dümmer anstellt als die anderen, der muss im Turm der Reitmeisterei putzen. Wer es zurück schafft, kämpft anschließend mit deutlich größerem Elan.</p>",
  
            :en_US => "<p>Training center for close combat warriors. Without the infantry every army becomes useless - and this is the place where the backbone of every stone-aged and postmodern army composition gets finishing. Reckless. Ruthless. Relentless.</p>",
                
          },
          :hidden      => 0,

	        :population  => "2.5*POW(LEVEL,2)-2.5*LEVEL+5",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [
            [
              
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 2,

            },

            ]
          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*3+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*1.5+0.5)',
            2 => '(MIN(LEVEL,3)-MIN(LEVEL,3))*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*0.25+0.5)',
            3 => 'MAX(LEVEL-14,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*3+0.5)',
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
  
            :de_DE => "<p>Hier fliegt alles was man werfen oder abschießen kann! Kopf runter! Die Ausbildung der Fernkämpfer ist in vollem Gang.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Von Außen betrachtet ist der Turm der Ballistik eine Augenweide. Von Innen betrachtet ist der Turm ein Trümmerfeld. Kleine Kieselsteine liegen auf dem ganzen Boden verteilt, Bratspieße, Speere und Pfeile haben sich in sämtliche Stützpfeiler gebort und an den Wänden spuren hinterlassen.</p><p>Nicht weiter verwunderlich ist da die Helmpflicht. Die Ausbilder und Auszubildende haben sich feste Tierhäute um den Kopf gebunden, damit sie den Aufprall kleiner Steinen oder Splittern halbwegs überstehen.</p><p> Verglichen mit der Ordnung einer Artillerie-Kampfreihe auf dem Schlachtfeld ist das herrschende Chaos überraschend. Auf ein Kommando werden alle Arten von Wurfgeschossen in die Luft gesandt, nur leider wissen die Wenigsten auf welches Kommando sie eigentlich gerade achten sollen.</p>",
  
            :en_US => "<p>Trains artillery.</p>",
                
          },
          :hidden      => 0,

	        :population  => "2.5*POW(LEVEL,2)-2.5*LEVEL+5",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [
            [
              
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 4,

            },

            ]
          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*3+0.5)',
            2 => '(MIN(LEVEL,3)-MIN(LEVEL,3))*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*0.25+0.5)',
            3 => 'MAX(LEVEL-14,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*3+0.5)',
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
        {               #   Turm der Reitmeisterrei
          :id          => 3, 
          :symbolic_id => :building_cavalry_tower,
					:category    => 1,
          :db_field    => :building_cavalry_tower,
          :name        => {
            
            :de_DE => "Turm der Reitmeisterrei",
  
            :en_US => "Cavalry Tower",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Hier sind Unmengen an Tieren und verschwitzten Männern untergebracht. Vorsicht vor Dung und penetrantem Geruch!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Turm der Reitmeisterei dient zur Ausbildung aller berittenen Einheiten. Dabei wird der Wert vor allem auf den Umgang mit den Tieren wie auch die Reittechnik gelegt.</p><p>Der Zutritt ist streng begrenzt auf ausgebildete Reiter und Tierpfleger. Wenn das Tor der Reitmeisterei kurzzweitig offen steht, schleichen sich oftmals neugierige halbstarke Jungs hinein. Die Tierpfleger entsorgen die blutige Kleidung ohne großes Aufhebens.</p>",
  
            :en_US => "<p>Training center for all mounted units. Horse-back riding is not vanilla, so, 101-riding courses, how to put spur on horses and domesticating them; all this is done here.</p><p>Access is only granted to equestrians and zookeepers.</p>",
                
          },
          :hidden      => 0,

	        :population  => "2.5*POW(LEVEL,2)-2.5*LEVEL+5",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [
            [
              
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 6,

            },

            ]
          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*3+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*1.5+0.5)',
            2 => '(MIN(LEVEL,3)-MIN(LEVEL,3))*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*0.25+0.5)',
            3 => 'MAX(LEVEL-14,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*3+0.5)',
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

        },              #   END OF Turm der Reitmeisterrei
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
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*1+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*MAX((MIN(LEVEL+1,3)-MIN(LEVEL,3))*5.6+(3-LEVEL*0.3),1.2)*2+0.5)',
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
  
            :de_DE => "<p>Hier werden die Entscheidungen getroffen! Je größer die Häuptlingshütte desto größer und vielfältiger die Siedlung und die Anzahl der Armeen, die ins Feld geführt werden können.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Häuptlingshütte spiegelt die Größe des Dorfes wieder. Jede Erweiterung der Häuptlingshütte ermöglicht neue Arten und eine größere Anzahl von Gebäuden zu bauen.
Hinter der Häuptlingshütte ist ein kleiner Lagerplatz, auf dem Rohstoffe zwischengelagert werden können, so lange es kein Lager gibt.</p><p>Außerdem ermöglicht die Häuptlingshütte Armeen aufzustellen.</p><p>Eine prunkvolle, mit Trophäen der Feinde geschmückte Hütte verringert die Moral möglicher Angreifer und erhöht die Moral der Verteidiger.</p>",
  
            :en_US => "<p>At start it is more a hut or but later an area to represent the chieftain‘s glory, advancement and power.</p><p>Symbols of triumph, the banners and iconic loot is shown off here. Rumor has it that the chieftain uses his hall for excessive orgies from time to time!</p>",
                
          },
          :hidden      => 0,

	        :population  => "1+MIN(MAX(LEVEL-3,0),1)+MIN(MAX(LEVEL-6,0),1)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,

          :requirementGroups=> [
            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ]
          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1+0.5)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*4+0.5)',
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
                :formula            => "(MIN(LEVEL+1,6)-MIN(LEVEL,6))*(25*POW(LEVEL,2)-25*LEVEL+600)+(MIN(LEVEL,6)-MIN(LEVEL,5))*(307.14*POW((LEVEL-5),2)-212.86*(LEVEL-5)+1400)",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "(MIN(LEVEL+1,6)-MIN(LEVEL,6))*(25*POW(LEVEL,2)-25*LEVEL+600)+(MIN(LEVEL,6)-MIN(LEVEL,5))*(307.14*POW((LEVEL-5),2)-212.86*(LEVEL-5)+1400)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "(MIN(LEVEL+1,6)-MIN(LEVEL,6))*(25*POW(LEVEL,2)-25*LEVEL+600)+(MIN(LEVEL,6)-MIN(LEVEL,5))*(307.14*POW((LEVEL-5),2)-212.86*(LEVEL-5)+1400)*0.5",
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
  
            :de_DE => "<p>Sammelt für Dich Holz und Steine, und wenn sein Gelände weit genug ausgebaut wird, findet er sogar hin und wieder eine Kröte auf seinem Gelände, die zu langsam für seine schwerfälligen Füße ist.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Primitivster aller Steinzeiteinwohner. Ihr könnt frohe sein, ihn in eine Hütte bekommen zu haben. Manchmal bleibt er sogar für ein paar Stunden da.</p><p>Jedenfalls sammelt und jagt er alles, was ihm for die Flinte, äh, die Steinschleuder kommt. Auf seinem Gelände können die Stammesangehörigen alles finden, was sie zur Abdeckungen des täglichen Bedarfs benötigen; er findet alles von Knochen und Steinen über Wurzeln bis hin zu Kröten (natürlich nur bei ausreichend großem Gelände).</p>",
  
            :en_US => "<p>Hunting and gathering everything useful which comes in sight and is accordingly the collector of basic resources for the daily needs. He comes home with wood, stones and easily slain animals.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [
            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 1,

            },

            ]
          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.33+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.33+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.166+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*0.33+0.5)',
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
  
            :de_DE => "<p>In den kleinen Hütten leben Eure Untertanen. Je mehr Untertanen desto schneller geht auch der Ausbau von Gebäuden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Je mehr Untertanen, desto schneller können Gebäude gebaut werden.</p><p>Doch irgendwo müssen eure Arbeiter unterkommen. Die kleine Hütte schützt eure Untertanen vor Sonne und Regen. Solange ihr alles habt, brauchen eure Untertanen natürlich auch nicht mehr.</p>",
  
            :en_US => "<p>Provides shelter for your subjects. No-one is as demanding as you are, so your people only need basic fit-outs inside their own four walls.</p><p>Your grace and foreseeing leadership is fullfilling all their needs of luxury. The good old times!</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 2,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 3,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.75+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.125+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*1+0.5)',
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
            :target_level_formula  => "MAX(LEVEL,10)-9", 
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
  
            :de_DE => "<p>Auf der Suche nach einem kleinen Kampf, lange nicht mehr verprügelt worden? Im Ausbildungsgelände werden die Nahkämpfer ausgebildet, die Freund und Feind gerne mal eine verpassen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Auf dem Ausbildungsgelände werden alle Arten von Nahkämpfern ausgebildet. Große Keule, Bratspieß oder doch die bloßen Fäuste, alles ist erlaubt.</p><p>In zahlreichen Wettbewerben messen sich die kommenden Krieger um sich im Zweikampf zu stählen. Einmal im Mondumlauf wird ein öffentliches Turnier veranstaltet. Der Sieger bekommt alles. Ruhm, Essen, einen Tag frei und Männer soviel sie wollen. Ja Männer, denn zumeist gewinnt eine Frau diese Turnier. Wie? Mit den Waffen eine Frau natürlich, und die sind tödlich!</p>",
  
            :en_US => "<p>Training facility for all kinds of groud units and also hosts troops. It has its own drill ground and from to time to time you can see magnificient parades.</p><p>Don´t get mistaken for one of the punching dummies or you won´t leave the barracks alive! Training of beserkers is in progress.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 3,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 5,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*3+0.5)',
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
  
            :de_DE => "<p>Ort für Diplomatischer Austausch oder Allianzbesprechungen. Zu einer guten Unterhaltung gehören mindestens zwei. Auch wenn oft nur einer redet.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Das Lagerfeuer ist der Versammlungsort einer Siedlung und übernimmt in der Steinzeit auch die Rolle einer Botschaft.</p><p>Die freiwilligen und unfreiwilligen Gästen werden wahlweise ans Feuer gebeten oder am Marterfall aufgestellt.</p><p>Hier ist der Ort, um  Entsandte von benachbarten und weit entfernten Stämmen zu bewirten, Kontakte zu pflegen und die wichtigen Dinge zu besprechen. Hier ist aber auch der Ort, um an den gutgläubigen Entsandten oder eingefangenen Gegnern ein Exempel zu statuieren oder sie kurzerhand zu verspeisen.</p>",
  
            :en_US => "<p>Assembly area for the locals and also the district of foreign embassies. Random guests are normally invited to sit by the fire while hostile messengers get hammered at the stake.</p><p>The place to be in every settlement for networking and discussing the really important matters, like whether a stranger gets eaten alive or tickled to ecstasy.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,

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

            ]
          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*1+0.5)',
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
            
            :de_DE => "<p>Unter Ausnutzung purer Gewalt aber auch modernster Steinwerkzeuge gelingt es dem Holzfäller mehr oder weniger große Stämme zu fällen und zu wertvollen Rohstoffen zu verarbeiten.</p><p>Große Holzfäller lassen nur die kleinen Bäume übrig und reduzieren so die Frustration der kleineren Holzfäller.</p>",
  
            :en_US => "<p>Specialized in cutting trees more efficiently than the gatherer and produces logs. Is by definition permanently competing with the quarry man.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 5,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 2,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*1+0.5)',
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
            :target_level_formula  => "(MIN(LEVEL+1,11)-MIN(LEVEL,11))+(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(MAX(LEVEL,10)-9)+((MIN(LEVEL,11)-MIN(LEVEL,10))*4*(LEVEL-10)-1)*(MIN(LEVEL+1,13)-MIN(LEVEL,13))+(MIN(LEVEL,13)-MIN(LEVEL,12))*(LEVEL-3)-(MIN(LEVEL,18)-MIN(LEVEL,17))", 
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
  
            :de_DE => "<p>Steine, nichts als Steine! Verschwitzte Arbeiter und der montone Schlag der schweren Werkzeuge. Genau was man von einem Steinbruch erwartet.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Durch eine komplizierte Kette von Arbeitsvorgängen (kompliziert in der Steinzeit), werden im Steinbruch Steine gewonnen. Größere Steinbrüche produzieren mehr Steine pro Stunde. Unglaublich, oder?</p><p>Ein richtig großer Steinbruch treibt den Wettkampf unter den Steinbrechern an und sorgt so für schnelleren Abbau.</p>",
  
            :en_US => "<p>Specialized in rock cutting more efficiently than the gatherer and produces stones. It is still not clear, if lumberjacks and quarry men are akin to each other or not.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 5,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 1,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*1+0.5)',
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
            :target_level_formula  => "(MIN(LEVEL+1,11)-MIN(LEVEL,11))+(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(MAX(LEVEL,10)-9)+((MIN(LEVEL,11)-MIN(LEVEL,10))*4*(LEVEL-10)-1)*(MIN(LEVEL+1,13)-MIN(LEVEL,13))+(MIN(LEVEL,13)-MIN(LEVEL,12))*(LEVEL-3)-(MIN(LEVEL,18)-MIN(LEVEL,17))", 
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
            
            :de_DE => "<p>Verarbeitet Häute zu Leder und hat manchmal auch ein paar schöne Säbelzahntigerfelle für die Dame von Welt im Angebot.</p><p>Die Abfälle von großen Kürschnereien werden von kleineren Kürschnereien mit geringem Aufwand weiterverarbeitet.</p>",
  
            :en_US => "<p>Manufacturing hides into leather. Sometimes there are also must-have sabre cat furs as ready-to-wear fashion for the lady or cosy brontosaurus regulation underwear.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 8,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 6,

            },

            ],

          ],          

          :costs      => {
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5+0.5)',
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.25+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*1+0.5)',
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
            :target_level_formula  => "(MIN(LEVEL+1,11)-MIN(LEVEL,11))+(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(MAX(LEVEL,10)-9)+((MIN(LEVEL,11)-MIN(LEVEL,10))*4*(LEVEL-10)-1)*(MIN(LEVEL+1,13)-MIN(LEVEL,13))+(MIN(LEVEL,13)-MIN(LEVEL,12))*(LEVEL-3)-(MIN(LEVEL,18)-MIN(LEVEL,17))", 
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
  
            :de_DE => "<p>Keine Lust auf Prügeleien oder stinkende Tiere? Du willst deinen Gegner am liebsten aus sicherer Entfernung töten? Dann ist Fernkampf dein Ding.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Das Ausbildungsgelände für Fernkämpfer. Steine, Speere und alles was man werfen oder schießen kann fliegt hier durch die Luft.</p><p> Je größer das Gelände, desto weniger Unfälle verzögern die Ausbildung. </p>",
  
            :en_US => "<p>Training area for ranged units. Stones and javelins fill the air with a whiring buzz.</p><p>If some-one lacks courage to fight face-to-face, the firing range is the place to make a career in the army. Accidents that go pear-shaped are possible!</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 3,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 15,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*1.5)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*3)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((1233*POW(2.71828,0.275*MIN(LEVEL,10))*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-0.96)+(0.06*(MAX(LEVEL-10,0))+0.98)*2))*3)',
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
        {               #   Stall
          :id          => 14, 
          :symbolic_id => :building_stud,
					:category    => 5,
          :db_field    => :building_stud,
          :name        => {
            
            :de_DE => "Stall",
  
            :en_US => "Stable",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Stinkende Tiere und brüllende Ausbilder. Genau das bietet ein Stall bei der Ausbildung von Kavallerieeinheiten. Der Traum aller Pferdemädchen!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kein Ort in der Siedlung stinkt so sehr wie der Stall. Nicht weiter verwunderlich werden hier doch Straußen, Säbelzahntiger, kleine Dinosaurier und eine Katze gehalten.</p><p>Die Katze ist das einzige Wesen vor denen die Dinos Angst haben. Ihre Körperfülle entspricht ihrer wichtigen Position.</p><p>Vorrangig werden die Tiere dressiert und den Reitern der richtige Umgang beigebracht. Die wenigsten Reiter führen im Kampf selber Waffen, zumeist ist das Reittier an sich die Waffe.</p><p>Die Ausbildung würde schneller gehen, wenn mehr Platz da wäre und die Tiere aufhören würden sich gegenseitig aufzufressen.</p>",
  
            :en_US => "<p>Hosts troops.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 6,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 18,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*3)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*1.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((1233*POW(2.71828,0.275*MIN(LEVEL,10))*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-0.96)+(0.06*(MAX(LEVEL-10,0))+0.98)*2))*1)',
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

        },              #   END OF Stall
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
  
            :de_DE => "<p>Steincontainer, Saurierkräne, Holzkarren; alles was man zum Lagern und versenden von Rohstoffen braucht.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Steinzeitliches Logistikzentrum zum Lagern und Versenden von Rohstoffen. Je größer das Lager, desto mehr Karren können versendet werden.</p>",
  
            :en_US => "<p>Storage space.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 4,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 7,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*1+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :capacity  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR(((MIN(LEVEL,4)-MIN(LEVEL-1,4))*(50*POW(LEVEL,3)-250*POW(LEVEL,2)+500*LEVEL-200)+(MAX(LEVEL,4)-MAX(LEVEL-1,4))*(1339.3*POW((LEVEL-4),2)-2175*(LEVEL-4)+4300))*2.5)",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR(((MIN(LEVEL,4)-MIN(LEVEL-1,4))*(50*POW(LEVEL,3)-250*POW(LEVEL,2)+500*LEVEL-200)+(MAX(LEVEL,4)-MAX(LEVEL-1,4))*(1339.3*POW((LEVEL-4),2)-2175*(LEVEL-4)+4300))*2.5)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR(((MIN(LEVEL,4)-MIN(LEVEL-1,4))*(50*POW(LEVEL,3)-250*POW(LEVEL,2)+500*LEVEL-200)+(MAX(LEVEL,4)-MAX(LEVEL-1,4))*(1339.3*POW((LEVEL-4),2)-2175*(LEVEL-4)+4300))*1.25)",
              },
            
          ],

          :abilities   => {

            :trading_carts => "10*LEVEL*LEVEL",

            :unlock_p2p_trade => 1,            
    
          },

          :conversion_option => {
            :building              => :building_storage_2,
            :target_level_formula  => "MAX(LEVEL,10)-9", 
          },

        },              #   END OF Rohstofflager
        {               #   Hütte
          :id          => 16, 
          :symbolic_id => :building_cottage_2,
					:category    => 5,
          :db_field    => :building_cottage_2,
          :name        => {
            
            :de_DE => "Hütte",
  
            :en_US => "Hut",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>In den Hütten leben Eure Untertanen. Je mehr Untertanen desto schneller geht auch der Ausbau von Gebäuden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Hütte schützt eure Untertanen vor Sonne und Regen. Solange ihr alles habt, brauchen eure Untertanen natürlich auch nicht mehr.</p>",
  
            :en_US => "<p>Provides shelter for your subjects. No-one is as demanding as you are, so your people only need basic fit-outs inside their own four walls.</p><p>Your grace and foreseeing leadership is fullfilling all their needs of luxury. The good old times!</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 1,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 12,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*0.75)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*0.5)',
            2 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*0.125)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((1233*POW(2.71828,0.275*MIN(LEVEL,10))*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-0.96)+(0.06*(MAX(LEVEL-10,0))+0.98)*2))*1)',
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
                :speedup_formula   => "FLOOR((1.88*POW(LEVEL,1.425)*1.5+0.5)/100.0*(1.88*POW(LEVEL,1.425)+0.5)/100.0)",
              },

            ],
    
          },

        },              #   END OF Hütte
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
  
            :de_DE => "<p>Ein Kommandoposten koordiniert die verschiedenen Armeen im Felde. Soweit man mehr Armeen in eine Richtung schicken als koordinieren bezeichnen kann.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Kommandoposten erhöht die maximale Anzahl an Armeen und beschleunigt die Einheitenrekrutierung.</p>",
  
            :en_US => "<p>At start it is more a hut or but later an area to represent the chieftain‘s glory, advancement and power.</p><p>Symbols of triumph, the banners and iconic loot is shown off here. Rumor has it that the chieftain uses his hall for excessive orgies from time to time!</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,

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

            ]
          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5+0.5)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*4+0.5)',
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
                :speedup_formula   => "MIN(MAX(LEVEL-10,0),1)*FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

              {
                :queue_type_id     => 3,
                :queue_type_id_sym => :queue_artillery,
                :domain            => :settlement,
                :speedup_formula   => "MIN(MAX(LEVEL-10,0),1)*FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

              {
                :queue_type_id     => 4,
                :queue_type_id_sym => :queue_cavalry,
                :domain            => :settlement,
                :speedup_formula   => "MIN(MAX(LEVEL-10,0),1)*FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

            ],

            :command_points => "1+FLOOR(LEVEL/10.0)",
    
          },

        },              #   END OF Kommandozentrale
        {               #   Kupferschmelzer
          :id          => 18, 
          :symbolic_id => :building_copper_smelter,
					:category    => 6,
          :db_field    => :building_copper_smelter,
          :name        => {
            
            :de_DE => "Kupferschmelzer",
  
            :en_US => "Copper Smelter",
                
          },
          :flavour     => {
            
            :en_US => "<p>Flavour here</p>",
  
            :de_DE => "<p>Kupfer glitzert zwar auch schon im Rohzustand, aber erst nach dem Schmelzen kann es zu Schmuck verarbeitet werden. Ab und zu stellt man auch hilfreiche Werkzeuge damit her.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kupfer ist DIE Entdeckung der Steinzeit und führte zu schönerem Schmuck und auch den ein oder anderen Fortschritt bei Werkzeugen oder anderen Sachen.</p>",
  
            :en_US => "<p>Description here</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,

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

            ]
          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*2)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*2)',
            2 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*1)',
            3 => 'MAX(LEVEL-8,0)',
            
          },

          :production_time => 'FLOOR((1233*POW(2.71828,0.275*MIN(LEVEL,10))*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-0.96)+(0.06*(MAX(LEVEL-10,0))+0.98)*2))*4)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {
    
          },

        },              #   END OF Kupferschmelzer
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
  
            :de_DE => "<p>Feldlager verändern Lagerstätten in militärische Stützpunkte. Für all das Gerede die über Sicherheit, die sie bieten, ziehen Feldlager Feinde wie magisch an.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Das Feldlager transformiert die Lagerstätte in einen militärischen Betrieb. Eine Mauer schützt die Krieger und größere Unterkünfte vergrößern die Garnisonsarmee.</p>",
  
            :en_US => "<p>Training facility for all kinds of groud units and also hosts troops. It has its own drill ground and from to time to time you can see magnificient parades.</p><p>Don´t get mistaken for one of the punching dummies or you won´t leave the barracks alive! Training of beserkers is in progress.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 4,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.75+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*3+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :garrison_size_bonus => "300+40*LEVEL",

            :army_size_bonus => "300+20*LEVEL",
    
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
  
            :de_DE => "<p>Seitdem der Kürschner sein Kupfermesser bekommen hat, traut sich niemand mehr in seine Nähe. Allerdings macht er seine Arbeit jetzt schneller, sodass sich noch niemand beschwert hat.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Mit Kupfermessern kann man Tiere natürlich schneller häuten. Kunsttiere natürlich, denn auch die Steinzeitmenschen legten wert Tierschutz.</p><p>Die Abfälle von großen Kürschnereien werden von kleineren Kürschnereien mit geringem Aufwand weiterverarbeitet.</p>",
  
            :en_US => "<p>Manufacturing hides into leather. Sometimes there are also must-have sabre cat furs as ready-to-wear fashion for the lady or cosy brontosaurus regulation underwear.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 7,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 16,

            },

            ],

          ],          

          :costs      => {
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*0.5)',
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*0.5)',
            2 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*0.25)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((1233*POW(2.71828,0.275*MIN(LEVEL,10))*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-0.96)+(0.06*(MAX(LEVEL-10,0))+0.98)*2))*1)',
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
  
            :de_DE => "<p>Ein Mann und seine Kupferaxt! Obwohl die Kupferaxt ständig verbiegt, bringt er mehr selbst gefällte Bäume als loses Gestrüpp mit.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Durch die Benutzung von Kupferäxten können Holzfäller schneller Bäume fällen, obwohl sie alle paar Bäume die Axt wieder geradebiegen müssen.</p><p>Große Holzfäller lassen nur die kleinen Bäume übrig und reduzieren so die Frustration der kleineren Holzfäller.</p>",
  
            :en_US => "<p>Specialized in cutting trees more efficiently than the gatherer and produces logs. Is by definition permanently competing with the quarry man.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 4,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 14,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*1)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*1)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((1233*POW(2.71828,0.275*MIN(LEVEL,10))*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-0.96)+(0.06*(MAX(LEVEL-10,0))+0.98)*2))*1)',
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
  
            :de_DE => "<p>In der Kupferzeit würde man erwarten kupferne Spitzhacken bei den Arbeitern zu finden. Doch die Arbeiter haben das Kupfer lieber in Schmuck für ihre Frauen investiert. Aus irgendeinem Grund sind sie trotzdem schneller beim Abbau geworden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Wie die Steinbrüche in der Kupferzeit mehr Steine abbauen können, bleibt rätselhaft. Denn sie sind die einzigen, die keine Kupferwerkzeuge bekommen haben.</p><p>Ein richtig großer Steinbruch treibt den Wettkampf unter den Steinbrechern an und sorgt so für schnelleren Abbau.</p>",
  
            :en_US => "<p>Specialized in rock cutting more efficiently than the gatherer and produces stones. It is still not clear, if lumberjacks and quarry men are akin to each other or not.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 4,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 13,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*0.5)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*1)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((1233*POW(2.71828,0.275*MIN(LEVEL,10))*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-0.96)+(0.06*(MAX(LEVEL-10,0))+0.98)*2))*1)',
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

        },              #   END OF Altehrwürdiger Steinbruch
        {               #   Garnison
          :id          => 23, 
          :symbolic_id => :building_garrison,
					:category    => 4,
          :db_field    => :building_garrison,
          :name        => {
            
            :de_DE => "Garnison",
  
            :en_US => "Garrison",
                
          },
          :flavour     => {
            
            :en_US => "<p>This is THE place for warriors of all kinds to repeatedly bash their heads in.</p>",
  
            :de_DE => "<p>Dies ist der Ort für Krieger aller Art sich gegenseitig die Schädel einzuschlagen und die armen Siedlungsbewohner in Ruhe zu lassen. Dass das die Disziplin stärkt ist ein netter Nebeneffekt.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Größere Garnisonen führen zu… größeren Garnisonsarmeen, wer hätte das gedacht. Auch die Feldarmeen profitieren von der erhöhten Disziplin.</p>",
  
            :en_US => "<p>Bigger garrisons lead to… bigger garrison armies who would have thought that. They also affect the effective field army size.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5+0.5)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)/4.3+(MIN(LEVEL,11)-MIN(LEVEL,10))*18054*(0.06*(LEVEL-10)+0.98))*4+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :garrison_size_bonus => "10*LEVEL",

            :army_size_bonus => "5*LEVEL",
    
          },

        },              #   END OF Garnison
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
  
            :de_DE => "<p>Steincontainer, Saurierkräne und seit neuestem, Kupferkarren. Endlich können Rohstoffe mit Stil transportiert werden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Steinzeitliches Logistikzentrum zum Lagern und Versenden von Rohstoffen. Je größer das Lager, desto mehr Karren können versendet werden.</p>",
  
            :en_US => "<p>Storage space.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 18,
              :type => 'building',

              :min_level => 2,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 0,
              :type => '',

              :min_level => 17,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*1)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((1233*POW(2.71828,0.275*MIN(LEVEL,10))*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-0.96)+(0.06*(MAX(LEVEL-10,0))+0.98)*2))*1)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :capacity  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR(((MIN(LEVEL,4)-MIN(LEVEL-1,4))*(50*POW(LEVEL,3)-250*POW(LEVEL,2)+500*LEVEL-200)+(MAX(LEVEL,4)-MAX(LEVEL-1,4))*(1339.3*POW((LEVEL-4),2)-2175*(LEVEL-4)+4300))*((0.06*(LEVEL-10)+0.98)*2)*2.5)",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR(((MIN(LEVEL,4)-MIN(LEVEL-1,4))*(50*POW(LEVEL,3)-250*POW(LEVEL,2)+500*LEVEL-200)+(MAX(LEVEL,4)-MAX(LEVEL-1,4))*(1339.3*POW((LEVEL-4),2)-2175*(LEVEL-4)+4300))*((0.06*(LEVEL-10)+0.98)*2)*2.5)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR(((MIN(LEVEL,4)-MIN(LEVEL-1,4))*(50*POW(LEVEL,3)-250*POW(LEVEL,2)+500*LEVEL-200)+(MAX(LEVEL,4)-MAX(LEVEL-1,4))*(1339.3*POW((LEVEL-4),2)-2175*(LEVEL-4)+4300))*((0.06*(LEVEL-10)+0.98)*2)*1.25)",
              },
            
          ],

          :abilities   => {

            :trading_carts => "1000*1.5*LEVEL",

            :unlock_p2p_trade => 1,            
    
          },

        },              #   END OF Rohstofflager mit Kupferkarren
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
              
              :building  => 5,
              
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
            41 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            42 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            43 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            44 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            45 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            46 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            47 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            48 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            49 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            50 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            51 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            52 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            53 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            54 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            55 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            56 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            57 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            58 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            59 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            60 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            61 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            62 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            63 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            64 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            65 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            66 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            67 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            68 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            69 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              5,
              6,
              
              ],
            },
            70 => {
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
              
              :building  => 0,
              
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
          :base_slots  => 4,
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
        {               #   queue_artillery
          :id          => 3, 
          :symbolic_id => :queue_artillery,
          :unlock_field=> :settlement_queue_artillery_unlock_count,
          :category_id => 1,
					:category    => :queue_category_training,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 4,
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
          :base_slots  => 4,
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
          :base_slots  => 4,
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
          :base_slots  => 4,
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
            
            :de_DE => "Grünling",
  
            :en_US => "Newbie",
                
          },
        },             #   END OF 
        {              #  1
          :id          => 1, 
          :exp         => 100000000,
          :settlement_points   => 1,
          :minimum_sacred_rank => 0,
          :name        => {
            
            :de_DE => "Kläglicher Anführer",
  
            :en_US => "Feeble Leader",
                
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

