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

  attr_accessor :version, :battle, :character_creation, :building_conversion, :building_experience_formula, :resource_types, :unit_types, :building_types, :science_types, :unit_categories, :building_categories, :queue_types, :settlement_types, :victory_types, :construction_speedup, :training_speedup, :character_ranks, :alliance_max_members
  
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
      'victory_types'               => victory_types,  
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
  
  
  def as_json(options={})
    # as_json of rails 3.1.3 does not support option :root; thus, implement
    # it here for the time being
    
    hash = {}    
    self.attributes.each do |name, value|
      hash[name] = value
    end
    
    root = include_root_in_json
    root = options[:root]    if options.try(:key?, :root)
    if root
      root = self.class.model_name.element if root == true
      options.delete(:root)  if options.try(:key?, :root)
      JSON.pretty_generate({ root => hash }, options)
    else
      JSON.pretty_generate(hash, options)
    end    
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
        :alliance_max_members => 60,
  
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
  
            :en_US => "Grey, hard, found everywhere.",
                
          },
          :description => {
            
            :de_DE => "<p>Steine -- in der STEINzeit DER Rohstoff schlechthin. Kann gesammelt, gestapelt, geschärft und geworfen werden. Mehr muss man nicht sagen.</p>",
  
            :en_US => "<p>Stones – in the STONE age THE most vital raw material. Can be gathered, stacked, sharpened and thrown. Not much more to say, really.</p>",
                
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
  
            :en_US => "It’s not for nothing we say “touch wood” when we hope for good luck!",
                
          },
          :description => {
            
            :de_DE => "<p>Holz war bereits in der Steinzeit in allen Varianten verfügbar: Nadelholz, Laubholz, Kantholz und natürlich Brettholz. Als Rohstoff spielt Holz eine wichtige Rolle bei der Konstruktion von Gebäuden und Belagerungswaffen.</p>",
  
            :en_US => "<p>Even in the stone age, wood was available in all its varieties: softwood, hardwood, squared timber and, of course, boards. As a raw material, wood was really important in the construction of buildings and siege weapons.</p>",
                
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
  
            :en_US => "Naturally, throughout the entire stone age they only used artificial fur – so no animals were harmed, of course!  ",
                
          },
          :description => {
            
            :de_DE => "<p>Hält warm, hält Wasser ab, verhängt Löcher und taugt im Notfall auch als rudimentäre Dachbedeckung.</p>",
  
            :en_US => "<p>Keeps you warm, is water resistant, can cover up holes and can be used as emergency roofing.</p>",
                
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
  
            :en_US => "Golden Frog",
                
          },
          :flavour     => {
            
            :de_DE => "Jeder mag Kröten! Die Steinzeitwährung.",
  
            :en_US => "Everyone likes golden frogs! Stone age currency.",
                
          },
          :description => {
            
            :de_DE => "<p>Quasi-Währung in der Steinzeit. Gerne genommen bei jeglichem Tauschhandel.</p>",
  
            :en_US => "<p>A kind of stone-age currency. Readily accepted in any barter transaction.</p>",
                
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
            
            :en_US => "<p>Infantry is the basic unit in every army squad. They protect stone throwers from direct attack and, given enough of them, can also fend off flank attacks.</p>",
  
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
        {               #   Riders
          :id          => 1, 
          :symbolic_id => :unitcategory_cavalry,
          :db_field    => :unitcategory_cavalry,
          :name        => {
            
            :en_US => "Riders",
  
            :de_DE => "Reiter",
                
          },
          :description => {
            
            :en_US => "<p>Mounted units move fast across the battlefield and are the only ones able to avoid enemy infantry and mount a direct attack on enemy throwers (flank attack).</p>",
  
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
        },              #   END OF Riders
        {               #   Ranged Combatants
          :id          => 2, 
          :symbolic_id => :unitcategory_artillery,
          :db_field    => :unitcategory_artillery,
          :name        => {
            
            :en_US => "Ranged Combatants",
  
            :de_DE => "Fernkämpfer",
                
          },
          :description => {
            
            :en_US => "<p>Ranged combatants shoot at the enemy from a safe distance – preferably at foot soldiers. They are extremely vulnerable in a melee.</p>",
  
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
        },              #   END OF Ranged Combatants
        {               #   Siege Weapons
          :id          => 3, 
          :symbolic_id => :unitcategory_siege,
          :db_field    => :unitcategory_siege,
          :name        => {
            
            :en_US => "Siege Weapons",
  
            :de_DE => "Belagerungsgeräte",
                
          },
          :description => {
            
            :en_US => "<p>Siege weapons are used to back up attacks on settlements.</p>",
  
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
            
            :en_US => "<p>Special units are needed when founding settlements, for example.</p>",
  
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
            
            :en_US => "<p>Holds a club and is always at the front of battle lines. Clubbers don’t need much for a happy life. Their lives are pretty short anyway.  </p>",
  
            :de_DE => "<p>Eine Keule in der Hand und immer an vorderster Front. Keulenkrieger brauchen nicht viel für ein glückliches Leben. Zudem ist dieses meist sehr kurz.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Keulenkrieger sind der Grundbestandteil jeder Armee. Sie stehen an der Front und beschützen die Fernkämpfer vor der Kavallerie. Keulenkrieger sind zähe Burschen und nur schwer klein zu kriegen, allerdings finden sie nur zu oft den Tod durch feindliche Fernkämpfer.</p>",
  
            :en_US => "<p>Clubbers are the basic unit of any army. They are on the front line and protect the ranged combatants from the cavalry. Clubbers are tough fellows and difficult to beat, but they all too often they get knocked off by enemy ranged combatants.</p>",
                
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
            
            :en_US => "<p>You can tell battle-hardened clubbers by their thick skin and big clubs, and of course, the things they say. “You two? Ha! Go and fetch three more of you so you can give me a halfway fair fight!”</p>",
  
            :de_DE => "<p>Erfahrene Keulenkrieger erkennt man an ihrer dicken Haut und ihrer großen Keule und natürlich an ihren Ausrufen. „Ihr zwei? Holt euch noch drei dazu, damit es ein halbwegs fairer Kampf wird!“</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die dicke Haut schützt sie zwar vor Keulenschlägen, aber die spitzen Steine der Fernkämpfer hält sie nicht ab. Dafür tut es weniger weh, wenn man von einem Strauß überrannt wird und die Zeitspanne bis zur Bewusstlosigkeit muss nicht in Schmerzen durchstanden werden.</p>",
  
            :en_US => "<p>Their thick skin protects them against blows from others’ clubs, but doesn’t help much against the ranged combatants’ sharp stones. It makes being run over by an ostrich less painful, though – they’re not in so much agony until they pass out.</p>",
                
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
        {               #   Drunken Clubber
          :id          => 2, 
          :symbolic_id => :clubbers_3,
					:category    => 0,
          :db_field    => :unit_clubbers_3,
          :name        => {
            
            :en_US => "Drunken Clubber",
  
            :de_DE => "Betrunkener Keulenkrieger",
                
          },
          :flavour     => {
            
            :en_US => "<p>Very few clubbers survive their first battles, and almost none of them survive an entire war. Drinking enough beer increases their combat strength and reduces their ability to feel pain. </p>",
  
            :de_DE => "<p>Sehr wenige Keulenkrieger überleben ihre ersten Schlachten, fast keiner überlebt einen Krieg. Durch ausreichend Bier erhöht sich die Kampfkraft und verringert sich das Schmerzempfinden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Manche Keulenkrieger tauchen sogar mit ihrem Bierfaß auf dem Schlachtfeld auf. Nichts geht über einen guten Schluck vor, nach und während der Schlacht. Leicht wankend gibt der betrunkene Keulenkrieger auch ein schwierigeres Ziel für die Fernkämpfer ab. Nur leider zielen diese sowieso nicht, so dass sie weiterhin sehr tödlich für die Keulenkrieger sind.</p>",
  
            :en_US => "<p>Some clubbers even show up on the battlefield with a barrel of beer. There’s nothing like a good swig of beer before, during and after a battle. A slightly drunk clubber staggers and weaves, making him a much more difficult target for ranged combatants. But ranged combatants can’t aim anyway, which makes them just as deadly for clubbers. </p>",
                
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


        },              #   END OF Drunken Clubber
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
            
            :en_US => "<p>Why bother cutting a branch from a tree and making a club out of it when you can wield the whole tree?</p>",
  
            :de_DE => "<p>Wozu einen Ast vom Baum schlagen und zu einer Keule verarbeiten, wenn man einfach den ganzen Baum schwingen kann?</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Groß, stark, sauber rasierter Bart. Ein Baum-Brutalo legt sehr großen Wert auf sein Äußeres.</p><p>In der Schlacht bietet der Baum-Brutalo ein seltsames Schauspiel. Umhüllt von den rauschenden Blättern seines Kampfbaumes wirbelt der Baum-Brutalo durch die gegnerischen Reihen wie ein Säbelzahntiger, der sich den Schwanz geklemmt hat. Nicht den flauschigen, den anderen...</p>",
  
            :en_US => "<p>Big, strong, clean-shaven. Tree-huggers set great store by their appearance.</p><p>In battle, the tree-hugger is a strange sight. Surrounded by the rustling leaves of his fighting tree, the tree-hugger whirls through enemy ranks like a sabre-toothed tiger with a trapped tail. And probably other sensitive extremities too … </p>",
                
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
        {               #   Gravel Stone Thrower
          :id          => 4, 
          :symbolic_id => :thrower,
					:category    => 2,
          :db_field    => :unit_thrower,
          :name        => {
            
            :en_US => "Gravel Stone Thrower",
  
            :de_DE => "Kieselsteinwerfer",
                
          },
          :flavour     => {
            
            :en_US => "<p>These ranged combatants couldn’t hit a target board at ten paces, but luckily massed enemy phalanxes generally make a nice big target that’s hard to miss. </p>",
  
            :de_DE => "<p>Diese Fernkämpfer könnten zwar eine Zielscheibe nicht aus zehn Meter Entfernung treffen, aber zum Glück sind Schlachtreihen meist viel größer als Zielscheiben.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Große Steine, kleine Steine, ein Kieselsteinwerfer mag sie alle, solange er sie jemandem an den Kopf werfen kann. Ok, zugegeben, die kleinen mag er ein bisschen lieber. Zwar zielt ein Kieselsteinwerfer nicht, aber sowas kann schnell ins Auge gehen.</p><p>Kieselsteinwerfer fürchten nicht den Tod an sich, nur die Straußenreiter, die diesen bringen.</p>",
  
            :en_US => "<p>Big stones, little stones – stone throwers like them all as long as they can throw them at someone’s head. Well, OK – they do prefer the smaller ones. Stone throwers don’t actually aim, but their stones can hit you in the eye quite easily. Gravel stone throwers aren’t afraid of death as such – they’re more afraid of the ostrich riders who cause it.</p>",
                
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


        },              #   END OF Gravel Stone Thrower
        {               #   Accurate Gravel Stone Thrower
          :id          => 5, 
          :symbolic_id => :thrower_2,
					:category    => 2,
          :db_field    => :unit_thrower_2,
          :name        => {
            
            :en_US => "Accurate Gravel Stone Thrower",
  
            :de_DE => " Zielsicherer Kieselsteinwerfer",
                
          },
          :flavour     => {
            
            :en_US => "<p>Hitting a target at fifty meters with a stone is pretty impressive. Unfortunately, the enemy is mostly further away than that.</p>",
  
            :de_DE => "<p>Einen Stein auf fünfzig Meter Entfernung genau auf ein Ziel zu werfen, ist eine beeindruckende Leistung. Dummerweise stehen die Gegner meistens weiter weg.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein sicherer Wurf führt zu besseren Treffern. Nicht dass der Unterschied bemerkbar wäre, meist sind eh genug gegnerische Nahkämpfer da, aber es führt doch zu ein oder zwei kritischen Treffern.</p><p>Ein bewegliches Ziel wie einen Straußenreiter zu treffen, ist eine große Leistung und der Unterschied zwischen Leben und Tod für einen Fernkämpfer.</p>",
  
            :en_US => "<p>A sure throw means better strikes. Not that you’d notice the difference – there are usually enough enemy melee fighters around, but it can mean a couple of good tactical strikes. Hitting a moving target like an ostrich rider is quite an achievement and can mean the difference between life and death for a stone thrower.</p>",
                
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


        },              #   END OF Accurate Gravel Stone Thrower
        {               #   Stone Thrower
          :id          => 6, 
          :symbolic_id => :thrower_3,
					:category    => 2,
          :db_field    => :unit_thrower_3,
          :name        => {
            
            :en_US => "Stone Thrower",
  
            :de_DE => "Steinschleuderer",
                
          },
          :flavour     => {
            
            :en_US => "<p>Aiming is for sissies. The stone throwers‘ motto is: “The further you can throw the stone, the better!” Sometimes they’re right.</p>",
  
            :de_DE => "<p>Zielen ist was für Anfänger. Das Motto der Steinschleuderer: 'Je weiterer der Stein geworfen wird, desto besser!' Stimmt sogar manchmal.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Mit der Schleuder können größere Steine weiter geworfen werden. So trifft der Steinschleuderer oft die unvorbereiteten Kämpfer in der zweiten Reihe wodurch insgesamt deutlich mehr Opfer zu beklagen bzw. zu bejubeln sind. Je nach der Seite des Kampfes auf der man gerade steht. Was durchaus nicht immer eindeutig ist.</p>",
  
            :en_US => "<p>You can throw bigger stones even further if you use a catapult. Stone throwers often hit unsuspecting warriors in the second row, leading to a much higher number of overall casualties that are either suffered or celebrated, depending on which side of the battle you happen to be. Which isn’t always obvious.</p>",
                
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


        },              #   END OF Stone Thrower
        {               #   Spear Thrower
          :id          => 7, 
          :symbolic_id => :thrower_4,
					:category    => 2,
          :db_field    => :unit_thrower_4,
          :name        => {
            
            :en_US => "Spear Thrower",
  
            :de_DE => " Speerschleuderer ",
                
          },
          :flavour     => {
            
            :en_US => "<p>Why anyone would bother to tie a stick to a stone is a mystery – stones are brilliant missiles. But the effect is fantastic, longer range, more accurate and easier to collect. What more could you want?</p>",
  
            :de_DE => "<p>Wieso jemand einen Stock an einen Stein gebunden hat, ist unverständlich, denn Steine sind doch schon hervorragende Wurfgeschosse. Aber der Effekt ist großartig, größere Reichweite, zielgenauer und einfacher einzusammeln. Was will man mehr?</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein Speer ist auch im Nahkampf, vor allem gegen Reiter, effektiv. Dumm nur, wenn man schon alle Speere weggeworfen hat, bevor ein Reiter angreift. Im Leitfaden für Speerwerfer steht, dass man immer einen Speer weniger werfen sollte, als man hat. Leider kann kein Speerwerfer zählen, geschweige denn lesen.</p>",
  
            :en_US => "<p>A spear is also effective at close range – especially against riders. The only problem is if you’ve thrown all your spears already before you’re attacked by a rider. The field manual for spear throwers clearly states: “Always throw one spear less than you have”. The trouble is, spear throwers can’t read, let alone count.</p>",
                
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


        },              #   END OF Spear Thrower
        {               #   Two-handed Ostrich Rider
          :id          => 8, 
          :symbolic_id => :light_cavalry,
					:category    => 1,
          :db_field    => :unit_light_cavalry,
          :name        => {
            
            :en_US => "Two-handed Ostrich Rider",
  
            :de_DE => "Zweihändiger Straußenreiter",
                
          },
          :flavour     => {
            
            :en_US => "<p>The two-handed ostrich riders are totally focused on controlling their mounts. As they themselves are unarmed, the beaks and claws of their ostriches pose more of a threat than they do.</p>",
  
            :de_DE => "<p>Die zweihändigen Straußenreiter legen ihre ganze Konzentration auf das Führen ihres Reittieres. Selber unbewaffnet stellen sie neben den Schnäbeln und Klauen der Strauße wirklich keine zusätzliche Gefahr dar.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Strauße sind nicht nur lecker, sondern auch gute und schnelle Reittiere. Straußenreiter sind die Furcht jedes Fernkämpfers. Schnell genug, um an der Infanterie vorbeizukommen, bleibt ihren Gegnern nur zu hoffen, dass die Sträuße den Kopf in den Sand stecken oder der Reiter von seinem Strauß fällt, auch wenn dies meist wenig Unterschied macht.</p>",
  
            :en_US => "<p>Ostriches don’t just taste delicious, they’re also really good, speedy mounts. Ostrich riders are the bane of all stone throwers. Fast enough to get past the infantry, their enemies can only hope that the ostriches will stick their heads in the sand or that their riders will fall off, although that doesn’t seem to make much difference.</p>",
                
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


        },              #   END OF Two-handed Ostrich Rider
        {               #   One-handed Ostrich Rider
          :id          => 9, 
          :symbolic_id => :light_cavalry_2,
					:category    => 1,
          :db_field    => :unit_light_cavalry_2,
          :name        => {
            
            :en_US => "One-handed Ostrich Rider",
  
            :de_DE => "Einhändiger Straußenreiter",
                
          },
          :flavour     => {
            
            :en_US => "<p>Experienced ostrich riders only need one hand to hold on to their mounts, which means they have one hand free to do more practical things. Like picking their noses, for instance, or smashing in the skulls of their enemies.</p>",
  
            :de_DE => "<p>Mit ausreichend Erfahrung braucht der Reiter nur noch eine Hand zum Festhalten und hat so die andere Hand für sinnvollere Tätigkeiten frei. Zum Beispiel um den Mädels zuzuwinken oder seinen Feinden den Schädel einzuhauen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Eine handliche Keule in der freien Hand sind einhändige Straußenkrieger der Todfeind aller Fernkämpfer.</p><p>Im Kampf gegen Keulenkrieger ziehen sie allerdings den Kürzeren, da sie nur eine kleine, nicht so schwere Keule bei sich führen.</p>",
  
            :en_US => "<p>With a handy little club in his free hand, the one-handed ostrich rider is a deadly enemy for stone throwers. In battle against clubbers, though, they usually come off worse because they only have rather small, light clubs.</p>",
                
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


        },              #   END OF One-handed Ostrich Rider
        {               #   Freehand Ostrich Rider
          :id          => 10, 
          :symbolic_id => :light_cavalry_3,
					:category    => 1,
          :db_field    => :unit_light_cavalry_3,
          :name        => {
            
            :en_US => "Freehand Ostrich Rider",
  
            :de_DE => " Freihändiger Straußenreiter ",
                
          },
          :flavour     => {
            
            :en_US => "<p>Very talented riders wield a club in one hand and throw small stones with the other. It looks impressive but their enemies are usually still massacred by the ostriches they are mounted on.</p>",
  
            :de_DE => "<p>Besonders talentierte Reiter halten in einer Hand eine Keule und werfen mit der anderen Hand kleine Steine. Sieht beeindruckend aus, aber die meisten Gegner metzelt weiterhin der Strauß nieder.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Auf blitzschnelle Angriffe spezialisiert, bleiben diese Reiter nie lange auf einem Fleck. Freihändig können die Reiter auch auf ihren Reittiere manövrieren und gezielt kleine Steine auf ungeschützte Fernkämpfer werfen.</p><p>Gegnerische Reittiere gelten als Spielverderber. Sie blockieren den Weg zu den leichten Zielen, sprichwörtlich auch Fleischtöpfe genannt.</p>",
  
            :en_US => "<p>Specializing in lightning attacks, these riders don’t stick around in one place for long. With both hands free, riders can also turn around while seated on their mounts, and throw well-aimed small stones at unprotected stone throwers. Enemy mounts are spoilsports. They block access to sitting targets that can be picked off easily.</p>",
                
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


        },              #   END OF Freehand Ostrich Rider
        {               #   Dinosaur Rider
          :id          => 11, 
          :symbolic_id => :light_cavalry_4,
					:category    => 1,
          :db_field    => :unit_light_cavalry_4,
          :name        => {
            
            :en_US => "Dinosaur Rider",
  
            :de_DE => "Dinoreiter",
                
          },
          :flavour     => {
            
            :en_US => "<p>The dream of every novice rider is to ride a dinosaur. But once they’ve finally done it, they usually wish they’d become stone throwers instead. Dinosaurs stink! And after a battle, it can take days to get the smell out of your clothes.</p>",
  
            :de_DE => "<p>Der Traum eines jeden neuen Reiters. Einen Dino reiten. Wenn man es endlich geschafft hat wünscht man sich, doch lieber Fernkämpfer geworden zu sein. Ein Dino stinkt! Und die Dinowäsche nach einer Schlacht kann auch mal Tage dauern.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Als Reiter eines Dinos hat man genau zwei Aufgaben. Erstens nicht abgeworfen zu werden und zweitens den Dino immer wieder auf das Schlachtfeld zurückzulenken, wenn er erstmal durch die Schlachtreihen durchgebrochen ist. Mit Füßen, Schwanz und Zähnen werden die hilflosen Gegner niedergemäht.</p><p>Kein Wunder, gibt es zu Hause doch nichts zu fressen.</p>",
  
            :en_US => "<p>A dinosaur rider has only two jobs: the first is not to get thrown off, and the second is to keep steering his dinosaur back to the battlefield once it’s broken through enemy ranks. The hapless enemy is mowed down by the dinosaur’s feet, tail and teeth. No wonder – there’s nothing to eat at home.</p>",
                
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


        },              #   END OF Dinosaur Rider
        {               #   Neanderthals
          :id          => 12, 
          :symbolic_id => :neanderthal,
					:category    => 0,
          :db_field    => :unit_neanderthal,
          :name        => {
            
            :en_US => "Neanderthals",
  
            :de_DE => "Neandertaler",
                
          },
          :flavour     => {
            
            :en_US => "<p>Neanderthals don’t talk, they act – er, hit.</p>",
  
            :de_DE => "<p>Neandertaler reden nicht, sie handeln äh, schlagen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Neandertaler sind ein wilder Stamm prähistorischer Menschen.</p><p>Sie sind zwar ziemlich beeindruckende Kämpfer, haben aber keine Ahnung von Taktik. Wenn Schreien und Zuschlagen nicht mehr ausreichen, ist es meist schon zu spät für den Neandertaler.</p>",
  
            :en_US => "<p>Neanderthals are a wild tribe of prehistoric people. They are quite impressive fighters, but haven’t a clue about tactics. When shouting and hitting fail to fend off the enemy, that’s usually the end for Neanderthals.</p>",
                
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


        },              #   END OF Neanderthals
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
            
            :en_US => "<p>A little chief is allowed to set up an encampment in the name of the actual chieftain. But in fact, it’s the easiest way to get him out of the settlement. The new camp is more like a bonus.</p>",
  
            :de_DE => "<p>Ein Kleiner Häuptling darf im Namen des richtigen Häuptlings eine Lagerstätte gründen. Tatsächlich ist das nur die einfachste Möglichkeit ihn aus der Siedlung zu bekommen. Eine Neugründung wäre ein Bonus.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein Kleiner Häuptling ist ungefähr so beliebt wie die Begegnung mit einem hungrigen Dinosaurier. Als integranter, karrieresüchtiger, aalglatter Möchtegern ist der Kleine Häuptling das Rollenvorbild für ganze Generationen an Wichtigtuern. Zum Glück kann der Kleine Häuptling unter dem Vorwand der Gründung einer Lagerstätte aus der Siedlung verbannt werden.</p>",
  
            :en_US => "<p>A little chief is about as popular as an encounter with a hungry dinosaur. As a scheming, workaholic, slick wannabe, the little chief is a role model for entire generations of snobs. Luckily, a little chief can be banished from a settlement under the pretext of founding a new encampment.</p>",
                
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
  
            :en_US => "Fortress",
                
          },
          :flavour     => {
            
            :en_US => "<p>The fortress rules the region. Troops are deployed to collect taxes from the settlements and protect the fortress from attacks.</p>",
  
            :de_DE => "<p>Die Festung beherrscht die Region. Dafür werden Truppen aufgestellt, die die Steuern der Siedlungen eintreiben und die Festung vor Angriffen beschützen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein paar aufgetürmte Steinbrocken, zusammengebundene Baumstämme, ein provisorisches Tor. Fertig ist die Festung. Die Festungsanlagen bestehen aus einen Hauptgebäude, einem kleinen Versammlungsplatz und Mauern zur Verteidigung.</p><p>In der Festung werden Krieger ausgebildet, Steuern eingetrieben und sich hinter Verteidigungsanlagen verschanzt.</p>",
  
            :en_US => "<p>A couple of stacked-up stones, some tree-trunks tied together, a makeshift gate – and there’s your fortress. Fortress compounds consist of a main building, a small meeting place and walls for defence. Inside the fortress they train warriors, collect taxes and use avoidance tactics by hiding behind their defensive fortifications.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(99*POW(2.71828,0.11*LEVEL))",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
  
            :en_US => "Infantry Tower",
                
          },
          :flavour     => {
            
            :en_US => "<p>No place for thinkers! Infantry members need strength and stamina, whether they’re armed with a truncheon, a club or a spear.</p>",
  
            :de_DE => "<p>Hier ist kein Platz für Denker! Kraft und Ausdauer braucht ein Nahkämpfer, egal ob er mit Knüppel, Keule oder Speer bewaffnet ist.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>In dem Turm der Truppenunterkunft werden die Nahkämpfer in der Kunst des Kampfes unterwiesen. Der überaus sadistische Ausbilder legt höchsten Wert auf Gehorsam und Disziplin.</p><p>Wer den Befehlen nicht gehorcht oder sich im Training noch dümmer anstellt als die anderen, der muss im Turm der Reitmeisterei putzen. Wer es zurück schafft, kämpft anschließend mit deutlich größerem Elan.</p>",
  
            :en_US => "<p>Infantry troops are instructed in the art of fighting in the infantry tower. The extremely sadistic trainer sets great store by obedience and discipline. And if someone doesn’t obey orders or is even more stupid than the others during training, he has to clean the stables in the cavalry tower. Anyone who can survive that usually comes back and fights with noticeably more enthusiasm.</p>",
                
          },
          :hidden      => 0,

	        :population  => "2.5*POW(LEVEL,2)-2.5*LEVEL+5",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
  
            :en_US => "Artillery Tower",
                
          },
          :flavour     => {
            
            :en_US => "<p>This is where anything that can be thrown or shot goes flying through the air. You’d better duck! Ranged combatant training is in full swing!</p>",
  
            :de_DE => "<p>Hier fliegt alles, was man werfen oder abschießen kann! Kopf runter! Die Ausbildung der Fernkämpfer ist in vollem Gang.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Von außen betrachtet ist der Turm der Ballistik eine Augenweide. Von innen betrachtet ist der Turm ein Trümmerfeld. Kleine Kieselsteine liegen auf dem ganzen Boden verteilt, Bratspieße, Speere und Pfeile haben sich in sämtliche Stützpfeiler gebohrt und an den Wänden spuren hinterlassen.</p><p>Nicht weiter verwunderlich ist da die Helmpflicht. Die Ausbilder und Auszubildenden haben sich feste Tierhäute um den Kopf gebunden, damit sie den Aufprall kleiner Steiner oder Splitter halbwegs überstehen.</p><p>Verglichen mit der Ordnung einer Fernkämpfer-Kampfreihe auf dem Schlachtfeld ist das herrschende Chaos überraschend. Auf ein Kommando werden alle Arten von Wurfgeschossen in die Luft gesandt. Nur leider wissen die Wenigsten, auf welches Kommando sie eigentlich gerade achten sollen.</p>",
  
            :en_US => "<p>From the outside, the artillery tower is a feast for the eyes. But inside, it’s a field of rubble. Gravel and stones litter the ground, roasting spits, spears and arrows are lodged in all the upright beams, and the walls are scarred from all the target practice.</p><p>Hardly surprising that helmets are compulsory. Trainers and trainees have bound thick animal skins around their heads so they can at least survive being hit by small stones or gravel.</p><p>When compared to the order in the ranged combatant ranks in battle, the chaos here is surprising. On command, all kinds of missiles are sent flying through the air. Unfortunately, no-one really knows which command they should obey.</p>",
                
          },
          :hidden      => 0,

	        :population  => "2.5*POW(LEVEL,2)-2.5*LEVEL+5",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            
            :en_US => "<p>This place is home to countless animals and sweaty men. Beware of the dung and pungent smell!</p>",
  
            :de_DE => "<p>Hier sind Unmengen an Tieren und verschwitzten Männern untergebracht. Vorsicht vor Dung und penetrantem Geruch!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Turm der Reitmeisterei dient der Ausbildung aller berittenen Einheiten. Dabei wird vor allem Wert auf den Umgang mit den Tieren wie auch auf die Reittechnik gelegt.</p><p>Der Zutritt ist streng begrenzt auf ausgebildete Reiter und Tierpfleger. Wenn das Tor der Reitmeisterei kurzzeitig offen steht, schleichen sich oftmals neugierige halbstarke Jungs hinein. Zwar beeindruckt das die Mädchen ungemein, aber die Jungs haben keine Zeit mehr sich in der Aufmerksamkeit zu sonnen. Die Tierpfleger entsorgen die blutigen Überreste ohne großes Aufheben.</p>",
  
            :en_US => "<p>The cavalry tower is where all mounted units are trained. Great store is set on proper animal handling as well as on riding technique.</p><p>Entrance is strictly limited to trained riders and animal keepers. If the gate is left open – even briefly – inquisitive, spotty teenage boys tend to sneak in. It impresses the girls no end, but the lads rarely get a chance to bathe in their admiration afterwards. The animal keepers generally deal with their bloody remains unceremoniously.</p>",
                
          },
          :hidden      => 0,

	        :population  => "2.5*POW(LEVEL,2)-2.5*LEVEL+5",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            
            :en_US => "<p> This is where decisions are made! The larger the chieftain’s hut, the bigger and more complex the settlement and the number of armies that can be sent into battle.</p>",
  
            :de_DE => "<p>Hier werden die Entscheidungen getroffen! Je größer die Häuptlingshütte desto größer und vielfältiger die Siedlung und die Anzahl der Armeen, die ins Feld geführt werden können.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Häuptlingshütte spiegelt die Größe des Dorfes wieder. Jede Erweiterung der Häuptlingshütte ermöglicht neue Arten und eine größere Anzahl von Gebäuden zu bauen.
Hinter der Häuptlingshütte ist ein kleiner Lagerplatz, auf dem Rohstoffe zwischengelagert werden können, so lange es kein Lager gibt.</p><p>Außerdem ermöglicht die Häuptlingshütte Armeen aufzustellen.</p><p>Eine prunkvolle, mit Trophäen der Feinde geschmückte Hütte verringert die Moral möglicher Angreifer und erhöht die Moral der Verteidiger.</p>",
  
            :en_US => "<p>The chieftain’s hut reflects the size of the village. An upgrade of the chieftain’s hut means new types of buildings – and more of them – can be built. Behind the chieftain’s hut is a little storage area where raw materials can be kept for a short time while there is no storehouse. The chieftain’s hut makes it possible to deploy armies. A luxurious hut decorated with enemy trophies lowers the morale of possible attackers while raising the morale of the defenders.</p>",
                
          },
          :hidden      => 1,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
  
            :en_US => "Chieftain‘s Hut",
                
          },
          :flavour     => {
            
            :en_US => "<p>This is where decisions are made! Show me your chieftain’s hut and I’ll tell you who you are! More buildings, more armies, more glory. Chieftains are pretty predictable.</p>",
  
            :de_DE => "<p>Hier werden die Entscheidungen getroffen! Zeig mir Deine Häuptlingshütte und ich sag Dir wer Du bist! Mehr Gebäude, mehr Armeen, mehr Glanz. Häuptlinge sind wirklich berechenbar.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Lange Zeit ist die Häuptlingshütte das einzig halbwegs befestigte Gebäude der Siedlung. Allein an ihrer Größe lässt sich der Fortschritt der Siedlung ablesen. Je größer die Häuptlingshütte, desto mehr und bessere Gebäude und desto mehr Armeen kann eine Siedlung haben. Selbstverständlich hat der Häuptling in seiner Hütte auch ein kleines Lager für schwere Zeiten.</p><p>Eine prunkvolle, mit Trophäen gefallener Feinde geschmückte Hütte sieht nicht nur schick aus, sondern erhöht auch die Moral der Verteidiger.</p>",
  
            :en_US => "<p>The chieftain’s hut has long been the only building in the settlement even halfway fortified. Its size alone will tell you how the settlement is progressing. The bigger the chieftain’s hut, the more – and better – the buildings and the more armies the settlement can have. Of course, the chieftain has a little store in his hut for when times get tough.</p><p>A magnificent hut, decorated with trophies taken from fallen enemies not only looks smart, it boosts the morale of the defending troops.</p>",
                
          },
          :hidden      => 0,

	        :population  => "1+MIN(MAX(LEVEL-3,0),1)+MIN(MAX(LEVEL-6,0),1)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
                :formula            => "1600+100*FLOOR(((MIN(LEVEL+1,10)-MIN(LEVEL,10))*(130*POW(LEVEL,2)-130*LEVEL)+(MAX(LEVEL+1,10)-MAX(LEVEL,10))*(20*POW((LEVEL),2)+9000))/100)",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "1600+100*FLOOR(((MIN(LEVEL+1,10)-MIN(LEVEL,10))*(130*POW(LEVEL,2)-130*LEVEL)+(MAX(LEVEL+1,10)-MAX(LEVEL,10))*(20*POW((LEVEL),2)+9000))/100)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "800+50*FLOOR(((MIN(LEVEL+1,10)-MIN(LEVEL,10))*(130*POW(LEVEL,2)-130*LEVEL)+(MAX(LEVEL+1,10)-MAX(LEVEL,10))*(20*POW((LEVEL),2)+9000))/100)",
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
  
            :en_US => "Hunter Gatherers",
                
          },
          :flavour     => {
            
            :en_US => "<p>Wood and stones, a couple of rabbits or other rodents and the occasional golden frog. For hunter gatherers, though, the real treasures are mushrooms. Especially the red ones with the white spots.</p>",
  
            :de_DE => "<p>Holz und Steine, ein paar Kaninchen oder andere Nager und ganz selten auch mal eine Kröte. Die wahren Schätze aus Sicht des Jägers und Sammlers sind aber Pilze. Vor allem die roten mit den weißen Punkten.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Primitivster aller Steinzeitbewohner. Um sein Gebiet im Auge zu behalten, schläft er niemals in einer Hütte, sondern davor, oder auch oben drauf. Alle seine Schätze werden fein säuberlich auf seinem Gelände zur Schau gestellt.</p><p>Er jagt und sammelt einfach alles was ihm vor die Flinte - äh Steinschleuder - kommt.Neben vielen völlig unbrauchbaren Sachen finden die Bewohner alles von Ästen und Steinen über Wurzeln und bei ausreichend großem Gelände sogar ein paar Kröten.</p>",
  
            :en_US => "<p>The most primitive of all stone-age folk. So he can keep an eye on his territory, he never sleeps inside a hut, but in front of it or even on the roof. All his treasures are set out neatly on display in his compound. He hunts and gathers anything that comes into his sights – er… into reach of his slingshot.</p><p>Apart from all kinds of useless stuff, inhabitants find everything – from branches and stones to roots and, if the area is big enough, even a couple of golden frogs.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            
            :en_US => "<p>Your subjects live in small huts. The more subjects there are, the faster you can build other buildings.</p>",
  
            :de_DE => "<p>In den kleinen Hütten leben eure Untertanen. Je mehr Untertanen, desto schneller geht auch der Bau von Gebäuden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die kleine Hütte schützt Eure Untertanen gerade mal vor Sonne und Regen. Hauptsache, sie sind fleißig und beschweren sich nicht. Je mehr Hütten, desto mehr Untertanen habt ihr, die wiederum schneller arbeiten und Eure Siedlung schneller ausbauen. Wenn Chef sein immer so einfach wäre!</p>",
  
            :en_US => "<p>A little hut only protects your subjects from sun and rain. The main thing is that they work hard and don’t complain. The more huts, the more subjects you have, the faster they work, and the quicker your settlement is upgraded. If only being the boss was always as simple as this!</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
  
            :en_US => "Training Grounds",
                
          },
          :flavour     => {
            
            :en_US => "<p>Looking for a little fight? Haven’t been bashed up for a while? The barracks are the place to go for anyone wanting to jump into the fray.</p>",
  
            :de_DE => "<p>Auf der Suche nach einem kleinen Kampf? Lange nicht mehr verprügelt worden? In der Kaserne finden sich alle, die sich gerne mitten ins Getümmel stürzen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Auf dem Ausbildungsgelände werden alle Arten von Nahkämpfern ausgebildet. Große Keule, Bratspieß oder doch die bloßen Fäuste, alles ist erlaubt.</p><p>In zahlreichen Wettbewerben messen sich die kommenden Krieger, um sich im Zweikampf zu stählen. Einmal im Mondumlauf wird ein öffentliches Turnier veranstaltet. Der Sieger bekommt alles. Ruhm, Essen, einen Tag frei und Männer soviel sie wollen. Ja Männer! Denn zumeist gewinnt eine Frau dieses Turnier. Wie? Mit den tödlichen Waffen einer Frau natürlich!</p>",
  
            :en_US => "<p>These are the training grounds where all kinds of close combat fighters are trained. Big clubs, roasting spits, or bare fists – anything goes.</p><p>Would-be combatants compete in numerous contests to toughen themselves up for duelling. Once in a moon a public tournament is held. The winner gets the lot: Glory, food, a day off and as many men as they want. Yes, that’s right: men! Because the tournaments are usually won by women. How? With a woman’s deadliest weapons, of course!</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            
            :en_US => "<p>The place where alliance members hold diplomatic exchanges or discussions. It takes at least two to have a good conversation, even though often only one of them does the talking. Talk? A little chief can do that better than anyone else.</p>",
  
            :de_DE => "<p> Ort diplomatischen Austauschs oder Besprechungen innerhalb der Allianz. Zu einer guten Unterhaltung gehören mindestens zwei, auch wenn oft nur einer redet. Reden, das kann der Kleine Häuptling wie kein zweiter.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Am Lagerfeuer versammeln sich die Bewohner in geselligen Runden oder für wichtige Absprachen. Auch die Gäste werden wahlweise ans Feuer gebeten oder am Marterpfahl aufgestellt.</p><p>Verhandlungen mit Nachbarn oder Allianzen, alles findet bei reichlich Gerstensaft am Lagerfeuer statt.</p><p>Am Lagerfeuer beginnen auch die Karrieren der Kleinen Häuptlinge. Ein paar nette Worte hier, eine kleine Intrige da, schmücken mit fremden Federn und schon kann man sich den Status des kleinen Häuptlings erwerben und vielleicht eine eigene Lagerstätte gründen.</p><p>Vorsicht: Ein Lagerfeuer kann nur auf einem kleinen Bauplatz erreicht und nicht abgerissen werden!</p>",
  
            :en_US => "<p>At the campfire, inhabitants gather in sociable groups, or to make important arrangements. Guests are also either selected to join the campfire group, or arranged round it on stakes.</p><p>Negotiations with neighbours or forging alliances, it all happens – well lubricated by plenty of beer – around the campfire.</p><p>It’s also where the little chiefs’ careers begin. A couple of flattering words here, a bit of scheming there, taking credit for someone else’s bravery and hey presto! You can take on the status of little chief and maybe even start your own encampment.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
  
            :en_US => "Logger",
                
          },
          :flavour     => {
            
            :en_US => "<p>A man and his stone axe! Apart from firewood, he occasionally even brings a tree he’s felled himself back to the compound.</p>",
  
            :de_DE => "<p>Ein Mann und seine Steinaxt! Neben losem Holz bringt er ab und zu sogar einen selbst gefällten Baum mit ins Lager.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Unter Ausnutzung purer Gewalt aber auch modernster Steinwerkzeuge gelingt es dem Holzfäller, mehr oder weniger große Stämme zu fällen und zu wertvollen Rohstoffen zu verarbeiten.</p><p>Große Holzfäller lassen nur die kleinen Bäume übrig und reduzieren so die Frustration der kleineren Holzfäller, was sich sehr positiv auf ihren Ertrag auswirkt.</p>",
  
            :en_US => "<p>Using brute force combined with up-to-date stone tools, the logger can chop down quite large tree trunks and process them into valuable raw materials.</p><p>Tall loggers only leave small trees behind, reducing the frustration of smaller loggers, which has a very positive effect on their output. </p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            :target_level_formula  => "LEVEL-GREATER(LEVEL,2)-GREATER(LEVEL,10)-GREATER(LEVEL,14)", 
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
            
            :en_US => "<p>Stones – nothing but stones, everywhere! Sweaty labourers and the monotonous thwack of heavy tools. Just what you’d expect in a quarry.</p>",
  
            :de_DE => "<p>Steine, nichts als Steine! Verschwitzte Arbeiter und der monotone Schlag der schweren Werkzeuge. Genau, was man von einem Steinbruch erwartet.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Durch eine aus Sicht der Steinzeit komplizierte Kette von Arbeitsvorgängen werden im Steinbruch Steine gewonnen.</p><p>Ein richtig großer Steinbruch treibt den Wettkampf unter den Steinbrechern an und sorgt so für noch schnelleren Abbau auch bei den anderen Steinbrüchen.</p>",
  
            :en_US => "<p>Stones are quarried using a complicated – well, for the stone age!– series of work processes.</p><p>A really large quarry stimulates competition among the quarry men, which speeds up the quarrying quite a bit – even in other quarries.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            :target_level_formula  => "LEVEL-GREATER(LEVEL,2)-GREATER(LEVEL,10)-GREATER(LEVEL,14)", 
          },

        },              #   END OF Steinbruch
        {               #   Kürschner
          :id          => 12, 
          :symbolic_id => :building_furrier,
					:category    => 5,
          :db_field    => :building_furrier,
          :name        => {
            
            :de_DE => "Kürschner",
  
            :en_US => "Furrier",
                
          },
          :flavour     => {
            
            :en_US => "<p>TheA furrier know there are many ways to skin a creature. They have lovely furs and quality leatherwear that appeals to sophisticated ladies, and of course, there’s usually something tasty roasting over the fire too.</p>",
  
            :de_DE => "<p>Der Kürschner zieht dem Tier das Fell über die Ohren. Hier gibt es schöne Felle und hochwertige Lederwaren für die Dame von Welt, dazu immer mal ein leckeres Tier auf dem Feuer.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Kürschner verarbeitet Häute zu Leder und macht selbst aus den kleinsten Nagern noch ein brauchbares Fell. Und wenn tatsächlich mal ein Säbelzahntiger erlegt wird, dann zaubert er auch etwas für die Dame von Welt im Angebot.</p><p>Die Abfälle von großen Kürschnereien werden von kleineren Kürschnereien mit geringem Aufwand weiterverarbeitet und erhöht damit die Fellproduktion deutlich.</p>",
  
            :en_US => "<p>The furrier turns skins into leather – he can make a useful hide out of even the smallest rodent. And if a sabre-toothed tiger should actually be killed, he can also conjure up something for a sophisticated lady.</p><p>The waste from larger furriers’ businesses is processed by smaller furriers with lower overheads, giving a noticeable boost to fur production.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            :target_level_formula  => "LEVEL-GREATER(LEVEL,2)-GREATER(LEVEL,10)-GREATER(LEVEL,14)", 
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
            
            :en_US => "<p>Don‘t feel like brawling or smelly animals? Prefer to kill your enemy from a safe distance? Then ranged combat is right up your alley.</p>",
  
            :de_DE => "<p>Keine Lust auf Prügeleien oder stinkende Tiere? Du willst deinen Gegner am liebsten aus sicherer Entfernung töten? Dann ist Fernkampf dein Ding!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Steine, Speere und alles, was man werfen oder schießen kann, fliegt auf dem Ausbildungsgelände für Fernkämpfer durch die Luft.</p><p>Ein größerer Aufbau sorgt für eine beschleunigte Ausbildung und sogar für die Entwicklung völlig neuer Techniken, auf deren Basis neue Einheiten ausgebildet werden können.</p>",
  
            :en_US => "<p>Stones, spears and anything else that can be thrown or shot flies through the air at the long-range combat training ground.</p><p>The larger the grounds, the faster the training – as well as the development of completely new techniques which in turn, form the basis of the training of new units.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
  
            :en_US => "Smelly Barn",
                
          },
          :flavour     => {
            
            :en_US => "<p>Smelly animals and a kitty cat. Life on a stud farm couldn’t be better.</p>",
  
            :de_DE => "<p>Stinkende Tiere und eine kleine Katze. Ein Leben auf dem Ponyhof könnte nicht schöner sein.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kein Ort in der Siedlung stinkt so sehr wie der Stall. Nicht weiter verwunderlich, werden hier doch Straußen, Säbelzahntiger, kleine Dinosaurier und als Maskottchen eine Katze gehalten.</p><p>Vorrangig werden die Tiere dressiert und den Reitern der richtige Umgang beigebracht. Die wenigsten Reiter führen im Kampf selber Waffen, um sich ganz auf das Reiten zu konzentrieren. Das Reittier ist die Waffe!</p><p>Größere Ställe stinken noch stärker, beschleunigen aber auch die Ausbildung und können noch stärkere Tiere abrichten.</p>",
  
            :en_US => "<p>The barn smells like no other building in the settlement. Not surprisingly, it’s where ostriches, sabre-toothed tigers and little dinosaurs are kept – as well as a kitty cat as mascot.</p><p>The animals are trained and the riders are taught how to handle them. Very few riders carry weapons into battle, as they have to concentrate on riding. Their mount is their weapon!</p><p>Big barns smell even worse, but that speeds up the training and they can drill bigger animals.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
  
            :en_US => "Raw Materials Store",
                
          },
          :flavour     => {
            
            :en_US => "<p>Stone containers, dinosaur cranes and, more recently, carts. A little style is classy! </p>",
  
            :de_DE => "<p>Steincontainer, Saurierkräne und seit neuestem, Karren. Soviel Stil muss sein!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Steinzeitliches Logistikzentrum zum Lagern und Versenden von Rohstoffen. Je größer das Lager, desto mehr Karren können versendet werden.</p><p>Ein Rohstofflager erhöht die maximale Lagermenge und ermöglicht den Handel mit anderen Spielern. Mehere Rohstofflager wirken kumulativ und  erhöhen sowohl die Lager- als auch die Handelsmenge.</p>",
  
            :en_US => "<p>Stone-age logistics centre where raw materials are stored and dispatched. The bigger the store, the more carts can be dispatched.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*1*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.05)))",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*1*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.05)))",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*0.5*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.05)))",
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
  
            :en_US => "Wind-proof Hut",
                
          },
          :flavour     => {
            
            :en_US => "<p>A fireplace, neatly-fenced front garden and a front doormat. A dream!</p>",
  
            :de_DE => "<p>Ein Feuerplatz, eingezäunter Vorgarten und eine Fußmatte vor der Tür. Ein Traum!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>In der fortschrittlichen winddichten Hütten wohnen die verdienten sprich fleißigen Bewohner. Diese Hütte hat neben Wände, die diesen Namen auch verdienen, sogar einen Feuerplatz, wodurch die Bewohner noch zufriedener werden. Und sie ist natürlich größer, denn seien wir mal ehrlich, zwei Arbeiter sind immer besser als ein zufriedener.</p>",
  
            :en_US => "<p>These modern, wind-proof huts are where the deserving – that is, hard-working – dwellers live. Apart from walls that can actually be called walls, there is even a fireplace which make dwellers even more satisfied. And of course, wind-proof huts are bigger because, let’s be honest, two grumpy workers are still better than one happy one.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
  
            :en_US => "Central Command Post",
                
          },
          :flavour     => {
            
            :en_US => "<p>Coordinating armies is the art of war. Even if all armies are dispatched in the same direction with the order to “hit ‘em hard”.</p>",
  
            :de_DE => "<p>Die Koordination von Armeen ist die hohe Kunst des Krieges. Selbst wenn alle Armeen nur in eine Richtung mit dem Auftrag „immer feste druff“ geschickt werden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein paar Äste zwischen drei Bäume gespannt, darauf Rinde und Blätter und fertig ist das Sonnensegel. Ein schöner großer Sitz für den Häuptling und fertig ist der Kommandoposten. Hier wird die Taktik bestimmt und Befehle erteilt. Meist immer derselbe: Haut sie feste!</p><p>Der Kommandoposten erhöht auf den Leveln 1, 10 und 20 die maximale Anzahl an Armeen. Zudem wird die Produktionszeit aller Einheiten gesenkt.</p>",
  
            :en_US => "<p>A couple of branches stretched between three trees, a bit of bark and some leaves, and there’s your awning. A nice big seat for the chief, and hey presto, you’ve got your command post. This is where tactics are decided and orders given. Mostly the same order: “Hit ‘em hard!” The command post increases a settlement’s command points at level 1, 10 and 20. It also decreases the time spent on training new units.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            
            :en_US => "<p>Copper shines even in its unprocessed state, but it can only be made into jewellery once it is smelted. They make the occasional implement out of it too.</p>",
  
            :de_DE => "<p>Kupfer glitzert zwar auch schon im Rohzustand, aber erst nach dem Schmelzen kann es zu Schmuck verarbeitet werden. Ab und zu stellt man auch hilfreiche Werkzeuge damit her.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kupfer ist DIE Entdeckung der Steinzeit und führte zu schönerem Schmuck und tödlicheren Waffen und auch dem ein oder anderen Fortschritt bei Werkzeugen.</p><p>Der Kupferschmelzer ermöglicht den Fortschritt in die Kupferzeit und den Zugriff auf neue fortschrittlichere Gebäude. Ein Kupferschmelzer kann nur auf einem kleinen Bauplatz gebaut und nicht wieder abgerissen werden.</p>",
  
            :en_US => "<p>Copper is THE discovery in the copper-stone age, leading to more attractive jewellery and more deadly weapons, as well as some progress in making implements.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            
            :en_US => "<p>Field camps turn encampments into military support units. Despite all the talk about the safety that field camps offer storage compounds, it’s the field camps that seem to have a magical attraction for enemies.</p>",
  
            :de_DE => "<p>Feldlager verwandeln Lagerstätten mit größeren und auch einer Armee mehr in militärische Stützpunkte. Durch all das Gerede über die Sicherheit, die Feldlager für die Lagerstätte bieten, ziehen Feldlager Feinde erst recht an.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Mit Bau des Feldlagers ist es endgültig klar: „Wir sind nicht zum Spass hier, wir wollen kämpfen!“</p><p>Das Feldlager erhöht die Garnison und die Armee um 300 Einheiten plus 50 pro Level auf Level 1-10 und 20 pro Level auf Level 11-20.</p><p>Auf Level 10 ermöglicht das Feldlager einen zweiten Kommandopunkt.</p>",
  
            :en_US => "<p>Once a field camp is built, the message is clear: „We’re here to fight, not have fun!”</p><p>A field camp means more fighters can be deployed, 300 plus 50 per level at levels 1-10 and 20 per level at levels 11-20.</p><p>At level 10 it increases a settlement’s command points by one.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => false,
          :demolishable=> true,
          :destructable=> false,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => true,
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
  
            :en_US => "Crazy Furrier",
                
          },
          :flavour     => {
            
            :en_US => "<p>It is not a good idea to get too close to a crazy furrier armed with a copper knife. No fighter can handle a weapon as well as a crazy furrier.</p>",
  
            :de_DE => "<p>Einem Kürschner mit Kupfermesser sollte man besser nicht zu nahe kommen. Kein Krieger kann so gut mit einer Waffe umgehen wie ein verrückter Kürschner.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Kupfermesser waren ein Geschenk der Götter. Zumindest glauben das die Kürschner, die mit den Kupfermessern herausragende Mode entwerfen. Leider mit den bekannten Nebeneffekten: Fächer wedeln, nasale Stimme und sonstigem Irrsinn.</p><p>Genau deswegen sind die verrückten Kürschner natürlich große Vorbilder für andere Kürschner.</p>",
  
            :en_US => "<p>The copper knife was a gift from the gods. At least, that’s what the furriers believe who use their copper knives to create gorgeous fashions. Sadly, they suffer from the usual unfortunate side-effects: vigorous fanning, a high-pitched nasal voice and other limp-wristed craziness. This is why crazy furriers set such a good example for other furriers.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            1 => 'FLOOR((LESS(LEVEL,7)*(41.4*POW(2.7,0.55*LEVEL))+GREATER(LEVEL,6)*LESS(LEVEL,11)*(3237.5*POW(LEVEL-6,2)-6572.5*(LEVEL-6)+5512.5)+GREATER(LEVEL,10)*(-250*POW(LEVEL,2)+6130*LEVEL+28626))*0.5)',
            0 => 'FLOOR((LESS(LEVEL,7)*(41.4*POW(2.7,0.55*LEVEL))+GREATER(LEVEL,6)*LESS(LEVEL,11)*(3237.5*POW(LEVEL-6,2)-6572.5*(LEVEL-6)+5512.5)+GREATER(LEVEL,10)*(-250*POW(LEVEL,2)+6130*LEVEL+28626))*0.5)',
            2 => 'FLOOR((LESS(LEVEL,7)*(41.4*POW(2.7,0.55*LEVEL))+GREATER(LEVEL,6)*LESS(LEVEL,11)*(3237.5*POW(LEVEL-6,2)-6572.5*(LEVEL-6)+5512.5)+GREATER(LEVEL,10)*(-250*POW(LEVEL,2)+6130*LEVEL+28626))*0.25)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*1)',
          :production  => [
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)*0.5*MIN(2.25,MAX(1.5,1.5+0.25*(LEVEL-7)))+0.5)",
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
  
            :en_US => "Logger with Copper Axe",
                
          },
          :flavour     => {
            
            :en_US => "<p>A man and his copper axe! Although the copper axes always bend, he actually does manage to bring home trees he has felled himself, as well as some brushwood.</p>",
  
            :de_DE => "<p>Ein Mann und seine Kupferaxt! Obwohl die Kupferaxt ständig verbiegt, bringt er tatsächlich selbst gefällte Bäume und weniger loses Gestrüpp mit.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kupferäxte fällen einen Baum deutlich schneller. Leider sind Kupferäxte auch sehr reparaturbedürftig. Dennoch sind Holzfäller effektiver und leiten ab einer bestimmten Größe auch die normalen Holzfäller zu erhöhtem Bäume fällen an.</p>",
  
            :en_US => "<p>Copper axes fell trees much faster. Unfortunately, copper axes constantly need repairing. But loggers who use them are more efficient and motivate ordinary loggers to fell more trees, though generally smaller ones.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            0 => 'FLOOR((LESS(LEVEL,7)*(41.4*POW(2.7,0.55*LEVEL))+GREATER(LEVEL,6)*LESS(LEVEL,11)*(3237.5*POW(LEVEL-6,2)-6572.5*(LEVEL-6)+5512.5)+GREATER(LEVEL,10)*(-250*POW(LEVEL,2)+6130*LEVEL+28626))*1)',
            1 => 'FLOOR((LESS(LEVEL,7)*(41.4*POW(2.7,0.55*LEVEL))+GREATER(LEVEL,6)*LESS(LEVEL,11)*(3237.5*POW(LEVEL-6,2)-6572.5*(LEVEL-6)+5512.5)+GREATER(LEVEL,10)*(-250*POW(LEVEL,2)+6130*LEVEL+28626))*0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*1)',
          :production  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)*MIN(2.25,MAX(1.5,1.5+0.25*(LEVEL-7)))+0.5)",
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
  
            :en_US => "Age-old Stone Quarry",
                
          },
          :flavour     => {
            
            :en_US => "<p>In the copper-stone age, you’d expect workers to have copper pickaxes. But the workers preferred to invest their copper in jewellery for their wives. Apparently a better investment, as the grateful women rewarded them lavishly.</p>",
  
            :de_DE => "<p>In der Kupferzeit würde man erwarten, kupferne Spitzhacken bei den Arbeitern zu finden. Doch die Arbeiter haben das Kupfer lieber in Schmuck für ihre Frauen investiert. Offensichtlich die bessere Investition, denn die Belohnung der glücklichen Frauen ist umso größer.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Wie in Steinbrüchen mit Beginn der Kupferzeit mehr Steine abgebaut worden konnten, bleibt rätselhaft. Denn nur hier wurden keine Kupferwerkzeuge benutzt. Aber trotzdem ging der Abbau spürbar schneller.</p><p>Ab einer gewissen Größe werden die Arbeiter noch schneller und treiben sogar Arbeiter in anderen Steinbrüchen zu schnellerer Arbeit an.</p>",
  
            :en_US => "<p>How they managed to excavate so much stone from the quarries in the copper-stone age is a mystery. They were the only ones who didn’t have copper implements. But still, excavation was noticeably faster.</p><p>Workers of a certain size and upwards were even faster, encouraging the workers in other quarries to work faster.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
            0 => 'FLOOR((LESS(LEVEL,7)*(41.4*POW(2.7,0.55*LEVEL))+GREATER(LEVEL,6)*LESS(LEVEL,11)*(3237.5*POW(LEVEL-6,2)-6572.5*(LEVEL-6)+5512.5)+GREATER(LEVEL,10)*(-250*POW(LEVEL,2)+6130*LEVEL+28626))*0.5)',
            1 => 'FLOOR((LESS(LEVEL,7)*(41.4*POW(2.7,0.55*LEVEL))+GREATER(LEVEL,6)*LESS(LEVEL,11)*(3237.5*POW(LEVEL-6,2)-6572.5*(LEVEL-6)+5512.5)+GREATER(LEVEL,10)*(-250*POW(LEVEL,2)+6130*LEVEL+28626))*1)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*1)',
          :production  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR((0.0079*POW(LEVEL,4)+0.1167*POW(LEVEL,3)-1.025*POW(LEVEL,2)+6.959*LEVEL-2.3333)*MIN(2.25,MAX(1.5,1.5+0.25*(LEVEL-7)))+0.5)",
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
            
            :en_US => "<p>Warriors or soldiers of any kind should be kept apart from the ordinary working population. In the garrison they can bash each others’ heads in and leave the poor settlement dwellers in peace.</p>",
  
            :de_DE => "<p>Krieger aller Art sollten getrennt von der normalen arbeitenden Bevölkerung gehalten werden. In der Garnison können sie sich gegenseitig die Schädel einschlagen und die armen Siedlungsbewohner in Ruhe lassen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Mit größere Garnisonen können größere Armeen aufgestellt werden. Jedes Level der Garnison erhöht die maximale Anzahl der Einheiten in der Garnison und in den Armeen um 25.</p>",
  
            :en_US => "<p>Bigger garrisons lead to … bigger armies. Well, who would have thought it?! Field armies also benefit from the increased discipline. And mean that bigger armies can be deployed in the field.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(5*POW(LEVEL,2)+3*LEVEL+43.3)+(MIN(LEVEL,11)-MIN(LEVEL,10))*20+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
  
            :en_US => "Raw Materials Store with Copper Carts",
                
          },
          :flavour     => {
            
            :en_US => "<p>Stone containers, dinosaur cranes, and, more recently, copper carts. At last raw materials can be transported in style.</p>",
  
            :de_DE => "<p>Steincontainer, Saurierkräne und, seit neuestem, Kupferkarren. Endlich können Rohstoffe mit Stil transportiert werden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kupferkarren! DAS Statussymbol für den Häuptling. Neben den Karren gibt es auch größeren Lagerraum, aber wen interessiert das neben in der Sonne blinkenden Kupferkarren.</p>",
  
            :en_US => "<p>Copper carts! THE status symbol for a chieftain. There is also a bigger store room, but who cares when you see those shiny copper carts gleaming in the sunlight.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17)*1.1+0.5)",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
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
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*1*1.75*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.05)))",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*1*1.75*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.05)))",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR(((MIN(LEVEL, 1)-MIN(LEVEL-1,1))*20 + POW(LEVEL,2) * 80)*0.5*1.75*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.05)))",
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
            
            :en_US => "<p>The ceremonies and regular sacrifices carried out on the altar are intended to appease the gods. An encampment blessed by the gods cannot be conquered by enemies.</p>",
  
            :de_DE => "<p>Die auf dem Ritualstein durchgeführten Zeremonien und regelmäßigen Opfergaben besänftigen die Götter. Eine derart von den Göttern gesegnete Lagerstätte kann von Feinden nicht erobert werden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Ritualstein ist ein von Fackeln umringter von blutigen Opfergaben verschmierter und mit den Gaben der Felder und den Köpfen der Feinde dekorierter Steintisch. Dieser Steintisch begeistert auch die Götter. Zumindest ist die Lagerstätte mit einem Ritualstein vor einer feindlichen Übernahme sicher. Wenn das kein Wink der  Götter ist!</p>",
  
            :en_US => "<p>The altar is a stone table surrounded by torches, smeared with blood from sacrificial offerings and decorated with gifts of the field and the heads of enemies. This stone table also impresses the gods. At least, an encampment with an altar is safe from being conquered by enemies. If that isn’t a sign from the gods, then what is?</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => false,
          :demolishable=> true,
          :destructable=> false,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => true,
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
  
            :en_US => "Meeting Place",
                
          },
          :flavour     => {
            
            :en_US => "<p>This is where all the important people in the compound meet every evening to discuss important issues. Like for instance, how to solve the beer shortage.</p>",
  
            :de_DE => "<p>Hier treffen sich alle wichtigen Personen der Lagerstätte jeden Abend, um die wichtigen Probleme zu besprechen. Zum Beispiel, wie man die Bierflaute lösen kann.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Versammlungsplatz ist der zentrale Ort einer neu gegründeten Lagerstätte. Ein großer Pfahl mit den Insignien der Macht sowie ein bisschen Platz für die Ablage von ein paar Rohstoffen.</p><p>Der Ausbau des Versammlungsplatzes ermöglicht den Bau von zusätzlichen Gebäuden in der gründbaren Lagerstätte.</p>",
  
            :en_US => "<p>The meeting place is in the middle of the compound. An area by chance left vacant, with enough space for a few raw materials and for the dwellers’ gatherings.</p>",
                
          },
          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,8)-MIN(LEVEL,8))*(0.6245*POW(LEVEL,2.2))+(MIN(LEVEL,8)-MIN(LEVEL,7))*(5*POW((LEVEL-7),2)+10*(LEVEL-7)+50)+(MIN(LEVEL,11)-MIN(LEVEL,10))*17+0.5)",
  
          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_level=> 0,
          :takeover_destroy  => false,
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
        {               #   Trainingshöhle
          :id          => 27, 
          :symbolic_id => :building_training_cave,
					:category    => 5,
          :db_field    => :building_training_cave,
          :name        => {
            
            :de_DE => "Trainingshöhle",
  
            :en_US => "Training Cave",
                
          },
          :flavour     => {
            
            :de_DE => "<p>Ruhig, kühl, feucht - ein perfekter Platz für jeden Halbgott, um sich auszuruhen und weiterzubilden.</p><p>Gerüchte über ein weitreichendes Höhlennetzwerk, in dem Monster hausen, die vom Halbgott zu Trainingszwecken missbraucht werden, gehen um. Aber keiner der Siedlungsbewohner traute sich bisher selber nachzuschauen.</p>",
  
            :en_US => "<p>Quiet, cool, humid - a perfect place for every demigod to relax and educate himself.</p><p>Rumors have it that there is a far reaching cave network, in which mosters dwell beneath the training cave. These monsters are abused for training purposes by the demigod. But no one is brave enough to check for himself.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>In der Trainingshöhle gibt es verschiedene Trainingsmöglichkeiten für angehende Halbgötter. Große Steine zum Heben, ein fast endloses Labyrinth, Spiegel, in denen man sich herrlich erschrecken kann, und natürlich die ein oder andere Ratte, die eingefangen werden will.</p>",
  
            :en_US => "<p>The Training Cave offers different training possibilities for would-be Demigods. Huge Stones to lift, a almost endless labyrinth, mirrors that can scare you and of course a few rats to catch.</p>",
                
          },
          :hidden      => 0,

	        :population  => "LEVEL",
  
          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_level=> 1,
          :takeover_destroy  => false,
          :experience_factor => 8,

          :experience_production => 'CEIL((LESS(LEVEL,11)*CEIL((LEVEL+1)*LEVEL*5)+GREATER(LEVEL,10)*CEIL((LEVEL-10)*(LEVEL-10)*25+550))/24.0)',

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 6,

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
            0 => 'FLOOR(CEIL((LESS(LEVEL,11)*CEIL((LEVEL+1)*LEVEL*5)+GREATER(LEVEL,10)*CEIL((LEVEL-10)*(LEVEL-10)*25+550))/24.0)*10*24*1.5+0.5)',
            1 => 'FLOOR(CEIL((LESS(LEVEL,11)*CEIL((LEVEL+1)*LEVEL*5)+GREATER(LEVEL,10)*CEIL((LEVEL-10)*(LEVEL-10)*25+550))/24.0)*10*24*1.5+0.5)',
            2 => 'FLOOR(CEIL((LESS(LEVEL,11)*CEIL((LEVEL+1)*LEVEL*5)+GREATER(LEVEL,10)*CEIL((LEVEL-10)*(LEVEL-10)*25+550))/24.0)*10*24*1.5+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(1800+200*LEVEL)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*3+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {
    
          },

        },              #   END OF Trainingshöhle
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
              
              :takeover_level_factor  => 1,
              :options   => [
              0,
              
              ],
            },
            1 => {
              :max_level => 15,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              1,
              
              ],
            },
            2 => {
              :max_level => 15,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              1,
              
              ],
            },
            3 => {
              :max_level => 15,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
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
              
              :takeover_level_factor  => 1,
              :options   => [
              3,
              
              ],
            },
            1 => {
              :max_level => 20,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              4,
              5,
              
              ],
            },
            2 => {
              :max_level => 20,
              
              :building  => 5,
              
              :level  => 1,
              
              :takeover_level_factor  => 1,
              :options   => [
              4,
              5,
              
              ],
            },
            3 => {
              :max_level => 20,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              4,
              5,
              
              ],
            },
            4 => {
              :max_level => 20,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              4,
              5,
              
              ],
            },
            5 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            6 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            7 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            8 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            9 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            10 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            11 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            12 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            13 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            14 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            15 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            16 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            17 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            18 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            19 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            20 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            21 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            22 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            23 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            24 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            25 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            26 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            27 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            28 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            29 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            30 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            31 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            32 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            33 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            34 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            35 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            36 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            37 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            38 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            39 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              6,
              
              ],
            },
            40 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
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
              
              :takeover_level_factor  => 1,
              :options   => [
              3,
              
              ],
            },
            1 => {
              :max_level => 20,
              
              :building  => 26,
              
              :level  => 1,
              
              :takeover_level_factor  => 1,
              :options   => [
              4,
              5,
              
              ],
            },
            2 => {
              :max_level => 20,
              
              :level  => 0,
              
              :takeover_level_factor  => 0,
              :options   => [
              4,
              5,
              
              ],
            },
            3 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              
              ],
            },
            4 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              
              ],
            },
            5 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              
              ],
            },
            6 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              
              ],
            },
            7 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              
              ],
            },
            8 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              
              ],
            },
            9 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              
              ],
            },
            10 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              
              ],
            },
            11 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              
              ],
            },
            12 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              5,
              
              ],
            },
            
          },



        },              #   END OF Lagerstätte
      ],                # END OF SETTLEMENT TYPES

# ## VICTORY TYPES ########################################################
  
      :victory_types => [  # ALL VICTORY TYPES

        {               #   Herrschaftssieg
          :id          => 0, 
          :symbolic_id => :victory_domination,
          :name        => {
            
            :de_DE => "Herrschaftssieg",
  
            :en_US => "Domination Victory",
                
          },
          :description => {
            
            :de_DE => "Für einen Herrschaftssieg muss eine Allianz einen bestimmten Anteil aller Regionen der Karte beherrschen, d.h. die Festungen der Regionen müssen einem Allianzmitglied gehören.",
  
            :en_US => "For a domination victory an alliance has to rule an certain proprtion of all regions, i.e. the fortress of this regions have to be owned by alliance members.",
                
          },

          :condition   => {

            :required_regions_ratio => '1+(0.005*(MIN(88-DAYS,0)))',
            :duration => 5,

          },

        },              #   END OF Herrschaftssieg
      ],                # END OF VICTORY TYPES

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

