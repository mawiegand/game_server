# encoding: utf-8  

require 'active_model'

# A module containing the game rules of a particular game instance using the
# Augmented Worlds Engine. The rules define all entities and their attributes 
# in the game.
#
# This particular file does hold the following set of rules:
# Game:    Wack-A-Doo
# Branch:  development (alpha)
# Version: 1.6.3
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

  attr_accessor :version, :app_control, :battle, :domains, :character_creation, :building_conversion, :building_experience_formula,
    :resource_types, :unit_types, :building_types, :science_types, :assignment_types, :special_assignment_types, :special_assignments, :unit_categories, :building_categories,
    :queue_types, :settlement_types, :artifact_types, :victory_types, :construction_speedup, :training_speedup, :facebook_user_stories,
    :artifact_initiation_speedup, :character_ranks, :alliance_max_members, :artifact_count, :trading_speedup, :slot_bubbles, :special_offer,
    :avatar_config, :change_character_name, :change_character_gender, :change_settlement_name, :resource_exchange, :treasure_types
  
  def attributes 
    { 
      'version'                     => version,
      'battle'                      => battle,
      'app_control'                 => app_control,
      'domains'                     => domains,
      'character_creation'          => character_creation,
      'construction_speedup'        => construction_speedup,
      'training_speedup'            => training_speedup,
      'trading_speedup'             => trading_speedup,
      'avatar_config'               => avatar_config,
      'change_character_name'       => change_character_name,
      'change_character_gender'     => change_character_gender,
      'change_settlement_name'      => change_settlement_name,
      'resource_exchange'           => resource_exchange,
      'building_conversion'         => building_conversion,
      'building_experience_formula' => building_experience_formula,
      'unit_categories'             => unit_categories,
      'building_categories'         => building_categories,
      'unit_types'                  => unit_types,
      'resource_types'              => resource_types,
      'building_types'              => building_types,
      'science_types'               => science_types,  
      'assignment_types'            => assignment_types,  
      'special_assignment_types'    => special_assignment_types,
      'treasure_types'              => treasure_types,
      'special_assignments'         => special_assignments,
      'slot_bubbles'                => slot_bubbles,
      'special_offer'               => special_offer,
      'settlement_types'            => settlement_types,
      'artifact_types'              => artifact_types,  
      'victory_types'               => victory_types,  
      'queue_types'                 => queue_types,  
      'character_ranks'             => character_ranks,
      'alliance_max_members'        => alliance_max_members,
      'artifact_count'              => artifact_count,
      'artifact_initiation_speedup' => artifact_initiation_speedup,
      'facebook_user_stories'       => facebook_user_stories,
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
      root = self.class.model_name.element if root
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
  
      :version => { :major => 1,
                    :minor => 6,
                    :build => 3,
      },
      :app_control => {
        :debug_tracking                         => 1,
        :startscreen                            => 'map',
        :special_offer_dialog                   => 1,
        :special_offer_required_finished_quests => 24,
        :facebook_user_stories                  => 1,
      },
      :battle => {
        :calculation => {
          :round_time => 20,
          :retreat_probability => 0.5,
          },
      },
  
      :domains => [

        {
          :id          => 0,
          :symbolic_id => :character,
        },

        {
          :id          => 1,
          :symbolic_id => :settlement,
        },

        {
          :id          => 2,
          :symbolic_id => :alliance,
        },

      ],

      :character_creation => {
        :start_resources => {
          1 => 200,
            0 => 200,
            2 => 200,
            3 => 0,
            
        },
      },
      :building_conversion => {
        :cost_factor => 0.3,
        :time_factor => 0.3,
      },
      :building_experience_formula => '2*LEVEL',
      :alliance_max_members => 13,
      :special_assignments  => {
        :idle_probability => 0.2,
        :idle_time => 3600,
      },
      :slot_bubbles => {
        :idle_probability => 'LESS(LEVEL,11)*(1-(1-(1-(0.1+(0.01*LEVEL/2)))))+GREATER(LEVEL,10)*(1-0.05)',
        :resource_percentage => '10+LEVEL*0.25',
        :xp_amount => 5,
        :xp_probability => 0.1,
        :test_min_duration => 3000,
        :test_max_duration => 4200,
      },
      :special_offer => {
  
        :outpost => {
1 => {
            :id          => 24,
            :level       => 5,
          },
2 => {
            :id          => 26,
            :level       => 1,
          },
3 => {
            :id          => 1,
            :level       => 4,
          },
4 => {
            :id          => 1,
            :level       => 5,
          },
5 => {
            :id          => 1,
            :level       => 6,
          },
6 => {
            :id          => 1,
            :level       => 7,
          },

        },

        :start_resources => {
          3 => 300,
            0 => 500,
            1 => 500,
            2 => 500,
            
        },

        :production_bonus  => [

          {
            :bonus_offer_id  => 1,
            :duration        => 96,
          },

          {
            :bonus_offer_id  => 2,
            :duration        => 96,
          },

          {
            :bonus_offer_id  => 3,
            :duration        => 96,
          },

        ],

        :construction_bonus  => {
          :amount    => 1,
          :duration  => 96,
        },

        :display_strings => {

          :de_DE => [

            "Zweite Siedlung:\nLagerstaette",

            "1500 Rohstoffe einmalig\n150 Rohstoffe pro Stunde\n15% Produktionsbonus",

            "300 Goldkröten",

            "Halbierte Bauzeit fuer 4 Tage",

          ],

          :en_US => [

            "SecondSettlement:\nCamp",

            "1500 Resources\n150 Resources per hour\n15% Production Bonus",

            "300 Golden Frogs",

            "Halved Construction Time for 4 days",

          ],

        },


      },
      :artifact_count => 6,
  
# ## CONSTRUCTION SPEEDUP ####################################################

      :construction_speedup => [  # ALL CONSTRUCTION SPEEDUPS

        {               #   less than (1.0/60.0) hours
          :resource_id => 3,
          :amount      => 0,
          :hours       => (1.0/60.0),
        },              #   END OF (1.0/60.0) hours

        {               #   less than 0.5 hours
          :resource_id => 3,
          :amount      => 1,
          :hours       => 0.5,
        },              #   END OF 0.5 hours

        {               #   less than 1 hours
          :resource_id => 3,
          :amount      => 2,
          :hours       => 1,
        },              #   END OF 1 hours

        {               #   less than 3 hours
          :resource_id => 3,
          :amount      => 4,
          :hours       => 3,
        },              #   END OF 3 hours

        {               #   less than 7 hours
          :resource_id => 3,
          :amount      => 8,
          :hours       => 7,
        },              #   END OF 7 hours

        {               #   less than 12 hours
          :resource_id => 3,
          :amount      => 12,
          :hours       => 12,
        },              #   END OF 12 hours

        {               #   less than 18 hours
          :resource_id => 3,
          :amount      => 16,
          :hours       => 18,
        },              #   END OF 18 hours

        {               #   less than 30 hours
          :resource_id => 3,
          :amount      => 24,
          :hours       => 30,
        },              #   END OF 30 hours

        {               #   less than 150 hours
          :resource_id => 3,
          :amount      => 36,
          :hours       => 150,
        },              #   END OF 150 hours

        {               #   less than 9999 hours
          :resource_id => 3,
          :amount      => 48,
          :hours       => 9999,
        },              #   END OF 9999 hours

      ],                # END OF CONSTRUCTION SPEEDUP

# ## TRAINING SPEEDUP ##########################################################

      :training_speedup => [  # ALL TRAINING SPEEDUPS

        {               #   less than 0.5 hours
          :resource_id => 3,
          :amount      => 1,
          :hours       => 0.5,
        },              #   END OF 0.5 hours

        {               #   less than 3 hours
          :resource_id => 3,
          :amount      => 2,
          :hours       => 3,
        },              #   END OF 3 hours

        {               #   less than 6 hours
          :resource_id => 3,
          :amount      => 4,
          :hours       => 6,
        },              #   END OF 6 hours

        {               #   less than 11 hours
          :resource_id => 3,
          :amount      => 6,
          :hours       => 11,
        },              #   END OF 11 hours

        {               #   less than 17 hours
          :resource_id => 3,
          :amount      => 8,
          :hours       => 17,
        },              #   END OF 17 hours

        {               #   less than 36 hours
          :resource_id => 3,
          :amount      => 12,
          :hours       => 36,
        },              #   END OF 36 hours

        {               #   less than 56 hours
          :resource_id => 3,
          :amount      => 16,
          :hours       => 56,
        },              #   END OF 56 hours

        {               #   less than 96 hours
          :resource_id => 3,
          :amount      => 24,
          :hours       => 96,
        },              #   END OF 96 hours

        {               #   less than 192 hours
          :resource_id => 3,
          :amount      => 40,
          :hours       => 192,
        },              #   END OF 192 hours

        {               #   less than 9999 hours
          :resource_id => 3,
          :amount      => 60,
          :hours       => 9999,
        },              #   END OF 9999 hours

      ],                # END OF TRAINING SPEEDUP

# ## ARTIFACT INITIATION SPEEDUP #############################################

      :artifact_initiation_speedup => [  # ALL ARTIFACT INITIATION SPEEDUPS

        {               #   less than 3 hours
          :resource_id => 3,
          :amount      => 1,
          :hours       => 3,
        },              #   END OF 3 hours

        {               #   less than 6 hours
          :resource_id => 3,
          :amount      => 2,
          :hours       => 6,
        },              #   END OF 6 hours

        {               #   less than 12 hours
          :resource_id => 3,
          :amount      => 4,
          :hours       => 12,
        },              #   END OF 12 hours

        {               #   less than 18 hours
          :resource_id => 3,
          :amount      => 6,
          :hours       => 18,
        },              #   END OF 18 hours

        {               #   less than 24 hours
          :resource_id => 3,
          :amount      => 8,
          :hours       => 24,
        },              #   END OF 24 hours

        {               #   less than 36 hours
          :resource_id => 3,
          :amount      => 12,
          :hours       => 36,
        },              #   END OF 36 hours

        {               #   less than 48 hours
          :resource_id => 3,
          :amount      => 16,
          :hours       => 48,
        },              #   END OF 48 hours

        {               #   less than 72 hours
          :resource_id => 3,
          :amount      => 20,
          :hours       => 72,
        },              #   END OF 72 hours

        {               #   less than 96 hours
          :resource_id => 3,
          :amount      => 30,
          :hours       => 96,
        },              #   END OF 96 hours

        {               #   less than 9999 hours
          :resource_id => 3,
          :amount      => 40,
          :hours       => 9999,
        },              #   END OF 9999 hours

      ],                # END OF ARTIFACT INITIATION SPEEDUP

# ## TRADING INITIATION SPEEDUP #############################################

      :trading_speedup => {
        :resource_id => 3,
        :amount      => 1,
      },

# ## AVATAR CONFIG ###################################################

      :avatar_config => {
      
        :male => {
        
          :chains => {
            :max       => 0,
            :optional  => true,
            :num_chars => 1,
            :name      => {
              
            :en_US => "Necklace",
  
            :de_DE => "Kette",
  
            },
          },
        
          :eyes => {
            :max       => 3,
            :optional  => false,
            :num_chars => 2,
            :name      => {
              
            :en_US => "Eyes",
  
            :de_DE => "Augen",
  
            },
          },
        
          :hairs => {
            :max       => 5,
            :optional  => true,
            :num_chars => 2,
            :name      => {
              
            :en_US => "Hair",
  
            :de_DE => "Haare",
  
            },
          },
        
          :mouths => {
            :max       => 4,
            :optional  => false,
            :num_chars => 2,
            :name      => {
              
            :en_US => "Mouth",
  
            :de_DE => "Mund",
  
            },
          },
        
          :heads => {
            :max       => 1,
            :optional  => false,
            :num_chars => 1,
            :name      => {
              
            :en_US => "Head",
  
            :de_DE => "Kopf",
  
            },
          },
        
          :beards => {
            :max       => 6,
            :optional  => true,
            :num_chars => 2,
            :name      => {
              
            :en_US => "Beard",
  
            :de_DE => "Bart",
  
            },
          },
        
          :veilchens => {
            :max       => 4,
            :optional  => true,
            :num_chars => 1,
            :name      => {
              
            :en_US => "Shiner",
  
            :de_DE => "Veilchen",
  
            },
          },
        
          :tattoos => {
            :max       => 3,
            :optional  => true,
            :num_chars => 2,
            :name      => {
              
            :en_US => "Tattoo",
  
            :de_DE => "Tattoo",
  
            },
          },
                
        },
      
        :female => {
        
          :chains => {
            :max       => 2,
            :optional  => true,
            :num_chars => 1,
            :name      => {
              
            :en_US => "Necklace",
  
            :de_DE => "Kette",
  
            },
          },
        
          :eyes => {
            :max       => 4,
            :optional  => false,
            :num_chars => 2,
            :name      => {
              
            :en_US => "Eyes",
  
            :de_DE => "Augen",
  
            },
          },
        
          :hairs => {
            :max       => 11,
            :optional  => true,
            :num_chars => 2,
            :name      => {
              
            :en_US => "Hair",
  
            :de_DE => "Haare",
  
            },
          },
        
          :mouths => {
            :max       => 5,
            :optional  => false,
            :num_chars => 2,
            :name      => {
              
            :en_US => "Mouth",
  
            :de_DE => "Mund",
  
            },
          },
        
          :heads => {
            :max       => 1,
            :optional  => false,
            :num_chars => 1,
            :name      => {
              
            :en_US => "Head",
  
            :de_DE => "Kopf",
  
            },
          },
        
          :beards => {
            :max       => 0,
            :optional  => true,
            :num_chars => 2,
            :name      => {
              
            :en_US => "Beard",
  
            :de_DE => "Bart",
  
            },
          },
        
          :veilchens => {
            :max       => 0,
            :optional  => true,
            :num_chars => 1,
            :name      => {
              
            :en_US => "Shiner",
  
            :de_DE => "Veilchen",
  
            },
          },
        
          :tattoos => {
            :max       => 3,
            :optional  => true,
            :num_chars => 2,
            :name      => {
              
            :en_US => "Tattoo",
  
            :de_DE => "Tattoo",
  
            },
          },
                
        },
      
      },

# ## CHANGE CHARACTER NAME ###################################################

      :change_character_name => {
        :free_changes => 2,
        :resource_id  => 3,
        :amount       => 20,
      },

# ## CHANGE CHARACTER GENDER ###################################################

      :change_character_gender => {
        :free_changes => 2,
        :resource_id  => 3,
        :amount       => 20,
      },

# ## RESOURCE EXCHANGE ###################################################

      :resource_exchange => {
        :resource_id  => 3,
        :amount       => 2,
      },

# ## RESOURCE TYPES ##########################################################
  
      :resource_types => [  # ALL RESOURCE TYPES

        {               #   resource_stone
          :id          => 0, 
          :symbolic_id => :resource_stone,
          :stealable   => false,
          :taxable     => true,
          :tradable    => true,
          :rating_value=> 1,
          :name        => {
            
            :de_DE => "Stein",
  
            :en_US => "Stone",
                
          },
          :flavour     => {
            
            :de_DE => "Grau, hart, überall zu finden.",
  
            :en_US => "Gray, hard, found everywhere.",
                
          },
          :description => {
            
            :de_DE => "<p>Steine -- in der STEINzeit DER Rohstoff schlechthin. Kann gesammelt, gestapelt, geschärft und geworfen werden. Mehr muss man nicht sagen.</p>",
  
            :en_US => "<p>Ah, stones. The most vital raw material of the Stone Age. Can't think why they called it that... Stones can be gathered, stacked, sharpened and thrown. Not a lot more to say about them.</p>",
                
          },

        },              #   END OF resource_stone
        {               #   resource_wood
          :id          => 1, 
          :symbolic_id => :resource_wood,
          :stealable   => false,
          :taxable     => true,
          :tradable    => true,
          :rating_value=> 1,
          :name        => {
            
            :de_DE => "Holz",
  
            :en_US => "Wood",
                
          },
          :flavour     => {
            
            :de_DE => "Ein Brett in Ehren kann niemand verwehren.",
  
            :en_US => "It's not for nothing that we say 'touch wood' when we hope for good luck!",
                
          },
          :description => {
            
            :de_DE => "<p>Holz war bereits in der Steinzeit in allen Varianten verfügbar: Nadelholz, Laubholz, Kantholz und natürlich Brettholz. Als Rohstoff spielt Holz eine wichtige Rolle bei der Konstruktion von Gebäuden und Belagerungswaffen.</p>",
  
            :en_US => "<p>Even in the Stone Age, wood was used for various important purposes, including the construction of buildings and siege weapons.</p>",
                
          },

        },              #   END OF resource_wood
        {               #   resource_fur
          :id          => 2, 
          :symbolic_id => :resource_fur,
          :stealable   => false,
          :taxable     => true,
          :tradable    => true,
          :rating_value=> 1,
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
  
            :en_US => "<p>Fur, sweet fur. It keeps you warm, it's water resistant, it can cover up holes in buildings, and it can be used as emergency roofing.</p>",
                
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
  
            :en_US => "Everyone likes Golden Frogs - the currency of the Stone Age.",
                
          },
          :description => {
            
            :de_DE => "<p>Quasi-Währung in der Steinzeit. Gerne genommen bei jeglichem Tauschhandel.</p>",
  
            :en_US => "<p>A type of Stone Age currency, readily accepted in any barter transaction.</p>",
                
          },

        },              #   END OF resource_cash
      ],                # END OF RESOURCE TYPES

# ## UNIT CATEGORIES ##############################################################

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
            
            :en_US => "<p>The infantry is the basic unit of every army squad. They protect stone throwers from direct attack and, if there are enough of them, they can also fend off flank attacks.</p>",
  
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
  
            :de_DE => "Berittene",
                
          },
          :description => {
            
            :en_US => "<p>Mounted units move very quickly across the battlefield and are the only units that are able to avoid enemy infantry and mount a direct attack on enemy throwers (flank attack).</p>",
  
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

        {               #   Warrior
          :id          => 0, 
          :symbolic_id => :warrior,
					:category    => 0,
          :db_field    => :unit_warrior,
          :name        => {
            
            :en_US => "Warrior",
  
            :de_DE => "Krieger",
                
          },
          :flavour     => {
            
            :en_US => "<p>An affordable, unarmed warrior used for hunting down neanderthals and other players' weakest units.</p>",
  
            :de_DE => "<p>Günstiger unbewaffneter Krieger zur Abwehr von Neandertalern und schwachen Gegnern.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die stärksten, draufgängerischsten und dümmsten Männer des Stammes werden zu Kriegern ausgebildet. In Ermangelung von tauglichen Waffen werden sie ausgiebig im Nahkampf geschult und erwehren sich der Gegner mit purer Muskelkraft und Willensstärke - oder versuchen es zumindest.</p><p>Sind in einer Siedlung bewaffnete Nahkampfeinheiten verfügbar, können keine unbewaffneten Einheiten rekrutiert werden. Sehr schwach gegen alle anderen Einheitentypen außer Nahkämpfer.</p>",
  
            :en_US => "<p>The strongest, toughest and most stupid men of your tribe are trained as warriors. Having no effective weapons at their disposal, unarmed warriors overwhelm their opponents by pure muscle power and their strong will - or at least they try for a while. They can be trained as long as there are no armed melee units available in the same settlement. Very weak against all unit types apart from melee fighters.</p><p>Can only be trained as long as there are no armed melee units available in the same settlement. Very weak against any other unit type but melee units.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 1,
  
            :unitcategory_cavalry => 0.5,
  
            :unitcategory_artillery => 0.5,
  
            :unitcategory_siege => 0.5,
  
            :unitcategory_special => 0.5,
                
          },
          :attack      => 5,
          :armor       => 4,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.01,

          :production_time => '1200',

          :costs      => {
            0 => '5',
            1 => '5',
            2 => '50',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_infantry_tower',
              :id => 28,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            {
              :symbolic_id => 'building_barracks',
              :id => 3,
              :type => 'building',

              :min_level => 1,

              :max_level => 4,

            },

            ],

          ],          


        },              #   END OF Warrior
        {               #   Club Warrior
          :id          => 1, 
          :symbolic_id => :clubbers,
					:category    => 0,
          :db_field    => :unit_clubbers,
          :name        => {
            
            :en_US => "Club Warrior",
  
            :de_DE => "Keulenkrieger",
                
          },
          :flavour     => {
            
            :en_US => "<p>Holds a club and is always at the front of battle lines.</p>",
  
            :de_DE => "<p>Eine Keule in der Hand und immer an vorderster Front.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Keulenkrieger sind der Grundbestandteil jeder Armee. Sie stehen an der Front und beschützen die Fernkämpfer vor der Kavallerie. Keulenkrieger sind zähe Burschen und nur schwer klein zu kriegen, allerdings finden sie nur zu oft den Tod durch feindliche Fernkämpfer.</p>",
  
            :en_US => "<p>Club warriors are the basic units of any Stone Age army. They fight on the front line and protect the ranged combatants from cavalry attack. They're tough and difficult to beat, but unfortunately they all too often take a hit from enemy ranged combatants.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 1,
  
            :unitcategory_cavalry => 1.5,
  
            :unitcategory_artillery => 0.75,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 6,
          :armor       => 5,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.01,

          :production_time => '900',

          :costs      => {
            0 => '20',
            1 => '30',
            2 => '75',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_infantry_tower',
              :id => 28,
              :type => 'building',

              :min_level => 1,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_barracks',
              :id => 3,
              :type => 'building',

              :min_level => 5,

            },

            ],

          ],          


        },              #   END OF Club Warrior
        {               #   Thick-Skinned Clubber
          :id          => 2, 
          :symbolic_id => :clubbers_2,
					:category    => 0,
          :db_field    => :unit_clubbers_2,
          :name        => {
            
            :en_US => "Thick-Skinned Clubber",
  
            :de_DE => "Dicke Keule",
                
          },
          :flavour     => {
            
            :en_US => "<p>“You two? Go and fetch three more of you so you can give me a halfway fair fight!”</p>",
  
            :de_DE => "<p>„Ihr zwei? Holt euch noch drei dazu, dann wird es ein halbwegs fairer Kampf!“</p>",
                
          },
          :description => {
            
            :de_DE => "<p>'Dicke Keule' ist die Abkürzung von Dickhäutigem Keulenkrieger und bezieht sich sowohl auf die Keule als auch auf die Widerstandskraft. Dank der dicken Haut muss die Zeitspanne bis zur Bewusstlosigkeit nicht in Schmerzen durchstanden werden.</p>",
  
            :en_US => "<p>Their thick skin protects them against blows from enemy clubs, but it doesn't help so much against the sharp stones of the ranged combatants. Although thanks to their thick skin, they don't feel a lot of pain before they pass out.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 1,
  
            :unitcategory_cavalry => 1.5,
  
            :unitcategory_artillery => 0.75,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 6,
          :armor       => 6,
          :hitpoints   => 100,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.01,

          :production_time => '1200',

          :costs      => {
            0 => '30',
            1 => '40',
            2 => '113',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_infantry_tower',
              :id => 28,
              :type => 'building',

              :min_level => 5,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 27,
              :type => 'building',

              :min_level => 4,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_barracks',
              :id => 3,
              :type => 'building',

              :min_level => 10,

            },

            ],

          ],          


        },              #   END OF Thick-Skinned Clubber
        {               #   Haymaker
          :id          => 3, 
          :symbolic_id => :clubbers_3,
					:category    => 0,
          :db_field    => :unit_clubbers_3,
          :name        => {
            
            :en_US => "Haymaker",
  
            :de_DE => "Knüppel-Schwinger",
                
          },
          :flavour     => {
            
            :en_US => "<p>The art of expressive battle! Here, haymakers give marks to each other based on the finesse of their fighting style.</p>",
  
            :de_DE => "<p>Die Kunst des Ausdruckkampfes! Knüppel-Schwinger geben sich untereinander Noten für ihre Kampfstil.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Knüppel-Schwinger vereinen tödliche Kampfkunst mit gutem Aussehen und Ausdruck. Vom geschnitzten Knüppel bis hin zur Haltung des linken Zehs beim kraftvollen Zuschlagen wird nichts dem Zufall überlassen. Der größte Feind ist nicht der Gegner, sondern ihre Eitelkeit.</p>",
  
            :en_US => "<p>Haymakers unite the lethal arts of fighting with good looks and charisma. Everything from the carving of the bludgeon to the position of one's left toe when striking someone hard will receive ratings, and nothing will be left to chance. The greatest danger here is not the enemy - it's their own vanity.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 1,
  
            :unitcategory_cavalry => 1.5,
  
            :unitcategory_artillery => 0.75,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 6,
          :armor       => 7,
          :hitpoints   => 110,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,

          :production_time => '1500',

          :costs      => {
            0 => '45',
            1 => '68',
            2 => '170',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_infantry_tower',
              :id => 28,
              :type => 'building',

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 27,
              :type => 'building',

              :min_level => 9,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_barracks',
              :id => 3,
              :type => 'building',

              :min_level => 15,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 1,

            },

            ],

          ],          


        },              #   END OF Haymaker
        {               #   Tree Huggers
          :id          => 4, 
          :symbolic_id => :tree_huggers,
					:category    => 0,
          :db_field    => :unit_tree_huggers,
          :name        => {
            
            :en_US => "Tree Huggers",
  
            :de_DE => "Baum-Brutalo",
                
          },
          :flavour     => {
            
            :en_US => "<p>Why use a club when you can wield a whole tree instead?</p>",
  
            :de_DE => "<p>Wozu eine Keule nehmen, wenn man einen ganzen Baum schwingen kann?</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Groß, stark, sauber rasierter Bart. Ein Baum-Brutalo legt sehr großen Wert auf sein Äußeres.</p><p>In der Schlacht bietet der Baum-Brutalo ein seltsames Schauspiel. Umhüllt von den rauschenden Blättern seines Kampfbaumes wirbelt der Baum-Brutalo durch die gegnerischen Reihen wie ein Säbelzahntiger, der sich den Schwanz geklemmt hat. Nicht den flauschigen, den anderen...</p>",
  
            :en_US => "<p>Big, strong, clean-shaven… Tree-huggers set great store by their appearance. In battle, the tree-hugger is a strange sight. Surrounded by the rustling leaves of his fighting tree, he whirls through enemy ranks like a sabre-toothed tiger with a trapped tail. And probably other sensitive extremities too.</p><p>In battle, the tree-hugger is a strange sight. Surrounded by the rustling leaves of his fighting tree, the tree-hugger whirls through enemy ranks like a sabre-toothed tiger with a trapped tail. And probably other sensitive extremities too … </p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 1,
  
            :unitcategory_cavalry => 1.5,
  
            :unitcategory_artillery => 0.75,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 7,
          :armor       => 9,
          :hitpoints   => 135,

          :overrunnable => true,

          :critical_hit_damage => 3,
          :critical_hit_chance => 0.02,

          :production_time => '2100',

          :costs      => {
            0 => '68',
            1 => '102',
            2 => '255',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_barracks',
              :id => 3,
              :type => 'building',

              :min_level => 20,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          


        },              #   END OF Tree Huggers
        {               #   Gravel Stone Thrower
          :id          => 5, 
          :symbolic_id => :thrower,
					:category    => 2,
          :db_field    => :unit_thrower,
          :name        => {
            
            :en_US => "Gravel Stone Thrower",
  
            :de_DE => "Kieselsteinwerfer",
                
          },
          :flavour     => {
            
            :en_US => "<p>These ranged combatants couldn't hit a target board at ten paces, but luckily massed enemy phalanxes generally make a nice big target that's hard to miss. </p>",
  
            :de_DE => "<p>Treffen keine Zielscheibe aus zehn Meter Entfernung treffen! Zum Glück sind Schlachtreihen größere Ziele.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Große Steine, kleine Steine, ein Kieselsteinwerfer mag sie alle, solange er sie jemandem an den Kopf werfen kann. Ok, zugegeben, die kleinen mag er ein bisschen lieber. Zwar zielt ein Kieselsteinwerfer nicht, aber sowas kann schnell ins Auge gehen.</p><p>Kieselsteinwerfer fürchten nicht den Tod an sich, nur die Straußenreiter, die diesen bringen.</p>",
  
            :en_US => "<p>Big stones, little stones – stone throwers like them all as long as they can throw them at someone's head. Well, OK – they do prefer the smaller ones. Stone throwers don't actually aim, but their stones can hit you in the eye quite easily. Gravel stone throwers aren't afraid of death as such – they're more afraid of the ostrich riders who cause it.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :effectiveness => {
            
            :unitcategory_infantry => 1.5,
  
            :unitcategory_cavalry => 0.75,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 8,
          :armor       => 3,
          :hitpoints   => 50,

          :overrunnable => true,

          :critical_hit_damage => 5,
          :critical_hit_chance => 0.05,

          :production_time => '1500',

          :costs      => {
            0 => '75',
            1 => '75',
            2 => '225',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_artillery_tower',
              :id => 29,
              :type => 'building',

              :min_level => 1,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_firing_range',
              :id => 14,
              :type => 'building',

              :min_level => 1,

            },

            ],

          ],          


        },              #   END OF Gravel Stone Thrower
        {               #   Target Thrower
          :id          => 6, 
          :symbolic_id => :thrower_2,
					:category    => 2,
          :db_field    => :unit_thrower_2,
          :name        => {
            
            :en_US => "Target Thrower",
  
            :de_DE => " Zielwerfer",
                
          },
          :flavour     => {
            
            :en_US => "<p>Hitting a target at fifty meters with a stone is pretty impressive. Unfortunately, the enemy is mostly further away than that.</p>",
  
            :de_DE => "<p>Diese Jungs können zielen, naja, zumindest fliegt der Stein in die richtige Richtung.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein sicherer Wurf führt zu besseren Treffern. Nicht dass der Unterschied bemerkbar wäre, meist sind eh genug gegnerische Nahkämpfer da, aber es führt doch zu ein oder zwei kritischen Treffern.</p><p>Ein bewegliches Ziel wie einen Straußenreiter zu treffen, ist eine große Leistung und der Unterschied zwischen Leben und Tod für einen Fernkämpfer.</p>",
  
            :en_US => "<p>A sure throw means better strikes. Not that you'd notice the difference – there are usually enough enemy melee fighters around, but it can mean a couple of good tactical strikes. Hitting a moving target like an ostrich rider is quite an achievement and can mean the difference between life and death for a stone thrower.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :effectiveness => {
            
            :unitcategory_infantry => 1.5,
  
            :unitcategory_cavalry => 0.75,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 9,
          :armor       => 3,
          :hitpoints   => 50,

          :overrunnable => true,

          :critical_hit_damage => 6,
          :critical_hit_chance => 0.05,

          :production_time => '2100',

          :costs      => {
            0 => '112',
            1 => '112',
            2 => '320',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_artillery_tower',
              :id => 29,
              :type => 'building',

              :min_level => 5,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 27,
              :type => 'building',

              :min_level => 4,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_firing_range',
              :id => 14,
              :type => 'building',

              :min_level => 10,

            },

            ],

          ],          


        },              #   END OF Target Thrower
        {               #   Stone Thrower
          :id          => 7, 
          :symbolic_id => :thrower_3,
					:category    => 2,
          :db_field    => :unit_thrower_3,
          :name        => {
            
            :en_US => "Stone Thrower",
  
            :de_DE => "Steinschleuderer",
                
          },
          :flavour     => {
            
            :en_US => "<p>The stone thowers have a simple motto - the further you can throw the stone, the better!</p>",
  
            :de_DE => "<p>Das Motto der Steinschleuderer: 'Je weiterer der Stein geworfen wird, desto besser!'</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Mit der Schleuder können auch größere Steine weiter geworfen werden. Treffer bei unvorbereiteten Kämpfer in der zweiten Reihe erzielen eine deutlich höhere Wirkung. Je nach der Seite des Kampfes auf der man gerade steht, ist das zu bejubeln oder zu beklagen. Was durchaus nicht immer eindeutig ist.</p>",
  
            :en_US => "<p>You can throw bigger stones even further if you use a catapult. Stone throwers often hit unsuspecting warriors in the second row, leading to a much higher number of overall casualties that are either suffered or celebrated, depending on which side of the battle you happen to be. Which isn't always obvious.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :effectiveness => {
            
            :unitcategory_infantry => 1.5,
  
            :unitcategory_cavalry => 0.75,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 10,
          :armor       => 3,
          :hitpoints   => 50,

          :overrunnable => true,

          :critical_hit_damage => 7,
          :critical_hit_chance => 0.05,

          :production_time => '3000',

          :costs      => {
            0 => '168',
            1 => '168',
            2 => '480',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_artillery_tower',
              :id => 29,
              :type => 'building',

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 27,
              :type => 'building',

              :min_level => 9,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_firing_range',
              :id => 14,
              :type => 'building',

              :min_level => 15,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 1,

            },

            ],

          ],          


        },              #   END OF Stone Thrower
        {               #   Spear Thrower
          :id          => 8, 
          :symbolic_id => :thrower_4,
					:category    => 2,
          :db_field    => :unit_thrower_4,
          :name        => {
            
            :en_US => "Spear Thrower",
  
            :de_DE => " Speerwerfer",
                
          },
          :flavour     => {
            
            :en_US => "<p>Why anyone would bother to tie a stick to a stone is a mystery – stones are brilliant missiles. But the effect is fantastic, longer range, more accurate and easier to collect. What more could you want?</p>",
  
            :de_DE => "<p>Speerschleuderer sind sehr nervig, aber auch tödlich.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein Speer ist auch im Nahkampf, vor allem gegen Reiter, effektiv. Dumm nur, wenn man schon alle Speere weggeworfen hat, bevor ein Reiter angreift. Im Leitfaden für Speerwerfer steht, dass man immer einen Speer weniger werfen sollte, als man hat. Leider kann kein Speerwerfer zählen, geschweige denn lesen.</p>",
  
            :en_US => "<p>A spear is also effective at close range - especially against riders. The only difficulty is when you've already thrown all your spears before you're attacked by a rider. The field manual for spear throwers clearly states, 'Always throw one spear less than you have'. The trouble is, spear throwers can't read, let alone count.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :effectiveness => {
            
            :unitcategory_infantry => 1.5,
  
            :unitcategory_cavalry => 0.75,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 12,
          :armor       => 3,
          :hitpoints   => 50,

          :overrunnable => true,

          :critical_hit_damage => 8,
          :critical_hit_chance => 0.1,

          :production_time => '4200',

          :costs      => {
            0 => '250',
            1 => '250',
            2 => '712',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_firing_range',
              :id => 14,
              :type => 'building',

              :min_level => 20,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          


        },              #   END OF Spear Thrower
        {               #   Ostrich Rider
          :id          => 9, 
          :symbolic_id => :light_cavalry,
					:category    => 1,
          :db_field    => :unit_light_cavalry,
          :name        => {
            
            :en_US => "Ostrich Rider",
  
            :de_DE => "Straußenreiter",
                
          },
          :flavour     => {
            
            :en_US => "<p>The two-handed ostrich riders are totally focused on controlling their mounts. As they themselves are unarmed, the beaks and claws of their ostriches pose more of a threat than they do.</p>",
  
            :de_DE => "<p>Straußenreiter sind schnell, sonst nichts. Deshalb müssen die Reiter ihre ganze Konzentration auf das Führen ihres Reittieres legen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Strauße sind nicht nur lecker, sondern auch gute und schnelle Reittiere. Straußenreiter sind schnell genug, um an den Nahkämpfern vorbeizukommen, so dass den Fernkämpfern nur die Hoffnung bleibt, dass die Sträuße den Kopf in den Sand stecken.</p>",
  
            :en_US => "<p>Ostriches don't just taste delicious! They're also exceptionally good and speedy mounts. Ostrich riders are the bane of all stone throwers. Fast enough to get past the infantry, their enemies can only hope that the ostriches will stick their heads in the sand or that their riders will fall off.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1.2,
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

          :production_time => '1200',

          :costs      => {
            0 => '60',
            1 => '40',
            2 => '150',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_cavalry_tower',
              :id => 30,
              :type => 'building',

              :min_level => 1,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_stud',
              :id => 20,
              :type => 'building',

              :min_level => 1,

            },

            ],

          ],          


        },              #   END OF Ostrich Rider
        {               #   Hungry Ostrich
          :id          => 10, 
          :symbolic_id => :light_cavalry_2,
					:category    => 1,
          :db_field    => :unit_light_cavalry_2,
          :name        => {
            
            :en_US => "Hungry Ostrich",
  
            :de_DE => "Hungriger Strauß",
                
          },
          :flavour     => {
            
            :en_US => "<p> Eyes are especially delicious treats to a hungry and dangerous ostrich.</p>",
  
            :de_DE => "<p>Beim Sturm durch gegnerische Kampflinien sind besonders Augen Leckereien für die Strauße. </p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Reiter sitzt auf einem abgerichteten äußerst hungrigen Strauß. Wenn der Reiter nicht selbst gebissen wird, ist der hungrige Strauß eine wild pickende Kampfmaschine, die ungeschützte Fernkämpfer zerreißen kann.</p>",
  
            :en_US => "<p>The rider sits on a trained and very hungry ostrich. As long as the rider doesn't get bitten himself, the hungry ostrich stays a wild, pecking battle machine, able to destroy unprotected rangers.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1.3,
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

          :production_time => '1500',

          :costs      => {
            0 => '90',
            1 => '60',
            2 => '225',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_cavalry_tower',
              :id => 30,
              :type => 'building',

              :min_level => 5,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 27,
              :type => 'building',

              :min_level => 4,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_stud',
              :id => 20,
              :type => 'building',

              :min_level => 10,

            },

            ],

          ],          


        },              #   END OF Hungry Ostrich
        {               #   Frantic Ostrich
          :id          => 11, 
          :symbolic_id => :light_cavalry_3,
					:category    => 1,
          :db_field    => :unit_light_cavalry_3,
          :name        => {
            
            :en_US => "Frantic Ostrich",
  
            :de_DE => "Rasender Strauß",
                
          },
          :flavour     => {
            
            :en_US => "<p>Frantic ostriches break for nobody!</p>",
  
            :de_DE => "<p>Rasende Strauße bremsen für niemanden!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Rasende Strauße sind spezialisiert auf blitzschnelle Angriffe. Gegnerische Reittiere blockieren als Spielverderber leider den Weg zu den leichten Zielen, sprichwörtlich auch Fleischtöpfe genannt.</p>",
  
            :en_US => "<p>Frantic ostriches are specialized in lightning attacks. Enemy mounts are spoilsports though, blocking the access to sitting targets that could otherwise be picked off easily.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1.4,
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

          :production_time => '2100',

          :costs      => {
            0 => '135',
            1 => '90',
            2 => '335',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_cavalry_tower',
              :id => 30,
              :type => 'building',

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 27,
              :type => 'building',

              :min_level => 9,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_stud',
              :id => 20,
              :type => 'building',

              :min_level => 15,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 1,

            },

            ],

          ],          


        },              #   END OF Frantic Ostrich
        {               #   Dinosaur Rider
          :id          => 12, 
          :symbolic_id => :light_cavalry_4,
					:category    => 1,
          :db_field    => :unit_light_cavalry_4,
          :name        => {
            
            :en_US => "Dinosaur Rider",
  
            :de_DE => "Dinoreiter",
                
          },
          :flavour     => {
            
            :en_US => "<p>Dinosaurs stink! And after a battle, it can take days to get the smell out of your clothes.</p>",
  
            :de_DE => "<p>Ein Dino stinkt! Und die Dinowäsche nach einer Schlacht kann auch mal Tage dauern.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Als Reiter eines Dinos hat man genau zwei Aufgaben. Erstens nicht abgeworfen zu werden und zweitens den Dino immer wieder auf das Schlachtfeld zurückzulenken, wenn er erstmal durch die Schlachtreihen durchgebrochen ist. Mit Füßen, Schwanz und Zähnen werden die hilflosen Gegner niedergemäht.</p>",
  
            :en_US => "<p>A dinosaur rider has only two jobs: the first is not to get thrown off, and the second is to keep steering his dinosaur back to the battlefield once it's broken through enemy ranks. The hapless enemy is mowed down by the dinosaur's feet, tail and teeth.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => true,

          :velocity    => 1.5,
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

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.02,

          :production_time => '3000',

          :costs      => {
            0 => '200',
            1 => '135',
            2 => '505',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_stud',
              :id => 20,
              :type => 'building',

              :min_level => 20,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          


        },              #   END OF Dinosaur Rider
        {               #   Neanderthals
          :id          => 13, 
          :symbolic_id => :neanderthal,
					:category    => 0,
          :db_field    => :unit_neanderthal,
          :name        => {
            
            :en_US => "Neanderthals",
  
            :de_DE => "Neandertaler",
                
          },
          :flavour     => {
            
            :en_US => "<p>Neanderthals don't talk, they act – er, hit.</p>",
  
            :de_DE => "<p>Neandertaler reden nicht, sie handeln äh - schlagen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Neandertaler sind ein wilder Stamm prähistorischer Menschen.</p><p>Sie sind zwar ziemlich beeindruckende Kämpfer, haben aber keine Ahnung von Taktik. Wenn Schreien und Zuschlagen nicht mehr ausreichen, ist es meist schon zu spät für den Neandertaler.</p>",
  
            :en_US => "<p>Neanderthals are a wild tribe of prehistoric people. They are quite impressive fighters, but they haven't got a clue about tactics. When shouting and hitting fail to fend off the enemy, that's usually the end for Neanderthals.</p>",
                
          },

          :experience_factor => 1.0,
          :trainable   => false,

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 1,
  
            :unitcategory_cavalry => 1.5,
  
            :unitcategory_artillery => 0.75,
  
            :unitcategory_siege => 0.8,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 5,
          :armor       => 3,
          :hitpoints   => 70,

          :overrunnable => true,

          :critical_hit_damage => 1,
          :critical_hit_chance => 0.01,

          :production_time => '1200',

          :costs      => {
            0 => '20',
            1 => '10',
            2 => '60',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_stud',
              :id => 20,
              :type => 'building',

              :min_level => 100,

            },

            ],

          ],          


        },              #   END OF Neanderthals
        {               #   Little Chief
          :id          => 14, 
          :symbolic_id => :little_chief,
					:category    => 4,
          :db_field    => :unit_little_chief,
          :name        => {
            
            :en_US => "Little Chief",
  
            :de_DE => "Kleiner Häuptling",
                
          },
          :flavour     => {
            
            :en_US => "<p>A little chief is allowed to set up an encampment in the name of the actual chieftain.</p>",
  
            :de_DE => "<p>Der kleine Häuptling darf im Namen des richtigen Häuptlings eine Lagerstätte gründen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Als intriganter, karrieresüchtiger, aalglatter Möchtegern ist der Kleine Häuptling das Rollenvorbild für ganze Generationen an Wichtigtuern. Zum Glück kann der Kleine Häuptling unter dem Vorwand der Gründung einer Lagerstätte aus der Siedlung verbannt werden.</p>",
  
            :en_US => "<p>A little chief is about as popular as an encounter with a hungry dinosaur. As a scheming, workaholic, slick wannabe, the little chief is a role model for entire generations of snobs. Luckily, a little chief can be banished from a settlement under the pretext of founding a new encampment.</p>",
                
          },

          :experience_factor => 0.0,
          :trainable   => true,

          :velocity    => 0.85,
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

          :production_time => '43200',

          :costs      => {
            0 => '5000',
            1 => '5000',
            2 => '4000',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_campfire',
              :id => 7,
              :type => 'building',

              :min_level => 10,

            },

            ],

          ],          

          :can_create => [
3,

          ],


        },              #   END OF Little Chief
        {               #   Great Chief
          :id          => 15, 
          :symbolic_id => :great_chief,
					:category    => 4,
          :db_field    => :unit_great_chief,
          :name        => {
            
            :en_US => "Great Chief",
  
            :de_DE => "Großer Häuptling",
                
          },
          :flavour     => {
            
            :en_US => "<p>The great chief is allowed to set up a new home settlement and found a tribe.</p>",
  
            :de_DE => "<p>Der Große Häuptling kann eine Heimatsiedlung und damit einen neuen Stamm gründen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Als intriganter, karrieresüchtiger, aalglatter Möchtegern ist der Große Häuptling das Rollenvorbild für ganze Generationen an Wichtigtuern. Einziger Trost für seine Untergebenen: so groß ist er gar nicht.</p>",
  
            :en_US => "<p>As a scheming, workaholic, slick wannabe, the great chief is a role model for entire generations of snobs. At least, he isn't that tall. Actually, he's rather small. But please, don't let him know.</p>",
                
          },

          :experience_factor => 0.0,
          :trainable   => false,

          :velocity    => 5.00,
          :action_points => 4,
          :initiative  => 20,
          :effectiveness => {
            
            :unitcategory_infantry => 1,
  
            :unitcategory_cavalry => 0.5,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 1,
  
            :unitcategory_special => 1,
                
          },
          :attack      => 10,
          :armor       => 3,
          :hitpoints   => 300,

          :overrunnable => true,

          :critical_hit_damage => 50,
          :critical_hit_chance => 0.01,

          :production_time => '432000',

          :costs      => {
            0 => '500000',
            1 => '500000',
            2 => '400000',
            
          },

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_stud',
              :id => 20,
              :type => 'building',

              :min_level => 100,

            },

            ],

          ],          

          :can_create => [
2,

          ],


        },              #   END OF Great Chief
      ],                # END OF UNIT TYPES

# ## BUILDING CATEGORIES ######################################################

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
  
            :de_DE => "Festungsturm",
                
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

        {               #   Häuptlingshütte
          :id          => 0, 
          :symbolic_id => :building_chief_cottage,
					:category    => 4,
          :db_field    => :building_chief_cottage,
          :name        => {
            
            :de_DE => "Häuptlingshütte",
  
            :en_US => "Chieftain's Hut",
                
          },
          :flavour     => {
            
            :en_US => "<p>Show me your chieftain's hut and I'll tell you who you are! More buildings, more armies, more glory. Chieftains are pretty predictable.</p>",
  
            :de_DE => "<p>Zeig mir Deine Häuptlingshütte und ich sag Dir wer Du bist! Mehr Gebäude, mehr Armeen, mehr Glanz. Häuptlinge sind wirklich berechenbar.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Lange Zeit ist die Häuptlingshütte das einzig halbwegs befestigte Gebäude der Siedlung. Jeder Ausbau erhöht die Kampfkraft und das Lager der Siedlung.</p><p>Die Häuptlingshütte liefert jeweils einen Kommandopunkt auf Level 2, 6 und 20.</p>",
  
            :en_US => "<p>Even a halfway fortified settlement will have long had a chieftan's hut. Of course, the chieftan has a little store in his hut for when times get tough. Upgrading the chieftan's hut gives a command point at Levels 2, 6 and 20.</p>",
                
          },

          :hidden      => 0,

	        :population  => "1+MIN(MAX(LEVEL-3,0),1)+MIN(MAX(LEVEL-6,0),1)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 6,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'EQUAL(LEVEL,2)*10+EQUAL(LEVEL,3)*35+EQUAL(LEVEL,4)*100+EQUAL(LEVEL,5)*800+GREATER(LEVEL,5)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2*1.5+0.5)',
            1 => 'EQUAL(LEVEL,2)*10+EQUAL(LEVEL,3)*35+EQUAL(LEVEL,4)*100+EQUAL(LEVEL,5)*800+GREATER(LEVEL,5)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2*1.5+0.5)',
            2 => 'EQUAL(LEVEL,2)*10+EQUAL(LEVEL,3)*35+EQUAL(LEVEL,4)*100+EQUAL(LEVEL,5)*800+GREATER(LEVEL,5)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2*1.5+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'EQUAL(LEVEL,2)*10+EQUAL(LEVEL,3)*15+EQUAL(LEVEL,4)*600+EQUAL(LEVEL,5)*5.5*3600+GREATER(LEVEL,5)*((MIN(LEVEL,2)-MIN(LEVEL,1))*(MIN(LEVEL+1,4)-MIN(LEVEL,4))*(40*(LEVEL-1)-10)+(MIN(LEVEL,4)-MIN(LEVEL,3))*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*4+0.5))',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],

          :capacity  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "4000+100*FLOOR(((MIN(LEVEL+1,10)-MIN(LEVEL,10))*(130*POW(LEVEL,2)-130*LEVEL)+(MAX(LEVEL+1,10)-MAX(LEVEL,10))*(20*POW((LEVEL),2)+9000))/100)",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "4000+100*FLOOR(((MIN(LEVEL+1,10)-MIN(LEVEL,10))*(130*POW(LEVEL,2)-130*LEVEL)+(MAX(LEVEL+1,10)-MAX(LEVEL,10))*(20*POW((LEVEL),2)+9000))/100)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "4000+100*FLOOR(((MIN(LEVEL+1,10)-MIN(LEVEL,10))*(130*POW(LEVEL,2)-130*LEVEL)+(MAX(LEVEL+1,10)-MAX(LEVEL,10))*(20*POW((LEVEL),2)+9000))/100)",
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

            :command_points => "GREATER(LEVEL,1)+GREATER(LEVEL,5)+EQUAL(LEVEL,20)",

            :unlock_building_slots => "MIN(LEVEL,10)*4-1",

            :garrison_size_bonus => "1000",

            :army_size_bonus => "1000",

          },

        },              #   END OF Häuptlingshütte
        {               #   Jäger und Sammler
          :id          => 1, 
          :symbolic_id => :building_gatherer,
					:category    => 5,
          :db_field    => :building_gatherer,
          :name        => {
            
            :de_DE => "Jäger und Sammler",
  
            :en_US => "Hunter Gatherers",
                
          },
          :flavour     => {
            
            :en_US => "<p>Wood and stones, a couple of rabbits or other rodents and the occasional golden frog. For hunter gatherers, though, the real treasures are mushrooms. Especially the red ones with the white spots.</p>",
  
            :de_DE => "<p>Holz und Steine, ein paar Kaninchen oder andere Nager und ganz selten auch mal eine Kröte. Das sind die Schätze des Sammlers.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Primitivster aller Steinzeitbewohner. Er jagt und sammelt einfach alles was ihm vor die Flinte - äh Steinschleuder - kommt. Neben vielen völlig unbrauchbaren Sachen finden die Jäger und Sammler alles von Ästen und Steinen über Wurzeln und bei ausreichend großem Gelände sogar ein paar Kröten.</p>",
  
            :en_US => "<p>The most primitive of all Stone Age folk, the Hunter Gatherer collects all kinds of stuff, from branches and stones to roots, and even a couple of Golden Frogs, if the area is big enough. Basically, he hunts and gathers anything that comes into his sights - er... into the reach of his slingshot. All his treasures are set out neatly on display in his compound. </p><p>Apart from all kinds of useless stuff, hunter gatherers find everything – from branches and stones to roots and, if the area is big enough, even a couple of golden frogs.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 0.49,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 1,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 1,

            },

            ],

          ],          

          :costs      => {
            0 => 'EQUAL(LEVEL,1)*1+EQUAL(LEVEL,2)*4+EQUAL(LEVEL,3)*10+EQUAL(LEVEL,4)*30+GREATER(LEVEL,4)*FLOOR((((MIN(LEVEL,6)-MIN(LEVEL,5))*0.2+0.8)*(0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.33+0.5)',
            1 => 'EQUAL(LEVEL,1)*1+EQUAL(LEVEL,2)*4+EQUAL(LEVEL,3)*10+EQUAL(LEVEL,4)*30+GREATER(LEVEL,4)*FLOOR((((MIN(LEVEL,6)-MIN(LEVEL,5))*0.2+0.8)*(0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.33+0.5)',
            2 => 'FLOOR((EQUAL(LEVEL,1)*1+EQUAL(LEVEL,2)*4+EQUAL(LEVEL,3)*10+EQUAL(LEVEL,4)*30+GREATER(LEVEL,4)*FLOOR((((MIN(LEVEL,6)-MIN(LEVEL,5))*0.2+0.8)*(0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.33+0.5))*0.5)',
            3 => 'MAX(LEVEL-18,0)',
            
          },

          :production_time => 'EQUAL(LEVEL,1)*5+EQUAL(LEVEL,2)*15+EQUAL(LEVEL,3)*20+EQUAL(LEVEL,4)*120+GREATER(LEVEL,4)*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*0.7+0.5)',
          :production  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR((EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*(0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)*(5.0/6)*(97.5/100))/4+0.5)",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR((EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*(0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)*(5.0/6)*(97.5/100))/4+0.5)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR((EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*(0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)*(5.0/6)*(97.5/100))/4+0.5)",
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
        {               #   Gottesgläubiger Sammler
          :id          => 2, 
          :symbolic_id => :building_special_gatherer,
					:category    => 6,
          :db_field    => :building_special_gatherer,
          :name        => {
            
            :de_DE => "Gottesgläubiger Sammler",
  
            :en_US => "God-Fearing Gatherer",
                
          },
          :flavour     => {
            
            :en_US => "<p>Wood and stones, a couple of rabbits or other rodents and the occasional golden frog. For hunter gatherers, though, the real treasures are mushrooms. Especially the red ones with the white spots.</p>",
  
            :de_DE => "<p>Der Gottesfürchtige Sammler steht nur den Göttlichen Supporten zur Verfügung.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Gottesgläubige Sammler folgt nur den Halbgöttern, die ihren Glauben und ihre Unterstützung bewiesen haben.</p><p>Eine deutlich erhöhte Produktion wie auch seine Fähigkeit ständig Goldkröten zu finden heben den Gottesfürchtigen Sammler von seinen Kollegen ab.</p>",
  
            :en_US => "<p>The god-fearing gatherer is only devout towards demigods that have proven their dedication and support.</p><p>Through his devotion he can find ressources and even golden frogs at a much higher rate than their peers.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1.5)",
  
          :buyable     => true,
          :divine_supporters_only => true,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 0.49,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 1,

            },

            {
              :symbolic_id => 'building_special_gatherer',
              :id => 2,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'EQUAL(LEVEL,1)*1+EQUAL(LEVEL,2)*4+EQUAL(LEVEL,3)*10+EQUAL(LEVEL,4)*30+GREATER(LEVEL,4)*FLOOR((((MIN(LEVEL,6)-MIN(LEVEL,5))*0.2+0.8)*(0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.33+0.5)',
            1 => 'EQUAL(LEVEL,1)*1+EQUAL(LEVEL,2)*4+EQUAL(LEVEL,3)*10+EQUAL(LEVEL,4)*30+GREATER(LEVEL,4)*FLOOR((((MIN(LEVEL,6)-MIN(LEVEL,5))*0.2+0.8)*(0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.33+0.5)',
            2 => 'FLOOR((EQUAL(LEVEL,1)*1+EQUAL(LEVEL,2)*4+EQUAL(LEVEL,3)*10+EQUAL(LEVEL,4)*30+GREATER(LEVEL,4)*FLOOR((((MIN(LEVEL,6)-MIN(LEVEL,5))*0.2+0.8)*(0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.33+0.5))*0.5)',
            3 => 'MAX(LEVEL-18,0)',
            
          },

          :production_time => 'EQUAL(LEVEL,1)*5+EQUAL(LEVEL,2)*15+EQUAL(LEVEL,3)*20+EQUAL(LEVEL,4)*120+GREATER(LEVEL,4)*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*0.7+0.5)',
          :production  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "LESS(LEVEL,11)*(FLOOR((EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*(0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)*(5.0/6)*(97.5/100))*1.75+0.5))",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "LESS(LEVEL,11)*(FLOOR((EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*(0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)*(5.0/6)*(97.5/100))*1.75+0.5))",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "LESS(LEVEL,11)*(FLOOR((EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*(0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)*(5.0/6)*(97.5/100))*1.75+0.5))",
              },
            
              {
                :id                 => 3,
                :symbolic_id        => :resource_cash,
                :formula            => "1/12.0",
              },
            
          ],
          :production_bonus  => [
            
          ],

          :abilities   => {

          },

        },              #   END OF Gottesgläubiger Sammler
        {               #   Ausbildungsgelände
          :id          => 3, 
          :symbolic_id => :building_barracks,
					:category    => 5,
          :db_field    => :building_barracks,
          :name        => {
            
            :de_DE => "Ausbildungsgelände",
  
            :en_US => "Training Grounds",
                
          },
          :flavour     => {
            
            :en_US => "<p>Looking for a little fight? Haven't been bashed up for a while? The barracks are the place to go for anyone wanting to jump into the fray.</p>",
  
            :de_DE => "<p>Auf der Suche nach einem kleinen Kampf? Lange nicht mehr verprügelt worden?</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Auf dem Ausbildungsgelände werden alle Arten von Nahkämpfern ausgebildet. Der Ausbau beschleunigt die Ausbildung und ermöglicht die Rekrutierung höherwertiger Kämpfer. Mehrere Ausbildungsgelände beschleunigen die Rekrutierung zusätzlich.</p>",
  
            :en_US => "<p>These are the training grounds where all kinds of close combat fighters are trained. Big clubs, roasting spits, or even bare fists - anything goes. Would-be combatants compete in numerous contests to toughen themselves up for duelling, and once in a moon a public tournament is held. The winner gets the lot - glory, food, a day off and as many men as they want. Yes, that's right - men! Because the tournaments are usually won by women. How With a woman's deadliest weapons, of course...</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*2)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 4.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 2,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 2,

            },

            ],

          ],          

          :costs      => {
            0 => 'EQUAL(LEVEL,1)*50+GREATER(LEVEL,1)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5)',
            1 => 'EQUAL(LEVEL,1)*25+GREATER(LEVEL,1)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5*1.5+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'EQUAL(LEVEL,1)*15+GREATER(LEVEL,1)*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+GREATER(LEVEL,3)*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+GREATER(LEVEL,10)*47547*(0.06*(LEVEL-10)+0.98))*3+0.5)',
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
                :speedup_formula   => "LESS(LEVEL,11)*FLOOR(1.25*POW(LEVEL,1.3)+0.5)/100.0+GREATER(LEVEL,10)*FLOOR(0.3*POW(LEVEL,1.94)+0.5)/100.0",
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
        {               #   Kleine Hütte
          :id          => 4, 
          :symbolic_id => :building_cottage,
					:category    => 5,
          :db_field    => :building_cottage,
          :name        => {
            
            :de_DE => "Kleine Hütte",
  
            :en_US => "Small Hut",
                
          },
          :flavour     => {
            
            :en_US => "<p>Your subjects live in small huts. The more subjects there are, the faster you can build other buildings.</p>",
  
            :de_DE => "<p>Ein Dach über dem Kopf. Mehr ist das wirklich nicht!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>In den kleinen Hütten sind schützt Eure Untertanen vor Sonne und Regen geschützt. Hauptsache, sie sind fleißig und beschweren sich nicht. Je mehr Hütten, desto mehr Untertanen habt ihr, die wiederum schneller arbeiten und Eure Siedlung schneller ausbauen. Wenn Chef sein immer so einfach wäre!</p>",
  
            :en_US => "<p>A little hut can only protect your subjects from sun and rain. The main thing is that they work hard and don't complain. The more huts you have, the more subjects you have and the faster they'll work and the quicker the settlement will be upgraded. If only being the boss was always this easy!</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 3,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 3,

            },

            ],

          ],          

          :costs      => {
            0 => 'LESS(LEVEL,5)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.75*1.5+0.5)*0.5)+EQUAL(LEVEL,5)*275+GREATER(LEVEL,5)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.75*1.5+0.5))',
            1 => 'LESS(LEVEL,5)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5)*0.5)+EQUAL(LEVEL,5)*180+GREATER(LEVEL,5)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5))',
            2 => 'LESS(LEVEL,5)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.25*1.5+0.5)*0.5)+EQUAL(LEVEL,5)*90+GREATER(LEVEL,5)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.25*1.5+0.5))',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'EQUAL(LEVEL,1)*10+EQUAL(LEVEL,2)*30+EQUAL(LEVEL,3)*90+EQUAL(LEVEL,4)*660+EQUAL(LEVEL,5)*2700+GREATER(LEVEL,5)*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*1.43*(25*POW(LEVEL,2)-50*LEVEL+40)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*0.7+0.5)',
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
                :speedup_formula   => "LESS(LEVEL,11)*(FLOOR((1.25*POW(LEVEL,1.3)+0.5)*3)/100.0)+GREATER(LEVEL,10)*FLOOR((0.3*POW(LEVEL,1.94)+0.5)*3)/100.0",
              },

            ],

          },

          :conversion_option => {
            :building              => :building_cottage_2,
            :target_level_formula  => "LEVEL-GREATER(LEVEL,1)-GREATER(LEVEL,5)-GREATER(LEVEL,9)-GREATER(LEVEL,12)-GREATER(LEVEL,15)-GREATER(LEVEL,18)", 
          },

        },              #   END OF Kleine Hütte
        {               #   Taverne
          :id          => 5, 
          :symbolic_id => :building_tavern,
					:category    => 6,
          :db_field    => :building_tavern,
          :name        => {
            
            :de_DE => "Taverne",
  
            :en_US => "Tavern",
                
          },
          :flavour     => {
            
            :en_US => "<p>A quiet seat, a cool beer, and some reasonably friendly company. What more could anyone want from life?</p>",
  
            :de_DE => "<p>Ein ruhiger Sitz, ein kühles Bier in mehr oder weniger angenehmer Gesellschaft - was könnte man sich mehr wünschen?</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Taverne. Nirgendwo wirst du mehr Abschaum und Verkommenheit versammelt finden als hier. Der ideale Ort, um ein Bierchen zu heben und den einen oder anderen Plausch zu halten. Vielleicht findet ihr auch weitere Verdienstmöglichkeiten.</p><p>Dieses Gebäude kann nicht abgerissen werden.</p>",
  
            :en_US => "<p>There is no more wretched a hive of scum and villainy than the tavern. So, it's an ideal place to relax, have a drink, and laze around during your day off. And who knows, a job may even turn up if you stick around long enough.</p><p>This building can not be torn down.</p>",
                
          },

          :hidden      => 0,

	        :population  => "LESS(LEVEL,11)*(FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*2))",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 12,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 3,

            },

            {
              :symbolic_id => 'building_tavern',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'LESS(LEVEL,11)*(LESS(LEVEL,5)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.125*1.5+0.5)+GREATER(LEVEL,4)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5*1.125*1.5+0.5+1125))',
            1 => 'LESS(LEVEL,11)*(LESS(LEVEL,5)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.125*1.5+0.5)+GREATER(LEVEL,4)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5*1.125*1.5+0.5+1125))',
            2 => 'LESS(LEVEL,11)*(LESS(LEVEL,5)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.125*1.5+0.5)+GREATER(LEVEL,4)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.5*1.125*1.5+0.5+1125))',
            
          },

          :production_time => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*10+EQUAL(LEVEL,2)*30+EQUAL(LEVEL,3)*90+EQUAL(LEVEL,4)*660+EQUAL(LEVEL,5)*5200+GREATER(LEVEL,5)*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*1.43*(25*POW(LEVEL,2)-50*LEVEL+40)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*2*0.7+0.5))',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],

          :abilities   => {

            :assignment_level => "LEVEL",

          },

        },              #   END OF Taverne
        {               #   Rohstofflager
          :id          => 6, 
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
            
            :de_DE => "<p>Das steinzeitliches Logistikzentrum erhöht die maximale Lagermenge und ermöglicht den Handel mit anderen Spielern. Mehrere Rohstofflager wirken kumulativ und erhöhen sowohl die Lagermenge als auch die Anzahl der Karren.</p>",
  
            :en_US => "<p>This is a Stone Age logistics center in which raw materials are stored and dispatched. The bigger the store, the more carts can be dispatched.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 4,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 4,

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
                :formula            => "FLOOR(EQUAL(LEVEL,1)*80+(POW(LEVEL,2)*100)*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.03)))",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR(EQUAL(LEVEL,1)*80+(POW(LEVEL,2)*100)*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.03)))",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR(EQUAL(LEVEL,1)*80+(POW(LEVEL,2)*100)*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.03)))",
              },
            
          ],

          :abilities   => {

            :trading_carts => "5*LEVEL*LEVEL",

            :unlock_p2p_trade => 1,            

          },

          :conversion_option => {
            :building              => :building_storage_2,
            :target_level_formula  => "LEVEL-GREATER(LEVEL,3)-GREATER(LEVEL,8)-GREATER(LEVEL,13)-GREATER(LEVEL,18)", 
          },

        },              #   END OF Rohstofflager
        {               #   Lagerfeuer
          :id          => 7, 
          :symbolic_id => :building_campfire,
					:category    => 6,
          :db_field    => :building_campfire,
          :name        => {
            
            :de_DE => "Lagerfeuer",
  
            :en_US => "Campfire",
                
          },
          :flavour     => {
            
            :en_US => "<p>The place where alliance members hold diplomatic exchanges or discussions. It takes at least two to have a good conversation, even though often only one of them does the talking. Talk? A little chief can do that better than anyone else.</p>",
  
            :de_DE => "<p>Gutes Essen, leckere Getränke und ein paar Lieder. Ein würdiger Rahmen für Verhandlungen!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Am Lagerfeuer versammeln sich die Bewohner in geselligen Runden oder für wichtige Absprachen. Auch die Gäste werden wahlweise ans Feuer gebeten oder am Marterpfahl aufgestellt.</p><p>Ein paar nette Worte hier, eine kleine Intrige da, schmücken mit fremden Federn und schon kann man sich den Status des kleinen Häuptlings erwerben und vielleicht eine eigene Lagerstätte gründen.</p><p>Dieses Gebäude kann nicht abgerissen werden.</p>",
  
            :en_US => "<p>At the campfire, inhabitants gather in sociable groups to discuss important arrangements. Guests are either selected to join the campfire group, or arranged around it on stakes. It's also where the career of a little chief begins. A couple of flattering words here, a bit of scheming there, taking credit for someone else's bravery, and hey presto! You can take on the status of little chief and maybe even start your own encampment.</p><p>This building can not be torn down.</p>",
                
          },

          :hidden      => 0,

	        :population  => "LESS(LEVEL,11)*(FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1))",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 4,

            },

            {
              :symbolic_id => 'building_campfire',
              :id => 7,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'LESS(LEVEL,11)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5)',
            1 => 'LESS(LEVEL,11)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1*1.5+0.5)',
            
          },

          :production_time => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*20+EQUAL(LEVEL,2)*25+GREATER(LEVEL,2)*FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*2+0.5))',
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

            :unlock_alliance_creation => 2,

          },

        },              #   END OF Lagerfeuer
        {               #   Steinbruch
          :id          => 8, 
          :symbolic_id => :building_quarry,
					:category    => 5,
          :db_field    => :building_quarry,
          :name        => {
            
            :de_DE => "Steinbruch",
  
            :en_US => "Quarry",
                
          },
          :flavour     => {
            
            :en_US => "<p>Stones – nothing but stones, everywhere! Sweaty labourers and the monotonous thwack of heavy tools.</p>",
  
            :de_DE => "<p>Steine, nichts als Steine! Verschwitzte Arbeiter und der monotone Schlag der schweren Werkzeuge.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Durch eine aus Sicht der Steinzeit komplizierte Kette von Arbeitsvorgängen werden im Steinbruch Steine gewonnen.</p><p>Ein richtig großer Steinbruch treibt den Wettkampf unter den Steinbrechern an und sorgt so für noch schnelleren Abbau auch bei den anderen Steinbrüchen.</p>",
  
            :en_US => "<p>Stones are quarried using a complicated - well, for the Stone Age! - series of working processes. A really large quarry stimulates competition among the its workers, which speeds up the quarrying quite a bit - even in other quarries.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 5,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 5,

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
                :formula            => "EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*FLOOR((0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)+0.5)*(5.0/6)*(97.5/100)",
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
            :target_level_formula  => "LEVEL-GREATER(LEVEL,1)-GREATER(LEVEL,7)-GREATER(LEVEL,15)", 
          },

        },              #   END OF Steinbruch
        {               #   Holzfäller
          :id          => 9, 
          :symbolic_id => :building_logger,
					:category    => 5,
          :db_field    => :building_logger,
          :name        => {
            
            :de_DE => "Holzfäller",
  
            :en_US => "Logger",
                
          },
          :flavour     => {
            
            :en_US => "<p>A man and his stone axe! Apart from firewood, he occasionally even brings a tree he managed to fell back to the compound.</p>",
  
            :de_DE => "<p>Ein Mann und seine Steinaxt! Neben losem Holz bringt er ab und zu sogar einen selbst gefällten Baum mit ins Lager.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Unter Ausnutzung purer Gewalt aber auch modernster Steinwerkzeuge gelingt es dem Holzfäller, mehr oder weniger große Stämme zu fällen und zu wertvollen Rohstoffen zu verarbeiten.</p><p>Große Holzfäller lassen nur die kleinen Bäume übrig und reduzieren so die Frustration der kleineren Holzfäller, was sich sehr positiv auf ihren Ertrag auswirkt.</p>",
  
            :en_US => "<p>Using a combination of brute force and up-to-date stone tools, a logger can chop down quite large tree trunks and process them into valuable raw materials. Tall loggers only leave small trees behind, reducing the frustration of smaller loggers. This has a very positive effect on their output!</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 5,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 5,

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
                :formula            => "EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*FLOOR((0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)+0.5)*(5.0/6)*(97.5/100)",
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
            :target_level_formula  => "LEVEL-GREATER(LEVEL,1)-GREATER(LEVEL,7)-GREATER(LEVEL,15)", 
          },

        },              #   END OF Holzfäller
        {               #   Trainingshöhle
          :id          => 10, 
          :symbolic_id => :building_training_cave,
					:category    => 6,
          :db_field    => :building_training_cave,
          :name        => {
            
            :de_DE => "Trainingshöhle",
  
            :en_US => "Training Cave",
                
          },
          :flavour     => {
            
            :de_DE => "<p>Ruhig, kühl, feucht - ein perfekter Platz für jeden Halbgott, um sich auszuruhen und weiterzubilden.</p>",
  
            :en_US => "<p>Quiet, cool, humid - a perfect place for every demigod to relax and educate himself.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>In der Trainingshöhle gibt es verschiedene Trainingsmöglichkeiten für angehende Halbgötter. Große Steine zum Heben, ein fast endloses Labyrinth, Spiegel, in denen man sich herrlich erschrecken kann, und natürlich die ein oder andere Ratte, die eingefangen werden will.</p><p>Dieses Gebäude kann nicht abgerissen werden.</p>",
  
            :en_US => "<p>The Training Cave offers multiple training possibilities to would-be Demigods. Huge stones to lift, an almost endless labyrinth, mirrors that can scare you witless, and of course, a few rats to catch.</p><p>This building can not be torn down.</p>",
                
          },

          :hidden      => 0,

	        :population  => "LESS(LEVEL,11)*FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5))",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> false,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 8,

          :experience_production => 'LESS(LEVEL,11)*(CEIL((((EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*FLOOR((0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)+0.5)*(5.0/6)*(97.5/100))/12.5)*1.5)))',

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 6,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            {
              :symbolic_id => 'building_training_cave',
              :id => 10,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'LESS(LEVEL,11)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.125*1.5+0.5)',
            1 => 'LESS(LEVEL,11)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.125*1.5+0.5)',
            2 => 'LESS(LEVEL,11)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2.25*1.5+0.5)',
            
          },

          :production_time => 'LESS(LEVEL,11)*FLOOR((((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*1.1+0.5)*3)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],

          :abilities   => {

          },

        },              #   END OF Trainingshöhle
        {               #   Tüftler-Werkstatt
          :id          => 11, 
          :symbolic_id => :building_artifact_stand,
					:category    => 6,
          :db_field    => :building_artifact_stand,
          :name        => {
            
            :de_DE => "Tüftler-Werkstatt",
  
            :en_US => "Workshop",
                
          },
          :flavour     => {
            
            :de_DE => "<p>Die Tüftler warten bereits auf die Artefakte. Hol Dir eins!</p>",
  
            :en_US => "<p>Those Tinkers are insane! Enter at your own risk.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>In der Werkstatt vereinen die Tüftler Einfallsreichtum mit blindem Aktionismus. Hier werden alle unbekannten Materialien -oder Artefakte wie die einfältigen Krieger sagen- eingehend untersucht und unglaubliche technische Revolutionen gestartet. </p><p>Dieses Gebäude kann nicht abgerissen werden.</p>",
  
            :en_US => "<p>Thinkers and Tinkers get together at the workshop. They examine whatever unknown materials there are - artifacts, as the simple-minded call them - and attempt to bring about a technological revolution.</p><p>This building can not be torn down.</p>",
                
          },

          :hidden      => 0,

	        :population  => "LESS(LEVEL,11)*(FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*2))",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> false,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 12,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 7,

            },

            {
              :symbolic_id => 'building_artifact_stand',
              :id => 11,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'LESS(LEVEL,11)*(FLOOR(7500*POW(LEVEL,0.4)))',
            1 => 'LESS(LEVEL,11)*(FLOOR(10000*POW(LEVEL,0.4)))',
            2 => 'LESS(LEVEL,11)*(FLOOR(12500*POW(LEVEL,0.4)))',
            
          },

          :production_time => 'LESS(LEVEL,11)*(FLOOR(11*3600+3600*POW(LEVEL,0.7)))',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],

          :abilities   => {

            :unlock_artifact_initiation => "LEVEL",

          },

        },              #   END OF Tüftler-Werkstatt
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
            
            :en_US => "<p>A furrier know there are many ways to skin a creature. They have lovely furs and quality leatherwear that appeals to sophisticated ladies, and of course, there's usually something tasty roasting over the fire too.</p>",
  
            :de_DE => "<p>Der Kürschner zieht dem Tier das Fell über die Ohren. Hier gibt es schöne Felle und hochwertige Lederwaren für die Dame von Welt.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Kürschner verarbeitet Häute zu Leder und macht selbst aus den kleinsten Nagern noch ein brauchbares Fell. Wenn ein Säbelzahntiger erlegt wird, dann zaubert der Kürschner etwas für die Dame von Welt.</p>",
  
            :en_US => "<p>The furrier's job is to turn skins into leather - he can make a useful hide out of even the smallest of rodents. And if a sabre-toothed tiger should be killed, he can also conjure up something for a sophisticated lady. The waste from larger furriers' businesses can be processed by smaller furriers with lower overheads, giving a noticeable boost to fur production.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 8,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 8,

            },

            ],

          ],          

          :costs      => {
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5)',
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*1.1+0.5)',
          :production  => [
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*FLOOR((0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)+0.5)*(5.0/6)*(97.5/100)",
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
            :target_level_formula  => "LEVEL-GREATER(LEVEL,1)-GREATER(LEVEL,7)-GREATER(LEVEL,15)", 
          },

        },              #   END OF Kürschner
        {               #   Kupferschmelze
          :id          => 13, 
          :symbolic_id => :building_copper_smelter,
					:category    => 6,
          :db_field    => :building_copper_smelter,
          :name        => {
            
            :de_DE => "Kupferschmelze",
  
            :en_US => "Copper Smelter",
                
          },
          :flavour     => {
            
            :en_US => "<p>Copper shines even in its unprocessed state, but it can only be made into jewellery once it's been smelted. It can also be used to make the occasional implement.</p>",
  
            :de_DE => "<p>Ah Kupfer, ich mag diesen rot-goldenen Schimmer. Sogar die Werkzeuge und Waffen lass sich damit verbessern, auch wenn mir Schmuck lieber ist.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kupfer ist DIE Entdeckung der Steinzeit und führte zu schönerem Schmuck und tödlicheren Waffen und auch dem ein oder anderen Fortschritt bei Werkzeugen. Die Kupferschmelze ermöglicht den Fortschritt in die Kupferzeit und den Zugriff auf neue fortschrittlichere Gebäude.</p><p>Dieses Gebäude kann nicht abgerissen werden.</p>",
  
            :en_US => "<p>Copper is THE discovery that moved the Stone Age forward into… yes, you guessed it, the Copper-Stone Age. Its discovery leads to not only the creation of some very attractive jewellery, but also to more deadly weapons and progress in making many kinds of implements and tools.</p><p>This building can not be torn down.</p>",
                
          },

          :hidden      => 0,

	        :population  => "LESS(LEVEL,11)*(FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1))",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 12,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*12000+GREATER(LEVEL,1)*(12000+FLOOR(125*POW(LEVEL,2))))',
            1 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*12000+GREATER(LEVEL,1)*(12000+FLOOR(125*POW(LEVEL,2))))',
            2 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*12000+GREATER(LEVEL,1)*(12000+FLOOR(125*POW(LEVEL,2))))',
            3 => 'LESS(LEVEL,11)*MAX(LEVEL-8,0)',
            
          },

          :production_time => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*43200+GREATER(LEVEL,1)*(72800+(FLOOR(1.88*POW(LEVEL-1,1.9)+0.5)*6/100+1)*25000)*0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],

          :abilities   => {

          },

        },              #   END OF Kupferschmelze
        {               #   Schießstand
          :id          => 14, 
          :symbolic_id => :building_firing_range,
					:category    => 5,
          :db_field    => :building_firing_range,
          :name        => {
            
            :de_DE => "Schießstand",
  
            :en_US => "Firing Range",
                
          },
          :flavour     => {
            
            :en_US => "<p>Don't feel like brawling or getting up close and personal with stinky animals? Prefer to kill your enemy from a safe distance? Then ranged combat is right up your alley.</p>",
  
            :de_DE => "<p>Keine Lust auf Prügeleien oder stinkende Tiere? Du willst deinen Gegner am liebsten aus sicherer Entfernung töten? Dann ist Fernkampf dein Ding!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Steine, Speere und alles, was man werfen oder schießen kann, fliegt auf dem Ausbildungsgelände für Fernkämpfer durch die Luft.</p>",
  
            :en_US => "<p>Stones, spears and anything else that can be thrown or shot flies through the air at the long-range combat training ground. The larger the grounds, the faster the training – as well as the development of completely new techniques which, in turn, form the basis of the training of new units.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*2)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 4.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 1,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 11,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*1.5*1.5)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*3*1.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(1600+200*LEVEL)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*3+0.5)',
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
                :speedup_formula   => "LESS(LEVEL,11)*FLOOR(1.25*POW(LEVEL,1.3)+0.5)/100.0+GREATER(LEVEL,10)*FLOOR(0.3*POW(LEVEL,1.94)+0.5)/100.0",
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
        {               #   Stammeshalle
          :id          => 15, 
          :symbolic_id => :building_alliance_hall,
					:category    => 6,
          :db_field    => :building_alliance_hall,
          :name        => {
            
            :de_DE => "Stammeshalle",
  
            :en_US => "Tribes Hall",
                
          },
          :flavour     => {
            
            :en_US => "<p>Very large place where alliance members hold diplomatic exchanges or discussions.</p>",
  
            :de_DE => "<p>Gutes Essen, leckere Getränke und viel Platz. Ein würdiger Rahmen für große Verhandlungen!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>In der Stammeshalle versammeln sich die hochrangigen Vertreter alliierter Stämme zu langwierigen und oftmals feucht-fröhlichen Verhandlungen. Oder zum Bowling, wenn die Halle denn lang genug ist.</p><p>Mit jedem Ausbau der Stammeshalle kann die Allianz weitere Mitglieder aufnehmen.</p><p>Dieses Gebäude kann nicht abgerissen werden.</p>",
  
            :en_US => "<p>In the Tribes Hall, leaders of allied tribes gather together in sociable groups and discuss important arrangements. Or bowl, if the room is long enough. More developed halls make it possible to accept more alliance members into the meeting.</p><p>This building can not be torn down.</p>",
                
          },

          :hidden      => 0,

	        :population  => "100+20*LEVEL",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 1.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 11,

            },

            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 1,

            },

            {
              :symbolic_id => 'building_campfire',
              :id => 7,
              :type => 'building',

              :min_level => 10,

            },

            {
              :symbolic_id => 'building_alliance_hall',
              :id => 15,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'LESS(LEVEL,11)*25000*POW(LEVEL,1.25)',
            1 => 'LESS(LEVEL,11)*25000*POW(LEVEL,1.25)',
            2 => 'LESS(LEVEL,11)*25000*POW(LEVEL,1.25)',
            
          },

          :production_time => 'LESS(LEVEL,11)*CEIL((30*POW(LEVEL+4,3.2)+47547*(0.06*(LEVEL-5)+0.98))*1.1*3+0.5)
      ',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],

          :abilities   => {

            :alliance_size_bonus => "MAX(LEVEL,0)",

          },

        },              #   END OF Stammeshalle
        {               #   Winddichte Hütte
          :id          => 16, 
          :symbolic_id => :building_cottage_2,
					:category    => 5,
          :db_field    => :building_cottage_2,
          :name        => {
            
            :de_DE => "Winddichte Hütte",
  
            :en_US => "Windproof Hut",
                
          },
          :flavour     => {
            
            :en_US => "<p>A fireplace, a neatly fenced front lawn and a front doormat. Living the dream!</p>",
  
            :de_DE => "<p>Ein Feuerplatz, eingezäunter Vorgarten und eine Fußmatte vor der Tür. Ein Traum!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>In der fortschrittlichen winddichten Hütten wohnen die verdienten sprich fleißigen Bewohner. Diese Hütte hat neben Wände, die diesen Namen auch verdienen, sogar einen Feuerplatz, wodurch die Bewohner noch zufriedener werden. Und sie ist natürlich größer, denn seien wir mal ehrlich, zwei Arbeiter sind immer besser als ein zufriedener.</p>",
  
            :en_US => "<p>These modern, windproof huts are where the deserving - that is, hard-working - residents live. Apart from walls that can actually be called walls, there's also a fireplace, which makes the people who live there considerable more satisfied. And, of course, windproof huts are bigger because, let's be honest, two grumpy workers are still better than one happy one.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*2)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 3.3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 2,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 12,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.75*1.5*8.05+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.5*1.5*8.05+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*0.25*1.5*8.05+0.5)',
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
                :speedup_formula   => "LESS(LEVEL,11)*(FLOOR((1.25*POW(LEVEL,1.3)+0.5)*3*1.75)/100.0)+GREATER(LEVEL,10)*FLOOR((0.3*POW(LEVEL,1.94)+0.5)*3*1.75)/100.0",
              },

            ],

          },

        },              #   END OF Winddichte Hütte
        {               #   Großes Rohstofflager
          :id          => 17, 
          :symbolic_id => :building_storage_2,
					:category    => 5,
          :db_field    => :building_storage_2,
          :name        => {
            
            :de_DE => "Großes Rohstofflager",
  
            :en_US => "Great Store",
                
          },
          :flavour     => {
            
            :en_US => "<p>Stone containers, dinosaur cranes, and - more recently - copper carts. At last, raw materials can be transported in style.</p>",
  
            :de_DE => "<p>Steincontainer, Saurierkräne und, seit neuestem, Kupferkarren. Endlich können Rohstoffe mit Stil transportiert werden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kupferkarren! DAS Statussymbol für den Häuptling. Neben den Karren gibt es auch größeren Lagerraum, aber wen interessiert das neben in der Sonne blinkenden Kupferkarren.</p>",
  
            :en_US => "<p>Copper carts! THE status symbol for a chieftain. There is also a bigger store room, but who cares when you see those shiny copper carts gleaming in the sunlight.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1.5)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 3.3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 3,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 13,

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
                :formula            => "FLOOR(EQUAL(LEVEL,1)*140+(POW(LEVEL,2)*100)*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.03))*1.75)",
              },
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR(EQUAL(LEVEL,1)*140+(POW(LEVEL,2)*100)*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.03))*1.75)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR(EQUAL(LEVEL,1)*140+(POW(LEVEL,2)*100)*MIN(1.5,MAX(1.2,1.2+(LEVEL-10)*0.03))*1.75)",
              },
            
          ],

          :abilities   => {

            :trading_carts => "FLOOR(5*LEVEL*LEVEL*2)",

            :unlock_p2p_trade => 1,            

          },

        },              #   END OF Großes Rohstofflager
        {               #   Altehrwürdiger Steinbruch
          :id          => 18, 
          :symbolic_id => :building_quarry_2,
					:category    => 5,
          :db_field    => :building_quarry_2,
          :name        => {
            
            :de_DE => "Altehrwürdiger Steinbruch",
  
            :en_US => "Age Old Stone Quarry",
                
          },
          :flavour     => {
            
            :en_US => "<p>In the Copper-Stone Age, you'd expect workers to have copper pickaxes - but the workers actually preferred to invest their copper in jewellery for their wives. The fact they chose this option suggests their grateful wives gave them some pretty lavish rewards...</p>",
  
            :de_DE => "<p>Der Fortschritt ist eindeutig ablesbar. Starke muskulöse Arbeiter im Steinbruch, behangen mit schönstem Kupferschmuck.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Wie in Steinbrüchen mit Beginn der Kupferzeit mehr Steine abgebaut worden konnten, bleibt rätselhaft. Denn nur hier wurden keine Kupferwerkzeuge benutzt. Aber trotzdem ging der Abbau spürbar schneller.</p><p>Ab Level 11 werden die Arbeiter noch schneller und treiben sogar Arbeiter in anderen Steinbrüchen zu schnellerer Arbeit an.</p>",
  
            :en_US => "<p>How workers managed to excavate so much stone from the quarries of the Copper-Stone Age is a mystery, considering that they still weren't using copper implements. Despite this, excavation was noticeably faster at this time. Workers above a certain size were even faster still, encouraging workers in other quarries to work faster as well.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1.5)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 3.3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 4,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 14,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR((LESS(LEVEL,9)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.75*1.5+0.5))+EQUAL(LEVEL,9)*8000+GREATER(LEVEL,9)*(20000+(LEVEL-10)*2000))*0.5+0.5)',
            1 => '(LESS(LEVEL,9)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.75*1.5+0.5))+EQUAL(LEVEL,9)*8000+GREATER(LEVEL,9)*(20000+(LEVEL-10)*2000))',
            3 => 'MAX(LEVEL-19,0)*2',
            
          },

          :production_time => 'FLOOR(((LESS(LEVEL,11)*30*POW(LEVEL,3.2)+GREATER(LEVEL,10)*47547*(0.06*(LEVEL-10)+0.98))*1.1+0.5)*1.75)',
          :production  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR((EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*(0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)*(5.0/6)*(97.5/100))*1.75+0.5)",
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
        {               #   Holzfäller mit Kupferaxt
          :id          => 19, 
          :symbolic_id => :building_logger_2,
					:category    => 5,
          :db_field    => :building_logger_2,
          :name        => {
            
            :de_DE => "Holzfäller mit Kupferaxt",
  
            :en_US => "Logger with Copper Axe",
                
          },
          :flavour     => {
            
            :en_US => "<p>A man and his copper axe! Although copper axes always bend, this worker can still bring home the trees he's felled himself as well as some brushwood.</p>",
  
            :de_DE => "<p>Ein Mann und seine Kupferaxt! Stoff einiger Gesänge und mancher Träume.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kupferäxte fällen einen Baum deutlich schneller. Leider sind Kupferäxte auch sehr reparaturbedürftig. Dennoch sind Holzfäller effektiver und leiten ab einer bestimmten Größe auch die normalen Holzfäller zu erhöhtem Bäume fällen an.</p>",
  
            :en_US => "<p>Copper axes fell trees much more quickly - unfortunately they need a lot of repairing as well. However, the loggers who use them are more efficient and can motivate ordinary loggers to fell more trees, generally of the smaller variety.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1.5)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 3.3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 4,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 14,

            },

            ],

          ],          

          :costs      => {
            0 => 'LESS(LEVEL,9)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.75*1.5+0.5))+EQUAL(LEVEL,9)*8000+GREATER(LEVEL,9)*(20000+(LEVEL-10)*2000)',
            1 => 'FLOOR((LESS(LEVEL,9)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.75*1.5+0.5))+EQUAL(LEVEL,9)*8000+GREATER(LEVEL,9)*(20000+(LEVEL-10)*2000))*0.5+0.5)',
            3 => 'MAX(LEVEL-19,0)*2',
            
          },

          :production_time => 'FLOOR(((LESS(LEVEL,11)*30*POW(LEVEL,3.2)+GREATER(LEVEL,10)*47547*(0.06*(LEVEL-10)+0.98))*1.1+0.5)*1.75)',
          :production  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR((EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*(0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)*(5.0/6)*(97.5/100))*1.75+0.5)",
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
        {               #   Stinkender Stall
          :id          => 20, 
          :symbolic_id => :building_stud,
					:category    => 5,
          :db_field    => :building_stud,
          :name        => {
            
            :de_DE => "Stinkender Stall",
  
            :en_US => "Smelly Barn",
                
          },
          :flavour     => {
            
            :en_US => "<p>Smelly animals and a kitty cat to play with. Life on the stud farm couldn't be better.</p>",
  
            :de_DE => "<p>Stinkende Tiere und eine kleine Katze. Ein Leben auf dem Ponyhof könnte nicht schöner sein.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kein Ort in der Siedlung stinkt so sehr wie der Stall. Nicht weiter verwunderlich, werden hier doch Straußen, Säbelzahntiger, kleine Dinosaurier und als Maskottchen eine Katze gehalten. Die Ausbildung der Reiter umfasst nur den Umgang mit den Tieren. Waffen führen die Reiter nicht, sie reiten auf einer!</p><p>Größere Ställe stinken noch stärker, beschleunigen aber auch die Ausbildung und können noch stärkere Tiere abrichten.</p>",
  
            :en_US => "<p>The barn smells like no other building in the settlement. Not surprisingly, given that it's where ostriches, sabre-toothed tigers and little dinosaurs are kept - as well as a kitty cat as a mascot. The animals are trained here and the riders are taught how to handle them. Very few riders carry their weapons into battle, as they have to concentrate on riding. Their mount is their weapon! Big barns smell even worse - but having them does speed up the training and they can also drill bigger animals.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*2)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 4.5,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 5,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 15,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*3*1.5)',
            1 => 'FLOOR(((3535*(0.063*POW(MIN(LEVEL,10),3)+0.87*POW(MIN(LEVEL,10),2)-3*MIN(LEVEL,10)+104.55+0.5)*0.01*0.5)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(-2.43)+(0.06*(MAX(LEVEL-10,0))+0.98)*3.5))*1.5*1.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(1600+200*LEVEL)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*3+0.5)',
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
                :speedup_formula   => "LESS(LEVEL,11)*FLOOR(1.25*POW(LEVEL,1.3)+0.5)/100.0+GREATER(LEVEL,10)*FLOOR(0.3*POW(LEVEL,1.94)+0.5)/100.0",
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
        {               #   Kommandozentrale
          :id          => 21, 
          :symbolic_id => :building_command_post,
					:category    => 4,
          :db_field    => :building_command_post,
          :name        => {
            
            :de_DE => "Kommandozentrale",
  
            :en_US => "Central Command Post",
                
          },
          :flavour     => {
            
            :en_US => "<p>Coordinating armies is the art of war. Even if all armies are dispatched in the same direction with the order to “hit 'em hard”.</p>",
  
            :de_DE => "<p>Die Koordination von Armeen ist die hohe Kunst des Krieges -jaja- und dann schreien alle 'immer feste druff' und rennen los..</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein schöner großer Sitz für den Häuptling und fertig ist der Kommandoposten. Taktik und Befehl ist immer der gleiche: 'Haut sie feste!'</p><p>Der Kommandoposten erhöht auf den Leveln 1, 10 und 20 die maximale Anzahl an Armeen. Zudem wird die Produktionszeit aller Einheiten gesenkt.</p>",
  
            :en_US => "<p>A couple of branches stretched between three trees, a bit of bark and some leaves, and there's your awning. A nice big seat for the chief, and hey presto, you've got your command post. This is where tactics are decided and orders are given. Mostly the same order: “Hit 'em hard!” Having a command post increases a settlement's command points at Levels 1, 10 and 20. It also decreases the time spent on training new units.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*2)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 10,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 6,

            },

            {
              :symbolic_id => 'building_command_post',
              :id => 21,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'EQUAL(LEVEL,1)*12000+GREATER(LEVEL,1)*(12000+FLOOR(180*POW(LEVEL,2)))+GREATER(LEVEL,10)*2300*LEVEL',
            1 => 'EQUAL(LEVEL,1)*12000+GREATER(LEVEL,1)*(12000+FLOOR(180*POW(LEVEL,2)))+GREATER(LEVEL,10)*2300*LEVEL',
            2 => '(EQUAL(LEVEL,1)*12000+GREATER(LEVEL,1)*(12000+FLOOR(180*POW(LEVEL,2)))+GREATER(LEVEL,10)*2300*LEVEL)*0.5',
            3 => 'EQUAL(LEVEL,10)+MAX(LEVEL-19,0)*2',
            
          },

          :production_time => 'EQUAL(LEVEL,1)*32*3600+EQUAL(LEVEL,2)*34*3600+GREATER(LEVEL,2)*FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*4)+EQUAL(LEVEL,20)*1570',
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
                :speedup_formula   => "LESS(LEVEL,11)*FLOOR(1.25*POW(LEVEL,1.3)+0.5)/100.0+GREATER(LEVEL,10)*FLOOR(0.3*POW(LEVEL,1.94)+0.5)/100.0",
              },

              {
                :queue_type_id     => 3,
                :queue_type_id_sym => :queue_artillery,
                :domain            => :settlement,
                :speedup_formula   => "LESS(LEVEL,11)*FLOOR(1.25*POW(LEVEL,1.3)+0.5)/100.0+GREATER(LEVEL,10)*FLOOR(0.3*POW(LEVEL,1.94)+0.5)/100.0",
              },

              {
                :queue_type_id     => 4,
                :queue_type_id_sym => :queue_cavalry,
                :domain            => :settlement,
                :speedup_formula   => "LESS(LEVEL,11)*FLOOR(1.25*POW(LEVEL,1.3)+0.5)/100.0+GREATER(LEVEL,10)*FLOOR(0.3*POW(LEVEL,1.94)+0.5)/100.0",
              },

            ],

            :command_points => "1+GREATER(LEVEL,9)+EQUAL(LEVEL,20)",

          },

        },              #   END OF Kommandozentrale
        {               #   Verrückter Kürschner
          :id          => 22, 
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
            
            :de_DE => "<p>Die Kupfermesser waren aus Sicht der Kürschner ein Geschenk der Götter. Es  macht aus einfachen Kürschnern wahre Künstler. Leider mit den bekannten Nebeneffekten: Fächer wedeln, nasale Stimme und sonstigem Irrsinn.</p>",
  
            :en_US => "<p>The copper knife was a gift from the gods. At least, that's what the furriers who use their copper knives to create gorgeous clothes like to believe. Sadly, members of this group suffer from the usual side effects of a life in haute couture - vigorous fanning, a high-pitched and nasal voice, and generally crazy conduct - all in the name of art, of course. They may be mad, but they set a great example for other furriers.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1.5)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 3.3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
              :type => 'building',

              :min_level => 7,

            },

            ],

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 17,

            },

            ],

          ],          

          :costs      => {
            1 => 'FLOOR((LESS(LEVEL,9)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.75*1.5+0.5))+EQUAL(LEVEL,9)*8000+GREATER(LEVEL,9)*(20000+(LEVEL-10)*2000))*0.5+0.5)',
            0 => 'FLOOR((LESS(LEVEL,9)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.75*1.5+0.5))+EQUAL(LEVEL,9)*8000+GREATER(LEVEL,9)*(20000+(LEVEL-10)*2000))*0.5+0.5)',
            2 => 'FLOOR((LESS(LEVEL,9)*(FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*1.75*1.5+0.5))+EQUAL(LEVEL,9)*8000+GREATER(LEVEL,9)*(20000+(LEVEL-10)*2000))*0.5+0.5)',
            3 => 'MAX(LEVEL-19,0)*2',
            
          },

          :production_time => 'FLOOR(((LESS(LEVEL,11)*30*POW(LEVEL,3.2)+GREATER(LEVEL,10)*47547*(0.06*(LEVEL-10)+0.98))*1.1+0.5)*1.75)',
          :production  => [
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR((EQUAL(LEVEL,1)*8+EQUAL(LEVEL,2)*11+EQUAL(LEVEL,3)*17+EQUAL(LEVEL,4)*26+EQUAL(LEVEL,5)*39+EQUAL(LEVEL,6)*55+EQUAL(LEVEL,7)*74+GREATER(LEVEL,7)*(0.007*POW(LEVEL+1.76,3.52)+0.11*POW(LEVEL+1.66,3)-1.11*POW(LEVEL+1.66,2)+13*LEVEL-2.3333)*(5.0/6)*(97.5/100))*1.75+0.5)",
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
            
            :en_US => "<p>Warriors or soldiers of any kind should be kept apart from the ordinary working population. In the garrison they can bash each others' heads in and leave the poor settlement dwellers in peace.</p>",
  
            :de_DE => "<p>Aus Sicherheitsgründen werden die Krieger getrennt von der arbeitenden Bevölkerung gehalten. Nicht, dass den Kriegern noch was zustößt!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Das Garnionsgebäude dient zur Unterbringung und Versorgung der Einheiten und Armeen.</p><p>Jedes Level der Garnison erhöht die maximale Anzahl der Einheiten in der Garnison und in den Armeen um 25.</p><p>Dieses Gebäude kann nicht abgerissen werden.</p>",
  
            :en_US => "<p>Well, who would have thought it? Field armies also benefit from the increased discipline that having a garrison provides. And that means that bigger armies can be deployed in the field.</p><p>This building can not be torn down.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*2)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 3,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_copper_smelter',
              :id => 13,
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
              :id => 24,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'EQUAL(LEVEL,1)*12000+GREATER(LEVEL,1)*(12000+FLOOR(180*POW(LEVEL,2)))+GREATER(LEVEL,10)*2300*LEVEL',
            1 => 'EQUAL(LEVEL,1)*12000+GREATER(LEVEL,1)*(12000+FLOOR(180*POW(LEVEL,2)))+GREATER(LEVEL,10)*2300*LEVEL',
            2 => '(EQUAL(LEVEL,1)*12000+GREATER(LEVEL,1)*(12000+FLOOR(180*POW(LEVEL,2)))+GREATER(LEVEL,10)*2300*LEVEL)*0.5',
            3 => 'EQUAL(LEVEL,10)+MAX(LEVEL-19,0)*2',
            
          },

          :production_time => 'EQUAL(LEVEL,1)*32*3600+EQUAL(LEVEL,2)*34*3600+GREATER(LEVEL,2)*FLOOR((30000*POW(2.71828,0.04*MIN(LEVEL,10))*(0.06*(MAX(LEVEL-10,0))+1))*4)+EQUAL(LEVEL,20)*1570',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],

          :abilities   => {

            :garrison_size_bonus => "25*LEVEL",

            :army_size_bonus => "25*LEVEL",

          },

        },              #   END OF Garnisonsgebäude
        {               #   Versammlungsplatz
          :id          => 24, 
          :symbolic_id => :building_haunt,
					:category    => 4,
          :db_field    => :building_haunt,
          :name        => {
            
            :de_DE => "Versammlungsplatz",
  
            :en_US => "Meeting Place",
                
          },
          :flavour     => {
            
            :en_US => "<p>This is where all the important people in the compound meet every evening to discuss important issues. Like, for instance, how to solve the troubling shortage of beer they've been experiencing lately...</p>",
  
            :de_DE => "<p>Thema für die Versammlung heute: 'Wie lösen wir die Bierflaute?'</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Versammlungsplatz ist der zentrale Ort einer neu gegründeten Lagerstätte. Ein großer Pfahl mit den Insignien der Macht sowie ein paar Baumstümpfe zum sitzen.</p>",
  
            :en_US => "<p>The meeting place is in the middle of the compound. It's an area that has been left vacant by chance, and it has just enough space for a few raw materials and the dwellers' cosy evening gatherings.</p>",
                
          },

          :hidden      => 0,

	        :population  => "(FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*0.5))",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 6,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => '(EQUAL(LEVEL,2)*250+EQUAL(LEVEL,3)*400+EQUAL(LEVEL,4)*700+GREATER(LEVEL,4)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5))',
            1 => '(EQUAL(LEVEL,2)*250+EQUAL(LEVEL,3)*400+EQUAL(LEVEL,4)*700+GREATER(LEVEL,4)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5))',
            2 => '(EQUAL(LEVEL,2)*250+EQUAL(LEVEL,3)*400+EQUAL(LEVEL,4)*700+GREATER(LEVEL,4)*FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5))',
            3 => 'EQUAL(LEVEL,20)*1',
            
          },

          :production_time => 'GREATER(LEVEL,1)*(EQUAL(LEVEL,2)*3600+LESS(LEVEL,11)*(3600*FLOOR(POW(LEVEL,1.5)-1))+GREATER(LEVEL,10)*(3600*(FLOOR(POW(LEVEL,0.8)-MAX(LEVEL-5,0)))+29*3600))',
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

            :defense_bonus => "0.2*LEVEL",

            :unlock_garrison => 2,            

            :command_points => "GREATER(LEVEL,1)",

            :unlock_building_slots => "MIN(1+MIN(LEVEL,10),11)",

            :garrison_size_bonus => "LESS(LEVEL,20)*300+EQUAL(LEVEL,20)*400",

            :army_size_bonus => "LESS(LEVEL,20)*300+EQUAL(LEVEL,20)*400",

          },

        },              #   END OF Versammlungsplatz
        {               #   Feldlager
          :id          => 25, 
          :symbolic_id => :building_field_camp,
					:category    => 4,
          :db_field    => :building_field_camp,
          :name        => {
            
            :de_DE => "Feldlager",
  
            :en_US => "Field Camp",
                
          },
          :flavour     => {
            
            :en_US => "<p>Field camps turn encampments into military support units. Despite all the talk about the safety and storage that field camps offer, they seem to have a magical attraction for enemies.</p>",
  
            :de_DE => "<p>Mit dem Feldlager verwandeln wir Lagerstätten in militärische Stützpunkte. Größere Armeen und gleich zwei davon!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Mit Bau des Feldlagers ist es endgültig klar: „Wir sind nicht zum Spass hier, wir wollen kämpfen!“</p><p>Das Feldlager erhöht die Garnison und die Armee um 100 Einheiten plus 50 pro Level auf Level 1-10 und 30 pro Level auf Level 11-20. Auf Level 10 ermöglicht dem Feldlager einen zweiten Kommandopunkt.</p>",
  
            :en_US => "<p>Once a field camp is built, the message is clear - We're here to fight, not to have fun! Having a field camp means that more fighters can be deployed: 100 plus 50 per level at Levels 1-10 and 30 per level at Levels 11-20. At Level 10, a field camp also increases a settlement's command points by one.</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1.5)",
  
          :buyable     => false,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> false,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => true,
          :experience_factor => 8,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 6,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2*1.5+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'EQUAL(LEVEL,1)*24*3600+GREATER(LEVEL,1)*(FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(1800+200*LEVEL)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*3+0.5)*0.65)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],

          :abilities   => {

            :command_points => "GREATER(LEVEL,9)",

            :garrison_size_bonus => "100+50*LEVEL-GREATER(LEVEL,10)*(LEVEL-10)*20",

            :army_size_bonus => "100+50*LEVEL-GREATER(LEVEL,10)*(LEVEL-10)*20",

          },

        },              #   END OF Feldlager
        {               #   Ritualstein
          :id          => 26, 
          :symbolic_id => :building_altar,
					:category    => 4,
          :db_field    => :building_altar,
          :name        => {
            
            :de_DE => "Ritualstein",
  
            :en_US => "Altar",
                
          },
          :flavour     => {
            
            :en_US => "<p>The ceremonies and regular sacrifices carried out on the altar are intended to appease the gods. An encampment blessed by the gods cannot be conquered by enemies.</p>",
  
            :de_DE => "<p>Die auf dem Ritualstein durchgeführten Zeremonien und regelmäßigen Opfergaben besänftigen die Götter, so dass eine Lagerstätte nicht von Feinden erobert werden kann.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Ritualstein ist ein von Fackeln umringter von blutigen Opfergaben verschmierter und mit den Gaben der Felder und den Köpfen der Feinde dekorierter Steintisch. Dieser Steintisch begeistert auch die Götter. Zumindest ist die Lagerstätte mit einem Ritualstein vor einer feindlichen Übernahme sicher. Wenn das kein Wink der Götter ist!</p>",
  
            :en_US => "<p>The altar is a stone table surrounded by torches, smeared with blood from sacrificial offerings and decorated with gifts from the field and the heads of enemies. This stone table also impresses the gods. An encampment with an altar is safe from being conquered by enemies. If that isn't a sign from the gods, then what is?</p>",
                
          },

          :hidden      => 0,

	        :population  => "FLOOR(((MIN(LEVEL+1,7)-MIN(LEVEL,7))*(1.7*POW(LEVEL,1.65))+(MIN(LEVEL,7)-MIN(LEVEL,6))*(3.75*POW((LEVEL-6),2)+14.75*(LEVEL-6)+31.25)+(MIN(LEVEL,11)-MIN(LEVEL,10))*25+EQUAL(LEVEL,20)*2+0.5)*1.5)",
  
          :buyable     => false,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> false,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => true,
          :experience_factor => 8,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_haunt',
              :id => 24,
              :type => 'building',

              :min_level => 6,

            },

            {
              :symbolic_id => 'building_chief_cottage',
              :id => 0,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

            ],

          ],          

          :costs      => {
            0 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5)',
            1 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*3*1.5+0.5)',
            2 => 'FLOOR(((0.9*POW(MIN(LEVEL,10),4)-9.7*POW(MIN(LEVEL,10),3)+49.25*POW(MIN(LEVEL,10),2)-76*MIN(LEVEL,10)+70)*((MIN(LEVEL+1,11)-MIN(LEVEL,11))*0.02+(0.06*(MAX(LEVEL-10,0))+0.98)))*2*1.5+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'EQUAL(LEVEL,1)*36*3600+GREATER(LEVEL,1)*(FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(1800+200*LEVEL)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*30*POW(LEVEL,3.2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*47547*(0.06*(LEVEL-10)+0.98))*3+0.5)*0.65)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],

          :abilities   => {

            :unlock_prevent_takeover => 1,            

          },

        },              #   END OF Ritualstein
        {               #   Festungsanlagen
          :id          => 27, 
          :symbolic_id => :building_fortress_fortification,
					:category    => 0,
          :db_field    => :building_fortress_fortification,
          :name        => {
            
            :de_DE => "Festungsanlagen",
  
            :en_US => "Fortification",
                
          },
          :flavour     => {
            
            :en_US => "<p>The fortress rules the region. Troops are deployed to collect taxes from the settlements and protect the fortress from attacks.</p>",
  
            :de_DE => "<p>Die Festung beherrscht die Region. Hier werden Krieger ausgebildet und Steuern erhoben.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein paar aufgetürmte Steinbrocken, zusammengebundene Baumstämme, ein provisorisches Tor. Die Festungsanlagen bestehen aus einen Hauptgebäude, einem kleinen Versammlungsplatz und Mauern zur Verteidigung.</p><p>Die Festungsanlagen liefern einen zusätzlichen Kommandopunkt auf Level 10.</p>",
  
            :en_US => "<p>A couple of stacked-up stones, some tree-trunks tied together, a makeshift gate. Fortress compounds consist of a main building, a small meeting place and walls for defence.</p>",
                
          },

          :hidden      => 0,

	        :population  => "(FLOOR(40+(2.45*POW(LEVEL,2.3)-1.5*LEVEL)*1.5)*3+250)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> false,
          :destructable=> false,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 8,

          :costs      => {
            0 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,2)*2000+GREATER(LEVEL,2)*FLOOR((POW(MAX(LEVEL-2,1),1.6)*4000)+0.5))',
            1 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,2)*2000+GREATER(LEVEL,2)*FLOOR((POW(MAX(LEVEL-2,1),1.6)*4000)+0.5))',
            2 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,2)*200+GREATER(LEVEL,2)*FLOOR((POW(MAX(LEVEL-2,1),1.6)*4000)+0.5))',
            3 => 'LESS(LEVEL,11)*(GREATER(LEVEL,9)*1)',
            
          },

          :production_time => 'LESS(LEVEL,11)*(GREATER(LEVEL,1)*(58400+(FLOOR(1.88*POW(LEVEL-1,1.9)+0.5)*6/100+1)*25000))',
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

            :command_points => "1+GREATER(LEVEL,9)",

            :unlock_building_slots => "MIN(LEVEL,1)*2",

            :garrison_size_bonus => "1000",

            :army_size_bonus => "1000",

          },

        },              #   END OF Festungsanlagen
        {               #   Turm der Knüppelei
          :id          => 28, 
          :symbolic_id => :building_infantry_tower,
					:category    => 1,
          :db_field    => :building_infantry_tower,
          :name        => {
            
            :de_DE => "Turm der Knüppelei",
  
            :en_US => "Infantry Tower",
                
          },
          :flavour     => {
            
            :en_US => "<p>This is no place for thinkers! Infantry members need strength and stamina - nothing else.</p>",
  
            :de_DE => "<p>Hier ist kein Platz für Denker! Kraft und Ausdauer braucht ein Nahkämpfer, sonst nix!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>In dem Turm der Knüppelei werden die Nahkämpfer in der Kunst des Nahkampfes unterwiesen. Der überaus sadistische Ausbilder legt höchsten Wert auf Gehorsam und Disziplin. Wer den Befehlen nicht gehorcht oder sich im Training noch dümmer anstellt als die anderen, der muss im Turm der Reitmeisterei putzen.</p>",
  
            :en_US => "<p>In the infantry tower, infantry troops are instructed in the art of fighting. Their extremely sadistic trainer sets great store by obedience and discipline. If someone doesn't obey orders or is even more stupid than everyone else during training, he has to clean the stables in the cavalry tower.</p>",
                
          },

          :hidden      => 0,

	        :population  => "LESS(LEVEL,11)*(FLOOR(40+(2.45*POW(LEVEL,2.3)-1.5*LEVEL)*1.5*2))+(EQUAL(LEVEL,10)*39)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 6,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 27,
              :type => 'building',

              :min_level => 1,

            },

            ],

          ],          

          :costs      => {
            0 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*900+GREATER(LEVEL,1)*(FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*3*1.5+0.5-3)))',
            1 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*900+GREATER(LEVEL,1)*(FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*1.5*1.5+0.5-2)))',
            2 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,2)*300+(MIN(LEVEL,3)-MIN(LEVEL,2))*FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*1.5+0.5))',
            3 => 'LESS(LEVEL,11)*(GREATER(LEVEL,9)*1)',
            
          },

          :production_time => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*43200+GREATER(LEVEL,1)*(72800+(FLOOR(1.88*POW(LEVEL-1,1.9)+0.5)*6/100+1)*25000)*0.5)',
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
                :speedup_formula   => "(LESS(LEVEL,11)*FLOOR(1.25*POW(LEVEL,1.3)+0.5)/100.0)*4",
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

        },              #   END OF Turm der Knüppelei
        {               #   Turm der Ballistik
          :id          => 29, 
          :symbolic_id => :building_artillery_tower,
					:category    => 1,
          :db_field    => :building_artillery_tower,
          :name        => {
            
            :de_DE => "Turm der Ballistik",
  
            :en_US => "Artillery Tower",
                
          },
          :flavour     => {
            
            :en_US => "<p>You'd better duck! Ranged combatant training is in full swing!</p>",
  
            :de_DE => "<p>Kopf runter! Die Ausbildung der Fernkämpfer ist in vollem Gang.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Achtung Helmpflicht! Die Ausbilder und Auszubildenden haben sich feste Tierhäute um den Kopf gebunden, damit sie den Aufprall kleiner Steiner oder Splitter halbwegs überstehen. Auf ein Kommando werden alle Arten von Wurfgeschossen in die Luft gesandt. Nur leider wissen die Wenigsten, auf welches Kommando sie eigentlich gerade achten sollen.</p>",
  
            :en_US => "<p>It's hardly surprising that helmets are compulsory in the artillery tower. Trainers and trainees both wear thick animal skins around their heads so that they can survive being hit by small stones and gravel. On command, all kinds of missiles are sent flying through the air. Unfortunately, no one really knows which command they should be obeying.</p>",
                
          },

          :hidden      => 0,

	        :population  => "LESS(LEVEL,11)*(FLOOR(40+(2.45*POW(LEVEL,2.3)-1.5*LEVEL)*1.5*2))+(EQUAL(LEVEL,10)*39)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 6,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 27,
              :type => 'building',

              :min_level => 5,

            },

            ],

          ],          

          :costs      => {
            0 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*(-416)+(FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*1.5*1.5*2.5+0.5)))',
            1 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*(-829)+(FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*3*1.5*2.5+0.5-3)))',
            2 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*(-944)+FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*1.5*2.5+0.5))',
            3 => 'LESS(LEVEL,11)*(GREATER(LEVEL,9)*1)',
            
          },

          :production_time => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*43200+GREATER(LEVEL,1)*(72800+(FLOOR(1.88*POW(LEVEL-1,1.9)+0.5)*6/100+1)*25000)*0.5)',
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
                :speedup_formula   => "(LESS(LEVEL,11)*FLOOR(1.25*POW(LEVEL,1.3)+0.5)/100.0)*4",
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
          :id          => 30, 
          :symbolic_id => :building_cavalry_tower,
					:category    => 1,
          :db_field    => :building_cavalry_tower,
          :name        => {
            
            :de_DE => "Turm der Reitmeisterei",
  
            :en_US => "Cavalry Tower",
                
          },
          :flavour     => {
            
            :en_US => "<p>This place is home to countless animals and sweaty men. Beware of the dung and pungent smell!</p>",
  
            :de_DE => "<p>Hier werden die berittenen Einheiten ausgebildet. Vorsicht vor Dung und penetrantem Geruch!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Zutritt ist streng begrenzt auf ausgebildete Reiter und Tierpfleger. Wenn das Tor der Reitmeisterei kurzzeitig offen steht, schleichen sich oftmals neugierige halbstarke Jungs hinein, um die Mädchen zu beeindrucken. Die wenigsten Jungen kommen allerdings noch in den Genuß sich in der Aufmerksamkeit zu sonnen.</p>",
  
            :en_US => "<p>Entrance is strictly limited to trained riders and animal keepers. If the gate is left open – even briefly – inquisitive, spotty teenage boys tend to sneak in. It impresses the girls no end, but the lads rarely get a chance to bathe in their admiration afterwards. The animal keepers generally deal with their bloody remains unceremoniously.</p>",
                
          },

          :hidden      => 0,

	        :population  => "LESS(LEVEL,11)*(FLOOR(40+(2.45*POW(LEVEL,2.3)-1.5*LEVEL)*1.5*2))+(EQUAL(LEVEL,10)*39)",
  
          :buyable     => true,
          :divine_supporters_only => false,
          :demolishable=> true,
          :destructable=> true,
          :takeover_downgrade_by_levels=> 1,
          :takeover_destroy  => false,
          :experience_factor => 6,

          :requirementGroups=> [

            [
              
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 27,
              :type => 'building',

              :min_level => 7,

            },

            ],

          ],          

          :costs      => {
            0 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*(-832)+(FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*3*1.5*2.5+0.5)))',
            1 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*(-416)+(FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*1.5*1.5*2.5+0.5)))',
            2 => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*(-944)+FLOOR(((0.9*POW(MIN(LEVEL+6,10),4)-9.7*POW(MIN(LEVEL+6,10),3)+49.25*POW(MIN(LEVEL+6,10),2)-76*MIN(LEVEL+6,10)+70)*((MIN(LEVEL+7,11)-MIN(LEVEL+6,11))*0.02+(0.06*(MAX(LEVEL-4,0))+0.98)))*1.5*2.5+0.5))',
            3 => 'LESS(LEVEL,11)*(GREATER(LEVEL,9)*1)',
            
          },

          :production_time => 'LESS(LEVEL,11)*(EQUAL(LEVEL,1)*43200+GREATER(LEVEL,1)*(72800+(FLOOR(1.88*POW(LEVEL-1,1.9)+0.5)*6/100+1)*25000)*0.5)',
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
                :speedup_formula   => "(LESS(LEVEL,11)*FLOOR(1.25*POW(LEVEL,1.3)+0.5)/100.0)*4",
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
  
            :en_US => "The fortress dcontrols the region with all population. The fortress can collect taxes.",
                
          },

	        :conquerable => true,
	        :destroyable => false,


          :change_name_cost => {
            :free_changes => 1,
            :resource_id  => 3,
            :amount       => 10,
          },

          :building_slots => {
            0 => {
              :max_level => 10,
              
              :building  => 27,
              
              :level  => 1,
              
              :takeover_level_factor  => 1,
              :options   => [
              0,
              
              ],
            },
            1 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              1,
              
              ],
            },
            2 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              1,
              
              ],
            },
            3 => {
              :max_level => 10,
              
              :level  => 0,
              
              :takeover_level_factor  => 1,
              :options   => [
              2,
              
              ],
            },
            
          },



        },              #   END OF Festung
        {               #   Heimatsiedlung
          :id          => 2, 
          :symbolic_id => :settlement_home_base,
          :name        => {
            
            :de_DE => "Heimatsiedlung",
  
            :en_US => "Home Settlement",
                
          },
          :description => {
            
            :de_DE => "Die Hauptsiedlung eines Stammes.",
  
            :en_US => "Main settlement of a tribe.",
                
          },

	        :conquerable => false,
	        :destroyable => false,


          :change_name_cost => {
            :free_changes => 1,
            :resource_id  => 3,
            :amount       => 1,
          },

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
              
              :building  => 0,
              
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



        },              #   END OF Heimatsiedlung
        {               #   Lagerstätte
          :id          => 3, 
          :symbolic_id => :settlement_outpost,
          :name        => {
            
            :de_DE => "Lagerstätte",
  
            :en_US => "Camp",
                
          },
          :description => {
            
            :de_DE => "Lagerstätte eines Stammes.",
  
            :en_US => "A small encampment of a tribe.",
                
          },

	        :conquerable => true,
	        :destroyable => true,


          :change_name_cost => {
            :free_changes => 1,
            :resource_id  => 3,
            :amount       => 1,
          },

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
              
              :building  => 24,
              
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
              
              :takeover_level_factor  => 1,
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

# ## ASSIGNMENT TYPES ##########################################################

      :assignment_types => [  # ALL ASSIGMENT TYPES

        {              #   Boulder Smashing
          :id          => 0,
          :symbolic_id => :assignment_stone,
          :level       => 1,
          :advisor     => "girl",
          :name        => {
            
            :en_US => "Boulder Smashing",
  
            :de_DE => "Steine klopfen!",
  
          },
          :flavour     => {
            
            :de_DE => "Mit ein bisschen Motivation können diese Sammler ja ganz schön ackern.",
  
            :en_US => "Just a little bit of motivation and look at those gatherers go!",
  
          },
          :description => {
            
            :de_DE => "<p>Vielleicht verlierst Du die Wette, wie schnell Deine Sammler Steine kloppen können, aber am Ende bleibt für Dich sowieso mehr übrig, als ihr Bier kosten wird.</p>",
  
            :en_US => "<p>Maybe you will lose your bet about how fast your gatherers can smash those boulders, but in the end you'll get more out of their fast work than their beer will cost you anyways.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Mach Deinen Sammlern Beine und lass sie ein paar Steine klopfen!</p>",
  
            :en_US => "<p>Have your gatherers pick up the slack and smash a couple of boulders!</p>",
  
          },

          :duration => 600,


          :rewards => {
            
          :resource_rewards => [
            
              {
                :resource => :resource_stone,
                :amount => 50,
              },

          ],

          },


        },              #   END OF Boulder Smashing
        {              #   Wood Cutting!
          :id          => 1,
          :symbolic_id => :assignment_wood,
          :level       => 2,
          :advisor     => "girl",
          :name        => {
            
            :en_US => "Wood Cutting!",
  
            :de_DE => "Bäume fällen!",
  
          },
          :flavour     => {
            
            :de_DE => "Der Kampf einer Axt gegen einen Baum. Ich kann stundenlang zuschauen wie andere arbeiten.",
  
            :en_US => "Axe against tree, the age old battle. I could spend hours watching others work.",
  
          },
          :description => {
            
            :de_DE => "<p>Der Wirt braucht eine neue Bank, also muss Hand angelegt werden. Da er nur einen halben Baum braucht, wird sich niemand daran stören, wenn Du den Rest einstreichst.</p>",
  
            :en_US => "<p>The barkeeper needs a new bench. Although seeing as how he only needs half a tree, no one is really going to mind if you take the rest for yourself, right?</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Hilf aus und sacke etwas Holz nebenbei ein!</p>",
  
            :en_US => "<p>Help out and get some wood in the process.</p>",
  
          },

          :duration => 720,


          :rewards => {
            
          :resource_rewards => [
            
              {
                :resource => :resource_wood,
                :amount => 50,
              },

          ],

          },


        },              #   END OF Wood Cutting!
        {              #   Skinning
          :id          => 2,
          :symbolic_id => :assignment_fur,
          :level       => 3,
          :advisor     => "girl",
          :name        => {
            
            :en_US => "Skinning",
  
            :de_DE => "Tiere häuten",
  
          },
          :flavour     => {
            
            :de_DE => "Wenn ich nur dran denke, was für schöne Sachen wir aus den Fellen machen können. ",
  
            :en_US => "Just think about all the nice things we can do with that fur.",
  
          },
          :description => {
            
            :de_DE => "<p>Du wolltest wirklich nur entspannen, und wurdest doch wieder für einen kleinen Auftrag rekrutiert. Der Gestank des Tierkadavers steigert nicht gerade Deine Stimmung.</p>",
  
            :en_US => "<p>All you wanted to do was relax with a drink, but then they had to go and make you work. At least they're paying for your drinks. Because to be frank, you're going to need a hell of a lot of drinks to forget about this skinning business.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Manchmal muss man den Dino bei der Haut packen.</p>",
  
            :en_US => "<p>Sometimes you gota grab the dino by the skin.</p>",
  
          },

          :duration => 480,


          :rewards => {
            
          :resource_rewards => [
            
              {
                :resource => :resource_fur,
                :amount => 50,
              },

          ],

          },


        },              #   END OF Skinning
        {              #   Bar Room Brawl
          :id          => 3,
          :symbolic_id => :assignment_barroombrawl,
          :level       => 4,
          :advisor     => "warrior",
          :name        => {
            
            :en_US => "Bar Room Brawl",
  
            :de_DE => "Schlägerei",
  
          },
          :flavour     => {
            
            :de_DE => "Ein kühles Bier und eine zünftige Tavernenschlägerei. Das nenne ich Erholung!",
  
            :en_US => "A chilled beer and flying fists! Now that's what I call relaxation!",
  
          },
          :description => {
            
            :de_DE => "<p>Wenn verdiente Krieger zu Gast sind steigt die Schlägerei Rate enorm. Jungspunde wollen sich profilieren, denn so manch große Krieger Karriere begann in der Taverne. Aber irgendjemand muss die Rechnung bezahlen.</p>",
  
            :en_US => "<p>If a bunch of accomplished warriors meet at the tavern, chances are that there's going to be quite a brawl. But once it's all over, and someone has paid for the smashed up furniture, you may just find yourself with some reliable companions.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Nach einer ordentlichen Schlägerei kann man gute Freunde finden.</p>",
  
            :en_US => "<p>After a nice brawl, you sometimes make some great friends.</p>",
  
          },

          :costs      => {
            0 => '50',
            1 => '50',
            2 => '50',
            
          },

          :duration => 2700,


          :rewards => {
            
          :unit_rewards => [
            
              {
                :unit => :unit_warrior,
                :amount => 3,
              },

          ],

          },


        },              #   END OF Bar Room Brawl
        {              #   Drive out the Neanderthals
          :id          => 4,
          :symbolic_id => :assignment_raid,
          :level       => 5,
          :advisor     => "warrior",
          :name        => {
            
            :en_US => "Drive out the Neanderthals",
  
            :de_DE => "Neandertaler vertreiben",
  
          },
          :flavour     => {
            
            :de_DE => "Diese Neandertaler machen mich wütend. Wütend und durstig!",
  
            :en_US => "Those neanderthals make me angry. And thirsty!",
  
          },
          :description => {
            
            :de_DE => "<p>Die wilden Neandertaler dringen immer wieder in die Gebiete Deines Stammes vor. Um ihnen nun endlich Einhalt zu gebieten wurde ein cleverer Plan gefasst. Man lockt ein paar Krieger in die Taverne. Nach ein paar runden fängt man an Fackeln und Mistgabeln zu verteilen. Schon löst sich das Problem wie von selbst. Und was man so plündert, kann man auch noch behalten.</p>",
  
            :en_US => "<p>Wild neanderthals are advancing more into our land every day. To stop this a clever plan is needed. You gather a bunch of thirsty warriors in the tavern. After a few rounds you start distributing torches and pitchforks. And finally the problem almost solves itself and you can even keep any loot they find.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Vertreibe die Neandertaler und mach ein wenig Beute.</p>",
  
            :en_US => "<p>Drive out the neanderthals and loot a little.</p>",
  
          },

          :unit_deposits => {
            1 => '25',
            
          },

          :duration => 7200,


          :rewards => {
            
          :resource_rewards => [
            
              {
                :resource => :resource_stone,
                :amount => 500,
              },

              {
                :resource => :resource_wood,
                :amount => 500,
              },

              {
                :resource => :resource_fur,
                :amount => 500,
              },

          ],

          },


        },              #   END OF Drive out the Neanderthals
        {              #   The Great Hunt
          :id          => 5,
          :symbolic_id => :assignment_hunt,
          :level       => 7,
          :advisor     => "girl",
          :name        => {
            
            :en_US => "The Great Hunt",
  
            :de_DE => "Die große Jagd",
  
          },
          :flavour     => {
            
            :de_DE => "So eine Jagd ist genau das Richtige um den Apetit anzuregen und Durst zu machen.",
  
            :en_US => "A hunt like this is just the thing to make you thirsty.",
  
          },
          :description => {
            
            :de_DE => "<p>Es wird eine neue Trophäe gesucht, die man über die Bar hängen kann, und so wird zur großen Jagd aufgerufen. Da man fair sein will und nicht von fortgeschrittener Keulentechnologie gebrauch machen will, werden eine Menge Krieger zusammen getrommelt. Und wenn das Werk vollbracht ist und die Trophäe hängt gibts Freibier für alle!</p>",
  
            :en_US => "<p>The barkeeper is looking for a new trophy to hang above his bar, so he's sent out a call to start a great hunt. The hunters cather, but in order to give the wildlife a fair fight, all of their advanced technology is confiscated. Although seeing as how there's the promise of free drinks after the hunt is completed, it shouldn't take that long.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Die große Jagd ist eine einzigartige Erfahrung</p>",
  
            :en_US => "<p>A great hunt is quite an experience.</p>",
  
          },

          :costs      => {
            0 => '600',
            1 => '400',
            
          },

          :unit_deposits => {
            0 => '100',
            
          },

          :duration => 21600,


          :rewards => {
            
          :resource_rewards => [
            
              {
                :resource => :resource_fur,
                :amount => 3000,
              },

          ],

            :experience_reward => 250,

          },


        },              #   END OF The Great Hunt
        {              #   Caravan
          :id          => 6,
          :symbolic_id => :assignment_caravan,
          :level       => 9,
          :advisor     => "chief",
          :name        => {
            
            :en_US => "Caravan",
  
            :de_DE => "Karavane",
  
          },
          :flavour     => {
            
            :de_DE => "Was man in fremden Ländern wohl alles hat um sich zu bereichern?",
  
            :en_US => "I wonder what they do in foreign countries to enrich themselves?",
  
          },
          :description => {
            
            :de_DE => "<p>Ein fliegender Händler sucht nach Investoren für seine nächste Handelsreise. Für ein paar Rohstoffe und eine Leibwache beteiligt er Dich an seinem Gewinn. Und viel wichtiger: er übernimmt die Getränkerechnung für heute!</p>",
  
            :en_US => "<p>A traveling merchant is looking for investors for his next journey. For a few resources and some people to guard them he will give you part of his earning. And much more importantly he will pick up your tab at the bar!</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Beschütze die Karavane und kehre reich zurück.</p>",
  
            :en_US => "<p>Protect the caravan and become rich in the process.</p>",
  
          },

          :costs      => {
            0 => '1000',
            1 => '1000',
            2 => '1000',
            
          },

          :unit_deposits => {
            1 => '100',
            2 => '50',
            
          },

          :duration => 86400,


          :rewards => {
            
          :resource_rewards => [
            
              {
                :resource => :resource_stone,
                :amount => 6000,
              },

              {
                :resource => :resource_wood,
                :amount => 6000,
              },

              {
                :resource => :resource_fur,
                :amount => 6000,
              },

          ],

          },


        },              #   END OF Caravan
        {              #   Expedition
          :id          => 7,
          :symbolic_id => :assignment_expedition,
          :level       => 10,
          :advisor     => "chief",
          :name        => {
            
            :en_US => "Expedition",
  
            :de_DE => "Expedition",
  
          },
          :flavour     => {
            
            :de_DE => "Diese Expedition wird uns Ruhm und Ehre bringen!",
  
            :en_US => "We will loot a bunch of resources for sure!",
  
          },
          :description => {
            
            :de_DE => "<p>Die Welt ist ein Quadrat! Behaupten tut das zumindest einer der Betrunkenen an der Bar. Als ihn dann jemand dezent darauf hinweis, dass doch jedes Kind weiß, dass die Welt ein Ei ist haut er kurzerhand eins auf die Theke um zu zeigen, dass das eigentlich auch innen Flach ist. Jetzt will er es aber beweisen und sucht Nach freiwilligen, die sich seiner Expedition anschließen sollen, um die Ecken der Welt zu erforschen und ihre Reichtümer zu erbeuten. Und Reichtümer kann man doch immer gebrauchen.</p>",
  
            :en_US => "<p>The world is square! At least, that's what one of the bar's late night patrons keeps telling whoever is in his immediate vicinity. After someone tells him that every child knows that the world is an egg, he suddenly gets rather agitated and yells that he needs to find more people to join him on his expedition to find the corners of the world and loot their riches. And it must be said, you've never been one to  say no to riches.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Unternimm eine Expedition</p>",
  
            :en_US => "<p>Undertake an expedition</p>",
  
          },

          :costs      => {
            0 => '3000',
            1 => '3000',
            2 => '3000',
            
          },

          :unit_deposits => {
            2 => '250',
            5 => '200',
            9 => '100',
            
          },

          :duration => 604800,


          :rewards => {
            
          :resource_rewards => [
            
              {
                :resource => :resource_stone,
                :amount => 36000,
              },

              {
                :resource => :resource_wood,
                :amount => 36000,
              },

              {
                :resource => :resource_fur,
                :amount => 36000,
              },

          ],

          },


        },              #   END OF Expedition
      ],                # END OF ASSIGNMENT TYPES

# ## SPECIAL ASSIGNMENT TYPES ##########################################################

      :special_assignment_types => [  # ALL SPECIAL ASSIGMENT TYPES

        {              #   Gathererprotection
          :id          => 0,
          :symbolic_id => :special_assignment_protection1,
          :level       => 3,
          :advisor     => "girl",
          :probability_factor => 4,
          :name        => {
            
            :en_US => "Gathererprotection",
  
            :de_DE => "Sammlerschutz",
  
          },
          :flavour     => {
            
            :de_DE => "Schlaue Mädchen.",
  
            :en_US => "Clever girls.",
  
          },
          :description => {
            
            :de_DE => "<p>Deine Sammler werden in letzter Zeit von einem Rudel wilder Velociraptoren heimgesucht. Jetzt verlangen Deine Sammler Schutz, andernfalls können sie nicht garantieren weiterhin effektiv arbeiten zu können.</p>",
  
            :en_US => "<p>Your gatherers are beeing stalked by a group of fierce velociraptors. They demand your protection, otherwise they wont be able to work at full capacity.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Schütze deine Sammler</p>",
  
            :en_US => "<p>Protect your gatherers</p>",
  
          },

          :assignment_tests => {
            
            :building_tests => [
              
  {
  :building => 'building_gatherer',
  
    :min_level => 4,
  
    :min_count => 5,
  
  },

            ],

          },

          :unit_deposits => {
            1 => '0.005*PRODUCTION',
            
          },

          :duration => 14400,
          :display_duration => 18000,


          :rewards => {

            :resource_rewards => [
              
              {
                :resource => :resource_stone,
                :amount => '0.25*PRODUCTION',
              },

              {
                :resource => :resource_wood,
                :amount => '0.25*PRODUCTION',
              },

              {
                :resource => :resource_fur,
                :amount => '0.25*PRODUCTION',
              },

            ],

            :experience_reward => '50',

          },


        },              #   END OF Gathererprotection
        {              #   The Big Game
          :id          => 1,
          :symbolic_id => :special_assignment_bigGame,
          :level       => 4,
          :advisor     => "warrior",
          :probability_factor => 3,
          :name        => {
            
            :en_US => "The Big Game",
  
            :de_DE => "Das große Spiel",
  
          },
          :flavour     => {
            
            :de_DE => "Ich persönlich bevorzuge ja klassisches Ballet.",
  
            :en_US => "Personally I prefer classic ballet.",
  
          },
          :description => {
            
            :de_DE => "<p>Das Große Spiel steht bevor! Die Fans Deiner Mannschaft sammeln sich schon in der Taverne und trinken sich auf Deine Kosten Mut an, um den gegnerischen Fans eine ordentliche Abreibung zu verpassen. Sollten sie auch, immerhin hast Du eine ordentliche Summe gewettet.</p>",
  
            :en_US => "<p>Tonight's the big game! The fans are already gathered, getting some liquid courage before showing the oppositions supporters who's boss. They can't loose with this much drunken power behind them. Atleast they better dont, afterall you bet quite the sum on this game.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Das Große Spiel steht bevor.</p>",
  
            :en_US => "<p>The big game is tonight.</p>",
  
          },

          :costs      => {
            0 => '0.5*PRODUCTION',
            1 => '0.5*PRODUCTION',
            2 => '0.5*PRODUCTION',
            
          },

          :assignment_tests => {
            
            :building_tests => [
              
  {
  :building => 'building_barracks',
  
    :min_level => 5,
  
    :min_count => 1,
  
  },

            ],

          },

          :unit_deposits => {
            1 => '100',
            
          },

          :duration => 25200,
          :display_duration => 14400,


          :rewards => {

            :resource_rewards => [
              
              {
                :resource => :resource_stone,
                :amount => '1*PRODUCTION',
              },

              {
                :resource => :resource_wood,
                :amount => '1*PRODUCTION',
              },

              {
                :resource => :resource_fur,
                :amount => '1*PRODUCTION',
              },

            ],

          },


        },              #   END OF The Big Game
        {              #   Escortmission
          :id          => 2,
          :symbolic_id => :special_assignment_hobbits,
          :level       => 9,
          :advisor     => "chief",
          :probability_factor => 4,
          :name        => {
            
            :en_US => "Escortmission",
  
            :de_DE => "Die Eskorte",
  
          },
          :flavour     => {
            
            :de_DE => "Lustige kleine Kerle diese Jungs.",
  
            :en_US => "Funny little guys, kinda hairy around the feet tho.",
  
          },
          :description => {
            
            :de_DE => "<p>Während Du in der Taverne sitzt bemerkst Du vier kleine Häuptlinge. Sie singen und tanzen und sind das Zentrum der Gesellschaft. Bei soviel Trubel bist Du sogar der Meinung, dass sich einer von ihnen kurz in Luft auflöst. Du schiebst es auf Deinen Konsum von Gerstensaft und bist sehr verwundert, als Dich die vier kleinen Häuptlinge als Führer durch die Wildnis anwerben wollen.</p>",
  
            :en_US => "<p>While you sit in the tavern and have a sip of ale you spot four little chiefs entering. They seem to be quite cheery fellows as they are soon the center of the crowd, leading them in song.You could swear one of them even disapears into thin air, but to be honest you have been drinking heavily. Later that evening you are aproached by them. They ask you to lead them to their next Destination.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Hilf den kleinen Häuptlingen bei ihrer Reise.</p>",
  
            :en_US => "<p>Help the little chiefs on their journey.</p>",
  
          },

          :assignment_tests => {
            
            :training_queue_tests => [
              
            {
              :unit => 'unit_little_chief',
              :min_count => 1,
            },

            ],

          },

          :duration => 10800,
          :display_duration => 3600,


          :rewards => {

            :resource_rewards => [
              
              {
                :resource => :resource_stone,
                :amount => '0.3*PRODUCTION',
              },

              {
                :resource => :resource_wood,
                :amount => '0.3*PRODUCTION',
              },

              {
                :resource => :resource_fur,
                :amount => '0.3*PRODUCTION',
              },

            ],

            :experience_reward => '0.05*PRODUCTION',

          },


        },              #   END OF Escortmission
        {              #   Migration
          :id          => 3,
          :symbolic_id => :special_assignment_migration,
          :level       => 5,
          :advisor     => "warrior",
          :probability_factor => 1,
          :name        => {
            
            :en_US => "Migration",
  
            :de_DE => "Völkerwanderung",
  
          },
          :flavour     => {
            
            :de_DE => "Diese wilde Krieger sollten wir besser auf unserer Seite wissen.",
  
            :en_US => "Those people are fierce warriors. Just right for the meatgrinder.",
  
          },
          :description => {
            
            :de_DE => "<p>Von den Mauern Deiner Festung erblicken Deine Späher eine Gruppe von wilden Menschen. Es scheint sich allerdings nicht um einen Schlachtzug, sondern einer Gruppe von Auswanderern zu handeln. Vielleicht kannst Du sie mit ein paar Rohstoffen überzeugen bei Dir zu bleiben und zukünftig für Dich zu kämpfen.</p>",
  
            :en_US => "<p>The lookouts in your fortress spot a huge group of people marching through your lands. But rather than an army they apear to be a band of wanderers, looking for greener pastures. Maybe you can support them with a few ressources. You may convince a few of them to stay here that way.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Hilf den Wanderern eine neue Heimat zu finden.</p>",
  
            :en_US => "<p>Help the migrating people to find a new home.</p>",
  
          },

          :costs      => {
            0 => '0.5*PRODUCTION',
            1 => '0.4*PRODUCTION',
            2 => '0.625*PRODUCTION',
            
          },

          :assignment_tests => {
            
            :settlement_tests => [
              
  {
  :type => 'settlement_fortress',
  :min_count => 1,
  },

            ],

          },

          :duration => 9000,
          :display_duration => 18000,


          :rewards => {

            :unit_rewards => [
              
              {
                :unit => :unit_clubbers,
                :amount => '0.01*PRODUCTION',
              },

              {
                :unit => :unit_throwers,
                :amount => '0.0075*PRODUCTION',
              },

            ],

            :experience_reward => '0.001*PRODUCTION',

          },


        },              #   END OF Migration
        {              #   The dark forest
          :id          => 4,
          :symbolic_id => :special_assignment_quest1,
          :level       => 1,
          :advisor     => "girl",
          :probability_factor => 1,
          :name        => {
            
            :en_US => "The dark forest",
  
            :de_DE => "Der dunkle Wald",
  
          },
          :flavour     => {
            
            :de_DE => "Das klingt doch mal nach einer Aufgabe für einen heroischen Halbgott.",
  
            :en_US => "That sounds like a job for a dapper demigod.",
  
          },
          :description => {
            
            :de_DE => "<p>Lange schon ranken sich Legenden darum, was sich im Zentrum des dunklen Waldes befinden könnte. Nur selten wagen sich die Jäger und Sammler bis in die nähe seines Zentrums und seltener noch kehren sie zurück. Sogar ein paar Holzfäller sollen dort schon verschollen sein. Schon länger hörst Du das munkeln in der Taverne. Vielleicht beschließt Du ja dem ganzen nach zu gehen.</p>",
  
            :en_US => "<p>For the longest  time there have been legends about the center of the dark forest. Not often do the hunters and gatherers dare come close to it and hardly any of them return. You have heared the stories about that place a hundred times. Maybe its time to check it ouut for yourself.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Begib dich auf Reise und erkunde die Geheimnisse des finsteren Waldes.</p>",
  
            :en_US => "<p>Enter the dark forest and learn its mysteries.</p>",
  
          },

          :duration => 12600,
          :display_duration => 3600,


          :rewards => {

            :resource_rewards => [
              
              {
                :resource => :resource_stone,
                :amount => '0.3*PRODUCTION',
              },

              {
                :resource => :resource_wood,
                :amount => '0.3*PRODUCTION',
              },

              {
                :resource => :resource_fur,
                :amount => '0.3*PRODUCTION',
              },

            ],

            :experience_reward => '0.003*PRODUCTION',

          },


        },              #   END OF The dark forest
      ],                # END OF SPECIAL ASSIGNMENT TYPES

# ## TREASURE TYPES ##########################################################

      :treasure_types => [  # ALL TREASURE TYPES

        {              #   Pile of Wood
          :id          => 0,
          :symbolic_id => :treasure_wood,
          :difficulty  => "LEVEL*10",
          :advisor     => "girl",
          :probability_factor => 10,
          :name        => {
            
            :en_US => "Pile of Wood",
  
            :de_DE => "Holzhaufen",
  
          },
          :flavour     => {
            
            :de_DE => "Wer hat denn das liegen lassen?",
  
            :en_US => "Who has lost this?",
  
          },
          :description => {
            
            :de_DE => "<p>Eine unbestimmte Menge an Holz, die ein freundlicher Mitmensch unbeaufsichtigt für Dich oder einen anderen Finder hinterlegt hat. Die genaue Menge hängt vom Level dieses Schatzes ab.</p>",
  
            :en_US => "<p>An undetermined amount of wood, another friendly human has prepared and left for your to take. The exact amount the finder will gain depends on the level of this treasure.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Eine unbestimmte Menge an Holz, die ein freundlicher Mitmensch unbeaufsichtigt für Dich oder einen anderen Finder hinterlegt hat.</p>",
  
            :en_US => "<p>An undetermined amount of wood, another friendly human has prepared and left for your to take.</p>",
  
          },

          :rewards => {

            :randomized_resource_rewards => [
              
              { 
                :resource_id => 1,
                :resource => :resource_wood,
                :amount => "LEVEL*10",
                :norm_variance => 0.25,
              },

            ],

          },


        },              #   END OF Pile of Wood
        {              #   Golden Toads
          :id          => 1,
          :symbolic_id => :treasure_cash,
          :difficulty  => "LEVEL*10",
          :advisor     => "chef",
          :probability_factor => 1,
          :name        => {
            
            :en_US => "Golden Toads",
  
            :de_DE => "Goldkröten",
  
          },
          :flavour     => {
            
            :de_DE => "Was glitzert da am Boden?",
  
            :en_US => "What see my eyes glimmering over there?",
  
          },
          :description => {
            
            :de_DE => "<p>Lange Beschreibung.</p>",
  
            :en_US => "<p>Long Description.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Da war wohl jemand unachtsam und hat ein paar wertvolle Goldkröten liegen lassen.</p>",
  
            :en_US => "<p>Some golden frogs can be found at this site.</p>",
  
          },

          :rewards => {

            :randomized_resource_rewards => [
              
              { 
                :resource_id => 3,
                :resource => :resource_cash,
                :amount => "LEVEL",
                :norm_variance => 0,
              },

            ],

          },


        },              #   END OF Golden Toads
        {              #   Unkartographierte Erdhöhle
          :id          => 2,
          :symbolic_id => :treasure_xp,
          :difficulty  => "LEVEL*10",
          :advisor     => "warrior",
          :probability_factor => 10,
          :name        => {
            
            :en_US => "Unkartographierte Erdhöhle",
  
            :de_DE => "Unexplored Cavern",
  
          },
          :flavour     => {
            
            :de_DE => "Lass uns trainieren gehen und das Ungeziefer aus der Höhle vertreiben.",
  
            :en_US => "Your chance to test your skills and gain some experience.",
  
          },
          :description => {
            
            :de_DE => "<p>Lange Beschreibung.</p>",
  
            :en_US => "<p>Long Description.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Eine unentdeckte Höhle verspricht einen Haufen Erfahrung für denjenigen, der sie zuerst begeht.</p>",
  
            :en_US => "<p>An undiscovered cavern hides small and large dangers that'll bolster the experience of the first explorer.</p>",
  
          },

          :rewards => {

            :randomized_experience_reward => 
              
              { 
                :amount => "LEVEL*LEVEL*LEVEL*10+40",
                :norm_variance => 0.25,
              },

          },


        },              #   END OF Unkartographierte Erdhöhle
        {              #   Pile of Stone
          :id          => 3,
          :symbolic_id => :treasure_stone,
          :difficulty  => "LEVEL*10",
          :advisor     => "girl",
          :probability_factor => 10,
          :name        => {
            
            :en_US => "Pile of Stone",
  
            :de_DE => "Geröll",
  
          },
          :flavour     => {
            
            :de_DE => "Wer hat denn das liegen lassen?",
  
            :en_US => "Who has lost this?",
  
          },
          :description => {
            
            :de_DE => "<p>Eine unbestimmte Menge an Stein, die ein freundlicher Mitmensch unbeaufsichtigt für Dich oder einen anderen Finder hinterlegt hat. Die genaue Menge hängt vom Level dieses Schatzes ab.</p>",
  
            :en_US => "<p>An undetermined amount of stone, another friendly human has prepared and left for your to take. The exact amount the finder will gain depends on the level of this treasure.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Eine unbestimmte Menge an Stein, die ein freundlicher Mitmensch unbeaufsichtigt für Dich oder einen anderen Finder hinterlegt hat.</p>",
  
            :en_US => "<p>An undetermined amount of stone, another friendly human has prepared and left for your to take.</p>",
  
          },

          :rewards => {

            :randomized_resource_rewards => [
              
              { 
                :resource_id => 0,
                :resource => :resource_stone,
                :amount => "LEVEL*10",
                :norm_variance => 0.25,
              },

            ],

          },


        },              #   END OF Pile of Stone
        {              #   Pile of Fur
          :id          => 4,
          :symbolic_id => :treasure_fur,
          :difficulty  => "LEVEL*10",
          :advisor     => "girl",
          :probability_factor => 10,
          :name        => {
            
            :en_US => "Pile of Fur",
  
            :de_DE => "Felllager",
  
          },
          :flavour     => {
            
            :de_DE => "Wer hat denn das liegen lassen?",
  
            :en_US => "Who has lost this?",
  
          },
          :description => {
            
            :de_DE => "<p>Eine unbestimmte Menge an Fellen, die ein freundlicher Mitmensch unbeaufsichtigt für Dich oder einen anderen Finder hinterlegt hat. Die genaue Menge hängt vom Level dieses Schatzes ab.</p>",
  
            :en_US => "<p>An undetermined amount of fur, another friendly human has prepared and left for your to take. The exact amount the finder will gain depends on the level of this treasure.</p>",
  
          },

          :short_description => {
            
            :de_DE => "<p>Eine unbestimmte Menge an Fellen, die ein freundlicher Mitmensch unbeaufsichtigt für Dich oder einen anderen Finder hinterlegt hat.</p>",
  
            :en_US => "<p>An undetermined amount of fur, another friendly human has prepared and left for your to take.</p>",
  
          },

          :rewards => {

            :randomized_resource_rewards => [
              
              { 
                :resource_id => 2,
                :resource => :resource_fur,
                :amount => "LEVEL*10",
                :norm_variance => 0.25,
              },

            ],

          },


        },              #   END OF Pile of Fur
      ],                # END OF TREASURE TYPES

# ## ARTIFACT TYPES ########################################################
  
      :artifact_types => [  # ALL ARTIFACT TYPES

        {               #   Abrissbirne
          :id          => 0, 
          :symbolic_id => :artifact_0,
          :name        => {
            
            :de_DE => "Abrissbirne",
  
            :en_US => "Demolition Ball",
                
          },
          :description => {
            
            :de_DE => "<p>Mammut-Knut war sehr überrascht als er den Neandertalern eine große schwarze Kugel mit komischer Bemalung und lockeren Schnur entreißen konnte. Nach einer kurzen Untersuchung mit seiner Fackel bei der die Schnur kurzzeitig Feuer fing wurde Knut seinem Ruf als kluger Kopf gerecht: 'Auf zur Tüftler-Werkstatt!'</p>",
  
            :en_US => "<p>A smooth black boulder with a piece of string growing out of it. Noone knows what its supposed to be good for. Maybe the Tinkers can make sense of it</p>",
  
          },
          :flavour => {
            
            :de_DE => "Haben die Götter diese Kugel verloren? Ich liebe Rätsel!",
  
            :en_US => "Harder than stone and what are those strange red signs painted on it? It's a mystery.",
  
          },

          :amount      => '5',

          :production_bonus  => [

            {
              :resource_id        => 0,
              :domain_id          => 0,
              :bonus              => 0.15,
            },

            {
              :resource_id        => 0,
              :domain_id          => 2,
              :bonus              => 0.05,
            },

          ],

          :description_initiated => {

            :de_DE => "<p>Die Tüftler der Werksatt haben das Artefakt entschlüsselt und eine großartige Apparatur gebaut. Mit der sogenannten Abrissbirne kann Stein deutlich schneller abgebrochen werden, davon profitiert sogar die gesamte Allianz.</p>",
  
            :en_US => "<p>The Tinkers figured it out! With this new construction we can smash rocks more easily thank before, surely this technology will spread to our allies as well.</p>",
  
          },
          :initiation_costs => {
            0 => '1000*LEVEL',
            1 => '1000*LEVEL',
            2 => '1000*LEVEL',
            
          },
          :initiation_time => "FLOOR(168*3600-2*1.7779*3600*(POW((LEVEL-1),1.5)))",

        },              #   END OF Abrissbirne
        {               #   Lochscheibe
          :id          => 1, 
          :symbolic_id => :artifact_1,
          :name        => {
            
            :de_DE => "Lochscheibe",
  
            :en_US => "Punched Disc",
                
          },
          :description => {
            
            :de_DE => "<p>Der hellste Augenblick im Leben von Hansi Haudrauf war der Ausruf 'Auf zur Tüftler-Werkstatt!' als er beim Kampf gegen die Neandertaler auf den unbekannten Lochstein stieß. Da der Lochstein zu schwer war wurde er kuzerhand zur Hauptsiedlung gerollt.</p>",
  
            :en_US => "<p>The punched disc was found in the wake of a great battle with the neandertals. But since noone knew what to do with it they deceided to just give it to the workshop.</p>",
  
          },
          :flavour => {
            
            :de_DE => "Ein Stein mit einem Loch! Das ist doch nun wirklich nichts neues.",
  
            :en_US => "A stone with a hole? Now i've seen everything.'",
  
          },

          :amount      => '15',

          :production_bonus  => [

            {
              :resource_id        => 1,
              :domain_id          => 0,
              :bonus              => 0.15,
            },

            {
              :resource_id        => 1,
              :domain_id          => 2,
              :bonus              => 0.05,
            },

          ],

          :description_initiated => {

            :de_DE => "<p>Die Tüftler der Werkstatt haben eine geniale Idee zur Verwertung des Lochsteins gehabt. Das dreickige Rad revolutiniert den Transport von Holz durch neuartige Holzkarren. Sowohl die eigen als auch die Allianz-Holzproduktion profitiert von dieser Entdeckung.</p>",
  
            :en_US => "<p>After a while the Tinkers finally found a use for the damn thing. They figured, that they could use it to transport wood with astonishing speed and shared this knowledge with their allies as well. Unfortunately the discs round form wasnt aesthetically pleasing to the Tinkers, but they managed to fix that too.</p>",
  
          },
          :initiation_costs => {
            0 => '1000*LEVEL',
            1 => '1000*LEVEL',
            2 => '1000*LEVEL',
            
          },
          :initiation_time => "FLOOR(168*3600-2*1.7779*3600*(POW((LEVEL-1),1.5)))",

        },              #   END OF Lochscheibe
        {               #   Wäscheleine
          :id          => 2, 
          :symbolic_id => :artifact_2,
          :name        => {
            
            :de_DE => "Wäscheleine",
  
            :en_US => "Clothing Horse",
                
          },
          :description => {
            
            :de_DE => "<p>Im blutigen Kampf gegen die Neandertaler entdeckte Don Donnerschlag den großen Stil in einem Baumstumpf. Da ihm das Material der Verankerung im Baumstumpf nicht geheuer war, folgte schnell der Ausruf 'Auf zur Tüftler-Werkstatt!'.</p>",
  
            :en_US => "<p>When the clothing horse was first discovered the strange material of its stand frightened a lot of people. The only ones brave enough to take a good look at it were the Tinkers in the workshop.</p>",
  
          },
          :flavour => {
            
            :de_DE => "Hmm, was ist das? Eine Waffe oder ein Werkzeug kann das nicht sein, oder?",
  
            :en_US => "Well this surely couldnt be some sort of tool or weapon.",
  
          },

          :amount      => '2',

          :production_bonus  => [

            {
              :resource_id        => 2,
              :domain_id          => 0,
              :bonus              => 0.15,
            },

            {
              :resource_id        => 2,
              :domain_id          => 2,
              :bonus              => 0.05,
            },

          ],

          :description_initiated => {

            :de_DE => "<p>Auf eine Wäscheleine hätten sie auch ohne das unbekannte Artefakt kommen sollen, sagten sich die Tütfler. Die Wäscheleine beschleunigt neben der eigenen auch die Fellproduktion der Allianz.</p>",
  
            :en_US => "<p>To be honest, they should have come up with this a lot earlier. But nevertheless, thanks to this new clothing horse furriers everywere began to work more efficiently.</p>",
  
          },
          :initiation_costs => {
            0 => '1000*LEVEL',
            1 => '1000*LEVEL',
            2 => '1000*LEVEL',
            
          },
          :initiation_time => "FLOOR(168*3600-2*1.7779*3600*(POW((LEVEL-1),1.5)))",

        },              #   END OF Wäscheleine
        {               #   Schwarzer Monolith
          :id          => 3, 
          :symbolic_id => :artifact_3,
          :name        => {
            
            :de_DE => "Schwarzer Monolith",
  
            :en_US => "Black Monolith",
                
          },
          :description => {
            
            :de_DE => "<p>Der Kampf gegen die Neandertaler war kaum beendet, als Knochen-Kalle die Entdeckung seines Lebens machte. Ein schwarzer Monolith war aber leider nichts, was bei den Frauen besonders gut ankommt.</p>",
  
            :en_US => "<p>Towering and threatning the monolith is a fearfull thing to behold. Unfortunately it didnt impress the ladies as much as the warriors had hoped, so they just tossed it to the Tinkers to worry about it.</p>",
  
          },
          :flavour => {
            
            :de_DE => "Der schwarze Monolith ist toll. Er ist so groß und nunja schwarz eben.",
  
            :en_US => "The monolith is great and black and .... yeah.",
  
          },

          :amount      => '0',

          :experience_production => '15*(MRANK+1)',

          :description_initiated => {

            :de_DE => "<p>Mit dem schwarzen Monolithen kamen die Tütfler aus der Werkstatt nicht wirklich weiter. Die Untersuchungen lehrten sie zwar eine Menge und von der Erfahrung profitierte ihr Stamm und ihre Allianz, aber was zählbares kam dabei nicht raus.</p>",
  
            :en_US => "<p>In all honesty, the Tinkers couldnt make any real use of the monolith. So they just put it there to remind themselves to work harder. Apparently that works and young Tinkers will tell you how they can feel their predecessors experience flowing into them when they look at it.</p>",
  
          },
          :initiation_costs => {
            0 => '1000*LEVEL',
            1 => '1000*LEVEL',
            2 => '1000*LEVEL',
            
          },
          :initiation_time => "FLOOR(168*3600-2*1.7779*3600*(POW((LEVEL-1),1.5)))",

        },              #   END OF Schwarzer Monolith
        {               #   Dino-Ei
          :id          => 4, 
          :symbolic_id => :artifact_4,
          :name        => {
            
            :de_DE => "Dino-Ei",
  
            :en_US => "Dino-Egg",
                
          },
          :description => {
            
            :de_DE => "<p>Interessant was die Neandertaler so horten. Die Tüftlerwerkstatt wird sich über den neuen Fund freuen. Vielleicht ergründen sie sogar die Ursache der bunten Farbe oder gar den Inhalt des Ei. Oder sie denken sich eine absurde Erklärung aus.</p>",
  
            :en_US => "<p>You can find the strangest things if you look around enough. Atleast the Tinkers will be happy with this one. Maybe they can figure out what sort of animal would lay such a strangely colored egg?</p>",
  
          },
          :flavour => {
            
            :de_DE => "Ein großes buntes Ei? Was mag da drin sein?",
  
            :en_US => "A great colourful egg? Good or bad?",
  
          },

          :amount      => '5',

          :experience_production => 'MRANK',

          :description_initiated => {

            :de_DE => "<p>Die Tüftler haben diverse Waffen und schwere Gegenstände eingesetzt, aber das Ei war nicht zu knacken. Auch zur Farbe hatten sie keine Eingebung. So wurde verkündet, dass das Ei schön aussieht. Auch nett.</p>",
  
            :en_US => "<p>After days of trying to break the egg open the Tinkers finally came to a conclusion. It's very pretty.</p>",
  
          },
          :initiation_costs => {
            0 => '250*LEVEL',
            1 => '250*LEVEL',
            2 => '250*LEVEL',
            
          },
          :initiation_time => "FLOOR((168*3600-2*1.7779*3600*(POW((LEVEL-1),1.5)))/2)",

        },              #   END OF Dino-Ei
        {               #   Steinbrösler
          :id          => 5, 
          :symbolic_id => :artifact_5,
          :name        => {
            
            :de_DE => "Steinbrösler",
  
            :en_US => "Stone Crusher",
                
          },
          :description => {
            
            :de_DE => "<p>Das ist ja ... ein Hammer! Du bist Dir sofort sicher, dass es sich bei diesem Artefakt um einen Hammer handelt. Die Tüftler aus der Tüftler Werkstatt sind aber anderer Meinung und kassieren das Artefakt für nähere Untersuchungen ein.</p>",
  
            :en_US => "<p>Is that... a hammer! You are immediately certain that this must be a hammer. The Tinkers dont seem to think so tho and take it back to their workshop for further investigation.</p>",
  
          },
          :flavour => {
            
            :de_DE => "Für eine Keule ist das aber ziemlich mickrig.",
  
            :en_US => "Pretty puny for a club.",
  
          },

          :amount      => '10',

          :construction_bonus  => [

            {
              :domain_id          => 0,
              :bonus              => 0.5,
            },

            {
              :domain_id          => 2,
              :bonus              => 0.15,
            },

          ],

          :description_initiated => {

            :de_DE => "<p>Unglaublich, es ist wirklich eine Art Hammer! Die Tüftler nennen ihn liebevoll 'Steinbrösler'. Mit dem Steinbrösler kann man Steine klein hauen und so schneller Rohmaterial für neue Gebäude gewinnen.</p>",
  
            :en_US => "<p>Incredibly enough it realy apears to be some sort of hammer! The Tinkers are calling it the 'Stone Cruser'. It is realy good at smashing boulders to bits and helps building buildings.</p>",
  
          },
          :initiation_costs => {
            0 => '1000*LEVEL',
            1 => '1000*LEVEL',
            2 => '1000*LEVEL',
            
          },
          :initiation_time => "FLOOR(168*3600-2*1.7779*3600*(POW((LEVEL-1),1.5)))",

        },              #   END OF Steinbrösler
      ],                # END OF ARTIFACT TYPES

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
  
            :en_US => "For a domination victory an alliance has to rule a certain proprtion of all regions, i.e. the fortress of this regions have to be owned by alliance members.",
                
          },

          :condition   => {

            :required_regions_ratio => 'LESS(DAYS,91)*(1-(0.01*((70/90)*DAYS)))+GREATER(DAYS,90)*(0.3-(0.01*((29/60)*(DAYS-90))))',

            :duration => 5,
          },

        },              #   END OF Herrschaftssieg
        {               #   Artefaktsieg
          :id          => 1, 
          :symbolic_id => :victory_artifact,
          :name        => {
            
            :de_DE => "Artefaktsieg",
  
            :en_US => "Artifact Victory",
                
          },
          :description => {
            
            :de_DE => "Für einen Artefaktsieg muss eine Allianz mindestens ein Artefakt von jedem Artefakttyp besitzen und einweihen.",
  
            :en_US => "For a artifact victory an alliance has to own and initiate at least one artifact of every artifact type.",
                
          },

          :condition   => {

            :duration => 5,
          },

        },              #   END OF Artefaktsieg
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
  
            :en_US => "Furry-fleatamer",
  
            },
          },             #   END OF 
          {              #  1
            :id          => 1,
            :exp         => 2000,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Springschwanzsucher",
  
            :en_US => "Springtailsearcher",
  
            },
          },             #   END OF 
          {              #  2
            :id          => 2,
            :exp         => 5000,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Altameisenanbeter",
  
            :en_US => "Ancientantworshipper",
  
            },
          },             #   END OF 
          {              #  3
            :id          => 3,
            :exp         => 9500,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Ammonitenanlocker",
  
            :en_US => "Ammonitesattractor",
  
            },
          },             #   END OF 
          {              #  4
            :id          => 4,
            :exp         => 16250,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Feuerunkensammler",
  
            :en_US => "Firebellytoadcollector",
  
            },
          },             #   END OF 
          {              #  5
            :id          => 5,
            :exp         => 25500,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Steinzeitrattenkuschler",
  
            :en_US => "Junior-Stoneageratcuddler",
  
            },
          },             #   END OF 
          {              #  6
            :id          => 6,
            :exp         => 37500,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Steinzeitrattenkuschler",
  
            :en_US => "Stoneageratcuddler",
  
            },
          },             #   END OF 
          {              #  7
            :id          => 7,
            :exp         => 52750,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Hülsenwirblerverwirbler",
  
            :en_US => "Junior-Shell-whirlerswirler",
  
            },
          },             #   END OF 
          {              #  8
            :id          => 8,
            :exp         => 71500,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Hülsenwirblerverwirbler",
  
            :en_US => "Shell-whirlerswirler",
  
            },
          },             #   END OF 
          {              #  9
            :id          => 9,
            :exp         => 94250,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Erdferkelentdecker",
  
            :en_US => "Junior-Aardvarkdiscoverer",
  
            },
          },             #   END OF 
          {              #  10
            :id          => 10,
            :exp         => 121250,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Erdferkelentdecker",
  
            :en_US => "Aardvarkdiscoverer",
  
            },
          },             #   END OF 
          {              #  11
            :id          => 11,
            :exp         => 153000,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Dodoherdenhüter",
  
            :en_US => "Junior-Dodoherdkeeper",
  
            },
          },             #   END OF 
          {              #  12
            :id          => 12,
            :exp         => 189750,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Dodoherdenhüter",
  
            :en_US => "Dodoherdkeeper",
  
            },
          },             #   END OF 
          {              #  13
            :id          => 13,
            :exp         => 232000,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Säbelzahnkatzenbesänftiger",
  
            :en_US => "Junior-Sabre-toothedcatappeaser",
  
            },
          },             #   END OF 
          {              #  14
            :id          => 14,
            :exp         => 280000,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Säbelzahnkatzenbesänftiger",
  
            :en_US => "Sabre-toothedcatappeaser",
  
            },
          },             #   END OF 
          {              #  15
            :id          => 15,
            :exp         => 334250,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Vielfraßversteher",
  
            :en_US => "Junior-Wolverinewhisperer",
  
            },
          },             #   END OF 
          {              #  16
            :id          => 16,
            :exp         => 395000,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Vielfraßversteher",
  
            :en_US => "Wolverinewhisperer",
  
            },
          },             #   END OF 
          {              #  17
            :id          => 17,
            :exp         => 462500,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Rothundzähmer",
  
            :en_US => "Junior-Dholetamer",
  
            },
          },             #   END OF 
          {              #  18
            :id          => 18,
            :exp         => 537000,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Rothundzähmer",
  
            :en_US => "Dholetamer",
  
            },
          },             #   END OF 
          {              #  19
            :id          => 19,
            :exp         => 618750,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Mähnenwolfschmuser",
  
            :en_US => "Junior-Manedwolfsnuggler",
  
            },
          },             #   END OF 
          {              #  20
            :id          => 20,
            :exp         => 708000,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Mähnenwolfschmuser",
  
            :en_US => "Manedwolfsnuggler",
  
            },
          },             #   END OF 
          {              #  21
            :id          => 21,
            :exp         => 804750,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Urschweinkrauler",
  
            :en_US => "Junior-Primevalpigfondler",
  
            },
          },             #   END OF 
          {              #  22
            :id          => 22,
            :exp         => 909250,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Urschweinkrauler",
  
            :en_US => "Primevalpigfondler",
  
            },
          },             #   END OF 
          {              #  23
            :id          => 23,
            :exp         => 1021500,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Auerochsenstreichler",
  
            :en_US => "Junior-Aurochspetter",
  
            },
          },             #   END OF 
          {              #  24
            :id          => 24,
            :exp         => 1141500,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Auerochsenstreichler",
  
            :en_US => "Aurochspetter",
  
            },
          },             #   END OF 
          {              #  25
            :id          => 25,
            :exp         => 1269250,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Wildpferdflüsterer",
  
            :en_US => "Junior-wildhorsewhisperer",
  
            },
          },             #   END OF 
          {              #  26
            :id          => 26,
            :exp         => 1404750,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Wildpferdflüsterer",
  
            :en_US => "Wildhorsewhisperer",
  
            },
          },             #   END OF 
          {              #  27
            :id          => 27,
            :exp         => 1547750,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Höhlenlöwenbeschwichtiger",
  
            :en_US => "Junior-Cavelionappeaser",
  
            },
          },             #   END OF 
          {              #  28
            :id          => 28,
            :exp         => 1689250,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Höhlenlöwenbeschwichtiger",
  
            :en_US => "Cavelionappeaser",
  
            },
          },             #   END OF 
          {              #  29
            :id          => 29,
            :exp         => 1856000,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Wollnashornknuddler",
  
            :en_US => "Junior-Woollyrhinocuddler",
  
            },
          },             #   END OF 
          {              #  30
            :id          => 30,
            :exp         => 2020750,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Wollnashornknuddler",
  
            :en_US => "Woollyrhinocuddle",
  
            },
          },             #   END OF 
          {              #  31
            :id          => 31,
            :exp         => 2220750,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Steppenwisentliebkoser",
  
            :en_US => "Junior-Steppewisentcaresser",
  
            },
          },             #   END OF 
          {              #  32
            :id          => 32,
            :exp         => 2442750,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Steppenwisentliebkoser",
  
            :en_US => "Steppewisentcaresser",
  
            },
          },             #   END OF 
          {              #  33
            :id          => 33,
            :exp         => 2686750,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Riesenhirschtätschler",
  
            :en_US => "Junior-Megalocerospatter",
  
            },
          },             #   END OF 
          {              #  34
            :id          => 34,
            :exp         => 2952750,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Riesenhirschtätschler",
  
            :en_US => "Megalocerospatter",
  
            },
          },             #   END OF 
          {              #  35
            :id          => 35,
            :exp         => 3240750,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Säbelzahntigerbändiger",
  
            :en_US => "Junior-Sabre-toothedtigertamer",
  
            },
          },             #   END OF 
          {              #  36
            :id          => 36,
            :exp         => 3550750,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Säbelzahntigerbändiger",
  
            :en_US => "Sabre-toothedtigertamer",
  
            },
          },             #   END OF 
          {              #  37
            :id          => 37,
            :exp         => 3882750,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Brontotherienbeschützer",
  
            :en_US => "Junior-Brontotheresguardian",
  
            },
          },             #   END OF 
          {              #  38
            :id          => 38,
            :exp         => 4236750,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Brontotherienbeschützer",
  
            :en_US => "Brontotheresguardian",
  
            },
          },             #   END OF 
          {              #  39
            :id          => 39,
            :exp         => 4612750,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Wollmammuttreiber",
  
            :en_US => "Junior-Woollymammothdriver",
  
            },
          },             #   END OF 
          {              #  40
            :id          => 40,
            :exp         => 5010750,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Wollmammuttreiber",
  
            :en_US => "Woollymammothdriver",
  
            },
          },             #   END OF 
          {              #  41
            :id          => 41,
            :exp         => 5430750,
            :settlement_points   => 0,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Nachwuchs-Allosaurusabrichter",
  
            :en_US => "Junior-Allosaurustrainer",
  
            },
          },             #   END OF 
          {              #  42
            :id          => 42,
            :exp         => 5872750,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Allosaurusabrichter",
  
            :en_US => "Allosaurustrainer",
  
            },
          },             #   END OF 
          {              #  43
            :id          => 43,
            :exp         => 6336750,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Tyrannosaurustyrann",
  
            :en_US => "Tyrannosaurstyrant",
  
            },
          },             #   END OF 
          {              #  44
            :id          => 44,
            :exp         => 7255579,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Tyrannosaurusmeistertyrann",
  
            :en_US => "Tyrannosaursmastertyrant",
  
            },
          },             #   END OF 
          {              #  45
            :id          => 45,
            :exp         => 8307638,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Höhlenherrscher",
  
            :en_US => "Cavesovereign",
  
            },
          },             #   END OF 
          {              #  46
            :id          => 46,
            :exp         => 9512245,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Drei-Kiesel-General",
  
            :en_US => "Gravelgeneral",
  
            },
          },             #   END OF 
          {              #  47
            :id          => 47,
            :exp         => 10891521,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Dinosaurierdespot",
  
            :en_US => "Dinosaurdespot",
  
            },
          },             #   END OF 
          {              #  48
            :id          => 48,
            :exp         => 12470791,
            :settlement_points   => 1,
            :minimum_sacred_rank => 0,
            :name        => {
              
            :de_DE => "Kriegsfürst",
  
            :en_US => "Warlord",
  
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
  
# ## FACEBOOK USER STORIES#######################################################

      :facebook_user_stories => [  # ALL FACEBOOK USER STORIES

        {              #   won_battle
          :id          => 0,
          :type        => :won_battle,
          :action      => :win,
          :symbolic_id => :user_story_won_battle,
          :name        => {
            
            :de_DE => "Kampf gewonnen",
  
            :en_US => "Won Battle",
  
          },
          :description => {
            
            :de_DE => "Der Spieler hat einen entscheidenen Kampf gewonnen",
  
            :en_US => "The player won a major battle",
  
          },
          :url          => 'https://gs04.wack-a-doo.de/game_server/en/facebook/object_types/0',
          :image_url    => 'https://gs04.wack-a-doo.de/game_server/assets/fb_user_stories/victory.png',
          :see_also_url => 'https://gs04.wack-a-doo.de',
        },              #   END OF won_battle
        {              #   reached_next_level
          :id          => 1,
          :type        => :reached_next_level,
          :action      => :reach,
          :symbolic_id => :user_story_reached_next_level,
          :name        => {
            
            :de_DE => "Erste Festung erobert",
  
            :en_US => "First Fortress",
  
          },
          :description => {
            
            :de_DE => "Der Spieler hat seine erste Festung erobert",
  
            :en_US => "The player conquered his first fortress",
  
          },
          :url          => 'https://gs04.wack-a-doo.de/game_server/en/facebook/object_types/1',
          :image_url    => 'https://gs04.wack-a-doo.de/game_server/assets/fb_user_stories/levelup.png',
          :see_also_url => 'https://gs04.wack-a-doo.de',
        },              #   END OF reached_next_level
      ],                # END OF FACEBOOK USER STORIES

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts GameRules::Rules.the_rules.to_json
#GameRules.rules.unit_types.each do |value| 
#  puts value[:name][:de_DE] 
#end

