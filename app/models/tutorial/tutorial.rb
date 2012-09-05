# encoding: utf-8  

require 'active_model'

# A module containing the tutorial quests of a particular game instance using the
# Augmented Worlds Engine.
#
# This particular file does hold the following set of rules:
# Game:    Wack-A-Doo
# Branch:  development (alpha)
# Version: 0.0.1
#
# ATTENTION: this file is auto-generated from rules/tutorial.xml . DO NOT EDIT 
# THIS FILE, as all your edits will be overwritten.
#
# This file is auto-generated. See the 'original' files (rules/tutorial.xml and 
# rules/tutorial.ruby.xsl) for the list of authors.
#
# All rights reserved. Copyright (C) 2012 5D Lab GmbH.



class Tutorial::Tutorial
  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  self.include_root_in_json = false

  attr_accessor :version, :quests
  
  def attributes 
    { 
      'version'        => version,
      'quests'         => quests,
    }
  end
  
  def initialize(attributes = {})
    if !Rails.logger.nil?
      Rails.logger.debug('TUTORIAL: running tutorial initializer.')
    end
  
    attributes.each do | name, value |
      send("#{name}=", value)
    end
  end
  
  # returns the rules-singleton containing all the present rules. Should not
  # be modified by the program. Uses conditional assignment to construct the
  # rules object on first access.
  def self.the_tutorial
    @the_tutorial ||= Tutorial::Tutorial.new(
  
      :version => {
        :major => 0, 
        :minor => 0, 
        :build => 1, 
      },
  
# ## QUESTS ##########################################################
  
      :quests => [  # ALL QUESTS

        {               #   quest_queue_1gathererlvl1
          :id          => 0, 
          :symbolic_id => :quest_queue_1gathererlvl1,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Gatherer",
  
            :de_DE => "Sammler",
                
          },
          :task        => {
            
            :en_US => "Build one Gatherer",
  
            :de_DE => "Baue einen Sammler",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Dazu klickst du auf einen Bauplatz, wählst den Sammler aus dem Baumenü und klickst auf build.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 20,
              },

              {
                :resource => :resource_wood,
                :amount => 20,
              },

              {
                :resource => :resource_fur,
                :amount => 20,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_queue_1gathererlvl1
        {               #   quest_build_1gathererlvl1
          :id          => 1, 
          :symbolic_id => :quest_build_1gathererlvl1,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Zweiter Sammler",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Gut gemacht. Baue jetzt einen weiteren Sammler.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_queue_1gathererlvl1',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 20,
              },

              {
                :resource => :resource_wood,
                :amount => 20,
              },

              {
                :resource => :resource_fur,
                :amount => 20,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 1,

                :min_count => 2,

              },

            ],

          },          

        },              #   END OF quest_build_1gathererlvl1
        {               #   quest_rank
          :id          => 2, 
          :symbolic_id => :quest_rank,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Rang",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Suche deinen Rang im Ranking.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl1',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 5,
              },

              {
                :resource => :resource_wood,
                :amount => 15,
              },

              {
                :resource => :resource_fur,
                :amount => 10,
              },

            ],

          },          

          :reward_tests => {
            
            :textbox_test => {
              :id => 'test_army_rank',
            },

          },          

        },              #   END OF quest_rank
        {               #   quest_build_2gathererlvl1
          :id          => 3, 
          :symbolic_id => :quest_build_2gathererlvl1,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Noch mehr Sammler",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue zwei weitere Sammler.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_rank',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 10,
              },

              {
                :resource => :resource_wood,
                :amount => 20,
              },

              {
                :resource => :resource_fur,
                :amount => 15,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 1,

                :min_count => 4,

              },

            ],

          },          

        },              #   END OF quest_build_2gathererlvl1
        {               #   quest_build_1gathererlvl2
          :id          => 4, 
          :symbolic_id => :quest_build_1gathererlvl2,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Ausbau eines Sammlers",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Bau einen Sammler auf Level 2 aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_2gathererlvl1',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 15,
              },

              {
                :resource => :resource_wood,
                :amount => 15,
              },

              {
                :resource => :resource_fur,
                :amount => 10,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 2,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1gathererlvl2
        {               #   quest_message
          :id          => 5, 
          :symbolic_id => :quest_message,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Nachrichten",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Lies die Nachricht.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_2gathererlvl1',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 5,
              },

            ],

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_open_message',
            },

          },          

          :message => {
            
            :en => {
              :subject => 'Subject',
              :body => 'Message with content',
            },

            :de => {
              :subject => 'Betreff',
              :body => 'Nachricht mit Inhalt',
            },

          },          

        },              #   END OF quest_message
        {               #   quest_build_chieftainslvl2
          :id          => 6, 
          :symbolic_id => :quest_build_chieftainslvl2,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Häuptlingshütte Level 2",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue deine Häuptlingshütte auf Level 2 aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl2',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 80,
              },

              {
                :resource => :resource_wood,
                :amount => 80,
              },

              {
                :resource => :resource_fur,
                :amount => 40,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_chief_cottage',

                :min_level => 2,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_chieftainslvl2
        {               #   quest_settlementowner
          :id          => 7, 
          :symbolic_id => :quest_settlementowner,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Festungen",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Trage den Besitzer der Festung in deiner Region ein.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_message',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 10,
              },

              {
                :resource => :resource_wood,
                :amount => 15,
              },

              {
                :resource => :resource_fur,
                :amount => 5,
              },

            ],

          },          

          :reward_tests => {
            
            :textbox_test => {
              :id => 'test_fortress_owner',
            },

          },          

        },              #   END OF quest_settlementowner
        {               #   quest_settlement_button
          :id          => 8, 
          :symbolic_id => :quest_settlement_button,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Karte",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Benutze den Siedlungsbutton um die Karte über deiner Siedlung zu zentrieren.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_settlementowner',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 20,
              },

              {
                :resource => :resource_wood,
                :amount => 10,
              },

              {
                :resource => :resource_fur,
                :amount => 10,
              },

            ],

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_settlement_button',
            },

          },          

        },              #   END OF quest_settlement_button
        {               #   quest_profile
          :id          => 9, 
          :symbolic_id => :quest_profile,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Profil",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Ändere deinen Profiltext.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_settlement_button',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 15,
              },

              {
                :resource => :resource_wood,
                :amount => 20,
              },

              {
                :resource => :resource_fur,
                :amount => 10,
              },

            ],

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_change_profile',
            },

          },          

        },              #   END OF quest_profile
        {               #   quest_encyclopedia
          :id          => 10, 
          :symbolic_id => :quest_encyclopedia,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Enzyklopädie",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Suche die Holzkosten einer Kaserne Level 2 heraus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_profile',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 5,
              },

              {
                :resource => :resource_wood,
                :amount => 5,
              },

              {
                :resource => :resource_fur,
                :amount => 10,
              },

            ],

          },          

          :reward_tests => {
            
            :textbox_test => {
              :id => 'test_costs',
            },

          },          

        },              #   END OF quest_encyclopedia
        {               #   quest_build_1cottagelvl1
          :id          => 11, 
          :symbolic_id => :quest_build_1cottagelvl1,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Hütten",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue eine Hütte.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chieftainslvl2',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 15,
              },

              {
                :resource => :resource_wood,
                :amount => 15,
              },

              {
                :resource => :resource_fur,
                :amount => 10,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_cottage',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1cottagelvl1
        {               #   quest_build_chiefcottagelvl3
          :id          => 12, 
          :symbolic_id => :quest_build_chiefcottagelvl3,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Häuptlingshütte Level 3",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue deine Häuptlingshütte auf Level 3 aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1cottagelvl1',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 150,
              },

              {
                :resource => :resource_wood,
                :amount => 150,
              },

              {
                :resource => :resource_fur,
                :amount => 75,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_chief_cottage',

                :min_level => 3,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_chiefcottagelvl3
        {               #   quest_build_1barrackslvl1
          :id          => 13, 
          :symbolic_id => :quest_build_1barrackslvl1,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Kaserne",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue eine Kaserne.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl3',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 60,
              },

              {
                :resource => :resource_wood,
                :amount => 40,
              },

              {
                :resource => :resource_fur,
                :amount => 80,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_barracks',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1barrackslvl1
        {               #   quest_recruit_1clubbers
          :id          => 14, 
          :symbolic_id => :quest_recruit_1clubbers,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Einheiten",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue einen Keulenkrieger.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1barrackslvl1',

          },

          :rewards => {
            
            :unit_rewards => [

              {
                :unit => :unit_clubbers,
                :amount => 3,
              },

            ],

          },          

          :reward_tests => {
            
            :army_tests => [

              {
                :type => 'garrison',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_recruit_1clubbers
        {               #   quest_army_create
          :id          => 15, 
          :symbolic_id => :quest_army_create,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Armee",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Stelle eine Armee auf.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_recruit_1clubbers',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 10,
              },

              {
                :resource => :resource_wood,
                :amount => 30,
              },

              {
                :resource => :resource_fur,
                :amount => 15,
              },

            ],

          },          

          :reward_tests => {
            
            :army_tests => [

              {
                :type => 'visible',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_army_create
        {               #   quest_army_move
          :id          => 16, 
          :symbolic_id => :quest_army_move,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Armeebewegung",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Bewege deine Armee zur Festung.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_army_create',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 15,
              },

              {
                :resource => :resource_wood,
                :amount => 25,
              },

              {
                :resource => :resource_fur,
                :amount => 10,
              },

            ],

          },          

          :reward_tests => {
            
            :movement_test => {},

          },          

        },              #   END OF quest_army_move
        {               #   quest_build_chiefcottagelvl4
          :id          => 17, 
          :symbolic_id => :quest_build_chiefcottagelvl4,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Häuptlingshütte Level 4",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue deine Häuptlingshütte auf Level 4 aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_army_move',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 200,
              },

              {
                :resource => :resource_wood,
                :amount => 200,
              },

              {
                :resource => :resource_fur,
                :amount => 100,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_chief_cottage',

                :min_level => 4,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_chiefcottagelvl4
        {               #   quest_build_1campfirelvl1
          :id          => 18, 
          :symbolic_id => :quest_build_1campfirelvl1,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Lagerfeuer",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue ein Lagerfeuer.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl4',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 40,
              },

              {
                :resource => :resource_wood,
                :amount => 40,
              },

              {
                :resource => :resource_fur,
                :amount => 5,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_campfire',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1campfirelvl1
        {               #   quest_alliance
          :id          => 19, 
          :symbolic_id => :quest_alliance,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Allianzen",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Trete einer Allianz bei oder Gründe deine eigene.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1campfirelvl1',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 100,
              },

              {
                :resource => :resource_wood,
                :amount => 105,
              },

              {
                :resource => :resource_fur,
                :amount => 45,
              },

            ],

          },          

          :reward_tests => {
            
            :alliance_test => {},

          },          

        },              #   END OF quest_alliance
        {               #   quest_build_chiefcottagelvl5
          :id          => 20, 
          :symbolic_id => :quest_build_chiefcottagelvl5,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Häuptlingshütte Level 5",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue deine Häuptlingshütte auf Level 5 aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl4',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 250,
              },

              {
                :resource => :resource_wood,
                :amount => 250,
              },

              {
                :resource => :resource_fur,
                :amount => 125,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_chief_cottage',

                :min_level => 5,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_chiefcottagelvl5
        {               #   quest_recruitfriends
          :id          => 21, 
          :symbolic_id => :quest_recruitfriends,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Freunde",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Trage die Belohnung ein, die es maximal für rekrutierte Freunde gibt.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl4',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 20,
              },

              {
                :resource => :resource_wood,
                :amount => 15,
              },

              {
                :resource => :resource_fur,
                :amount => 10,
              },

            ],

          },          

          :reward_tests => {
            
            :textbox_test => {
              :id => 'test_recruit_friends_reward',
            },

          },          

        },              #   END OF quest_recruitfriends
        {               #   quest_build_1marketlvl1
          :id          => 22, 
          :symbolic_id => :quest_build_1marketlvl1,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Lager",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue ein Lager.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl4',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 35,
              },

              {
                :resource => :resource_wood,
                :amount => 45,
              },

              {
                :resource => :resource_fur,
                :amount => 20,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_storage',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1marketlvl1
        {               #   quest_build_1quarrylvl1_1loggerlvl1
          :id          => 23, 
          :symbolic_id => :quest_build_1quarrylvl1_1loggerlvl1,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Baumfäller und Steinbruch",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue einen Holzfäller und einen Steinbruch.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl5',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 50,
              },

              {
                :resource => :resource_wood,
                :amount => 50,
              },

              {
                :resource => :resource_fur,
                :amount => 10,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_quarry',

                :min_level => 1,

                :min_count => 1,

              },

              {
                :building => 'building_logger',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1quarrylvl1_1loggerlvl1
        {               #   quest_build_5quarrylvl5_5loggerlvl5
          :id          => 24, 
          :symbolic_id => :quest_build_5quarrylvl5_5loggerlvl5,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Noch mehr Holzfäller und Steinbrüche",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue je 5 Holzfäller und Steinbrüche auf Level 5.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1quarrylvl1_1loggerlvl1',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 300,
              },

              {
                :resource => :resource_wood,
                :amount => 300,
              },

              {
                :resource => :resource_fur,
                :amount => 60,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_quarry',

                :min_level => 5,

                :min_count => 5,

              },

              {
                :building => 'building_logger',

                :min_level => 5,

                :min_count => 5,

              },

            ],

          },          

        },              #   END OF quest_build_5quarrylvl5_5loggerlvl5
        {               #   quest_outpost
          :id          => 25, 
          :symbolic_id => :quest_outpost,
          :advisor     => :warrior,
          :name        => {
            
            :en_US => "Dorf",
  
            :de_DE => "",
                
          },
          :task        => {
            
            :en_US => "",
  
            :de_DE => "",
                
          },
          :flavour     => {
            
            :de_DE => "Flavortext deutsch",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Gründe ein Dorf.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_text => {
            
            :de_DE => "Gut gemacht!",
  
            :en_US => "Good gemaked! ;-)",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl4',

          },

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
                :amount => 250,
              },

            ],

          },          

          :reward_tests => {
            
            :settlement_tests => [

              {
                :type => 'settlement_outpost',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_outpost
      ],                # END OF QUESTS

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts Tutorial::Tutorial.the_tutorial.to_json
#Tutorial.tutorial.quests.each do |value| 
#  puts value[:name][:de_DE] 
#end

