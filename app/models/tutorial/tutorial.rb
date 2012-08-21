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
  
  def persisted?
    false
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
          :name        => {
            
            :en_US => "Baue einen Sammler",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Dazu klickst du auf einen Bauplatz, wählst den Sammler aus dem Baumenü und klickst auf "build".</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :rewards => [
            
            :construction_reward => {},

          ],          

          :reward_tests => [
            
            :construction_queue_test => {
              :building => 'building_gatherer',
              :min_count => 1,
            },

          ],          

        },              #   END OF quest_queue_1gathererlvl1
        {               #   quest_build_1gathererlvl1
          :id          => 1, 
          :symbolic_id => :quest_build_1gathererlvl1,
          :name        => {
            
            :en_US => "Zweiter Sammler",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Gut gemacht. Baue jetzt einen weiteren Sammler.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_queue_1gathererlvl1',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 20,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 20,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 20,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_gatherer',

              :min_count => 2,

            },

          ],          

        },              #   END OF quest_build_1gathererlvl1
        {               #   quest_change_settlementname
          :id          => 2, 
          :symbolic_id => :quest_change_settlementname,
          :name        => {
            
            :en_US => "Siedlungsname",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Ändere den Namen deiner Siedlung.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_1gathererlvl1',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 10,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 10,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 5,
            },

          ],          

          :reward_tests => [
            
            :custom_test => {
              :test => ' Dorfname geändert ',
            },

          ],          

        },              #   END OF quest_change_settlementname
        {               #   quest_rank
          :id          => 3, 
          :symbolic_id => :quest_rank,
          :name        => {
            
            :en_US => "Rang",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Suche deinen Rang im Ranking.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_change_settlementname',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 5,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 15,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 10,
            },

          ],          

          :reward_tests => [
            
            :custom_test => {
              :test => ' Rang eingegeben ',
            },

          ],          

        },              #   END OF quest_rank
        {               #   quest_build_2gathererlvl1
          :id          => 4, 
          :symbolic_id => :quest_build_2gathererlvl1,
          :name        => {
            
            :en_US => "Noch mehr Sammler",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue zwei weitere Sammler.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_rank',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 10,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 20,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 15,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_gatherer',

              :min_count => 4,

            },

          ],          

        },              #   END OF quest_build_2gathererlvl1
        {               #   quest_build_1gathererlvl2
          :id          => 5, 
          :symbolic_id => :quest_build_1gathererlvl2,
          :name        => {
            
            :en_US => "Ausbau eines Sammlers",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Bau einen Sammler auf Level 2 aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_2gathererlvl1',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 15,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 15,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 10,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_gatherer',

              :min_level => 2,

            },

          ],          

        },              #   END OF quest_build_1gathererlvl2
        {               #   quest_message
          :id          => 6, 
          :symbolic_id => :quest_message,
          :name        => {
            
            :en_US => "Nachrichten",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Lies die Nachricht.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_2gathererlvl1',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_cash',
              :amount => 5,
            },

          ],          

          :reward_tests => [
            
            :custom_test => {
              :test => 'send Message, Message opened',
            },

          ],          

          :message => {
            
            :en_US => {
              :subject => 'Subject',
              :body => 'Message with content',
            },

            :de_DE => {
              :subject => 'Betreff',
              :body => 'Nachricht mit Inhalt',
            },

          },          

        },              #   END OF quest_message
        {               #   quest_build_chieftainslvl2
          :id          => 7, 
          :symbolic_id => :quest_build_chieftainslvl2,
          :name        => {
            
            :en_US => "Häuptlingshütte Level 2",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue deine Häuptlingshütte auf Level 2 aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_1gathererlvl2',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 80,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 80,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 40,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_chief_cottage',

              :min_level => 2,

            },

          ],          

        },              #   END OF quest_build_chieftainslvl2
        {               #   quest_settlementowner
          :id          => 8, 
          :symbolic_id => :quest_settlementowner,
          :name        => {
            
            :en_US => "Festungen",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Trage den Besitzer der Festung in deiner Region ein.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_message',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 10,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 15,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 5,
            },

          ],          

          :reward_tests => [
            
            :custom_test => {
              :test => 'fortress owner in Region',
            },

          ],          

        },              #   END OF quest_settlementowner
        {               #   quest_settlementbutton
          :id          => 9, 
          :symbolic_id => :quest_settlementbutton,
          :name        => {
            
            :en_US => "Karte",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Benutze den Siedlungsbutton um die Karte über deiner Siedlung zu zentrieren.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_settlementowner',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 20,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 10,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 10,
            },

          ],          

          :reward_tests => [
            
          ],          

        },              #   END OF quest_settlementbutton
        {               #   quest_profile
          :id          => 10, 
          :symbolic_id => :quest_profile,
          :name        => {
            
            :en_US => "Profil",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Ändere deinen Profiltext.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_settlementbutton',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 15,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 20,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 10,
            },

          ],          

          :reward_tests => [
            
          ],          

        },              #   END OF quest_profile
        {               #   quest_encyclopedia
          :id          => 11, 
          :symbolic_id => :quest_encyclopedia,
          :name        => {
            
            :en_US => "Enzyklopädie",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Suche die Holzkosten einer Kaserne Level 2 heraus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_profile',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 5,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 5,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 10,
            },

          ],          

          :reward_tests => [
            
            :custom_test => {
              :test => ' Textbox Holzkosten Kaserne l2 ',
            },

          ],          

        },              #   END OF quest_encyclopedia
        {               #   quest_build_1cottagelvl1
          :id          => 12, 
          :symbolic_id => :quest_build_1cottagelvl1,
          :name        => {
            
            :en_US => "Hütten",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue eine Hütte.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_chieftainslvl2',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 15,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 15,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 10,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_cottage',

              :min_level => 1,

              :min_count => 1,

            },

          ],          

        },              #   END OF quest_build_1cottagelvl1
        {               #   quest_build_chiefcottagelvl3
          :id          => 13, 
          :symbolic_id => :quest_build_chiefcottagelvl3,
          :name        => {
            
            :en_US => "Häuptlingshütte Level 3",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue deine Häuptlingshütte auf Level 3 aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_1cottagelvl1',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 150,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 150,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 75,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_chief_cottage',

              :min_level => 3,

            },

          ],          

        },              #   END OF quest_build_chiefcottagelvl3
        {               #   quest_build_1barrackslvl1
          :id          => 14, 
          :symbolic_id => :quest_build_1barrackslvl1,
          :name        => {
            
            :en_US => "Kaserne",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue eine Kaserne.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_chiefcottagelvl3',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 60,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 40,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 80,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_barracks',

              :min_level => 1,

            },

          ],          

        },              #   END OF quest_build_1barrackslvl1
        {               #   quest_recruit_1clubbers
          :id          => 15, 
          :symbolic_id => :quest_recruit_1clubbers,
          :name        => {
            
            :en_US => "Einheiten",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue einen Keulenkrieger.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_1barrackslvl1',
            },

          :rewards => [
            
            :training_reward => {},

          ],          

          :reward_tests => [
            
            :training_queue_test => {
              :unit => 'clubbers',
              :min_count => 1,
            },

          ],          

        },              #   END OF quest_recruit_1clubbers
        {               #   quest_build_1walllvl1
          :id          => 16, 
          :symbolic_id => :quest_build_1walllvl1,
          :name        => {
            
            :en_US => "Verteidigungsanlagen",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue einen Wall.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_recruit_1clubbers',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 35,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 15,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 15,
            },

          ],          

          :reward_tests => [
            
          ],          

        },              #   END OF quest_build_1walllvl1
        {               #   quest_army_create
          :id          => 17, 
          :symbolic_id => :quest_army_create,
          :name        => {
            
            :en_US => "Armee",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Stelle eine Armee auf.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_recruit_1clubbers',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 10,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 30,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 15,
            },

          ],          

          :reward_tests => [
            
            :army_test => {
              :type => 'visible',
              :min_count => 1,
            },

          ],          

        },              #   END OF quest_army_create
        {               #   quest_army_move
          :id          => 18, 
          :symbolic_id => :quest_army_move,
          :name        => {
            
            :en_US => "Armeebewegung",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Bewege deine Armee zur Festung.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_army_create',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 15,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 25,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 10,
            },

          ],          

          :reward_tests => [
            
            :custom_test => {
              :test => ' armeebewegung ',
            },

          ],          

        },              #   END OF quest_army_move
        {               #   quest_build_chiefcottagelvl4
          :id          => 19, 
          :symbolic_id => :quest_build_chiefcottagelvl4,
          :name        => {
            
            :en_US => "Häuptlingshütte Level 4",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue deine Häuptlingshütte auf Level 4 aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_1walllvl1',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 200,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 200,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 100,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_chief_cottage',

              :min_level => 4,

            },

          ],          

        },              #   END OF quest_build_chiefcottagelvl4
        {               #   quest_build_1campfirelvl1
          :id          => 20, 
          :symbolic_id => :quest_build_1campfirelvl1,
          :name        => {
            
            :en_US => "Lagerfeuer",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue ein Lagerfeuer.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_chiefcottagelvl4',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 40,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 40,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 5,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_campfire',

              :min_level => 1,

            },

          ],          

        },              #   END OF quest_build_1campfirelvl1
        {               #   quest_alliance
          :id          => 21, 
          :symbolic_id => :quest_alliance,
          :name        => {
            
            :en_US => "Allianzen",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Trete einer Allianz bei oder Gründe deine eigene.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_1campfirelvl1',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 100,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 105,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 45,
            },

          ],          

          :reward_tests => [
            
            :custom_test => {
              :test => ' Allianz check ',
            },

          ],          

        },              #   END OF quest_alliance
        {               #   quest_build_chiefcottagelvl5
          :id          => 22, 
          :symbolic_id => :quest_build_chiefcottagelvl5,
          :name        => {
            
            :en_US => "Häuptlingshütte Level 5",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue deine Häuptlingshütte auf Level 5 aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_chiefcottagelvl4',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 250,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 250,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 125,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_chief_cottage',

              :min_level => 5,

            },

          ],          

        },              #   END OF quest_build_chiefcottagelvl5
        {               #   quest_recruitfriends
          :id          => 23, 
          :symbolic_id => :quest_recruitfriends,
          :name        => {
            
            :en_US => "Freunde",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Trage die Belohnung ein, die es maximal für rekrutierte Freunde gibt.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_chiefcottagelvl4',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 20,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 15,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 10,
            },

          ],          

          :reward_tests => [
            
            :custom_test => {
              :test => ' Textbox: Reward Freunde werben ',
            },

          ],          

        },              #   END OF quest_recruitfriends
        {               #   quest_build_1marketlvl1
          :id          => 24, 
          :symbolic_id => :quest_build_1marketlvl1,
          :name        => {
            
            :en_US => "Markt",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue einen Markt.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_chiefcottagelvl4',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 35,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 45,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 20,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_market',

              :min_level => 1,

            },

          ],          

        },              #   END OF quest_build_1marketlvl1
        {               #   quest_build_1quarrylvl1_1loggerlvl1
          :id          => 25, 
          :symbolic_id => :quest_build_1quarrylvl1_1loggerlvl1,
          :name        => {
            
            :en_US => "Baumfäller und Steinbruch",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue einen Holzfäller und einen Steinbruch.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_chiefcottagelvl4',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 50,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 50,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 10,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_quarry',

              :min_level => 1,

            },

            :building_test => {
              :building => 'building_logger',

              :min_level => 1,

            },

          ],          

        },              #   END OF quest_build_1quarrylvl1_1loggerlvl1
        {               #   quest_build_5quarrylvl5_5loggerlvl5
          :id          => 26, 
          :symbolic_id => :quest_build_5quarrylvl5_5loggerlvl5,
          :name        => {
            
            :en_US => "Noch mehr Holzfäller und Steinbrüche",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Baue je 5 Holzfäller und Steinbrüche auf Level 5.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_1quarrylvl1_1loggerlvl1',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 300,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 300,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 60,
            },

          ],          

          :reward_tests => [
            
            :building_test => {
              :building => 'building_quarry',

              :min_level => 5,

              :min_count => 5,

            },

            :building_test => {
              :building => 'building_logger',

              :min_level => 5,

              :min_count => 5,

            },

          ],          

        },              #   END OF quest_build_5quarrylvl5_5loggerlvl5
        {               #   quest_outpost
          :id          => 27, 
          :symbolic_id => :quest_outpost,
          :name        => {
            
            :en_US => "Dorf",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Gründe ein Dorf.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'quest_build_chiefcottagelvl4',
            },

          :rewards => [
            
            :resource_reward => {
              :resource => 'resource_stone',
              :amount => 500,
            },

            :resource_reward => {
              :resource => 'resource_wood',
              :amount => 500,
            },

            :resource_reward => {
              :resource => 'resource_fur',
              :amount => 250,
            },

          ],          

          :reward_tests => [
            
            :settlement_test => {
              :type => 'settlement_outpost',
              :min_count => 1,
            },

          ],          

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

