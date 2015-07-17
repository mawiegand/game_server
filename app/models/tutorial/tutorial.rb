# encoding: utf-8  

require 'active_model'

# A module containing the tutorial quests of a particular game instance using the
# Augmented Worlds Engine.
#
# This particular file does hold the following set of rules:
# Game:    Wack-A-Doo
# Branch:  development (alpha)
# Version: 1.0.6
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

  attr_accessor :version, :quests, :updated_at, :num_tutorial_quests, :production_test_weights, :tutorial_reward
  
  def attributes 
    { 
      'version'                  => version,
      'quests'                   => quests,
      'updated_at'               => updated_at,
      'num_tutorial_quests'      => num_tutorial_quests,
      'production_test_weights'  => production_test_weights,
      'tutorial_reward'          => tutorial_reward,
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
  def self.the_tutorial
    @the_tutorial ||= Tutorial::Tutorial.new(
  
      :version => {
        :major => 1, 
        :minor => 0, 
        :build => 6, 
      },
      
      :production_test_weights => {
  
        :resource_wood => 1,
        :resource_stone => 1,
        :resource_fur => 1,
        :resource_cash => 0,
      },
      
      :tutorial_reward => {
        :platinum_duration => 72      
      },
      
      :updated_at => File.ctime(__FILE__),
      
  
# ## QUESTS ##########################################################
  
      :num_tutorial_quests => 15,
  
      :quests => [  # ALL QUESTS

        {               #   quest_queue_1gathererlvl1
          :id                => 0,
          :symbolic_id       => :quest_queue_1gathererlvl1,
  
          :type              => :epic,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "The first building",
  
            :de_DE => "Der Sammler",
                
          },
          :task => {
            
            :en_US => "Build a Gatherer. He will prepare the great settlement building",
  
            :de_DE => "Baue einen Sammler. Er wird den großen Siedlungsbau vorbereiten.",
                
          },
          :flavour => {
            
            :de_DE => "Willkommen Halbgott. Schau Dir Deine Siedlung an, ist sie nicht wundervoll?",
  
            :en_US => "Welcome Demigod! Look at your settlement – isn't it great?",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Sehr gut! Jetzt kann der Ausbau losgehen.",
  
            :en_US => "Very well! Now the settlements construction can begin.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 10,
              },

              {
                :resource => :resource_wood,
                :amount => 10,
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

          :uimarker => ['mark_home_settlement', 'mark_free_construction_slot', 'mark_building_option', ],

        },              #   END OF quest_queue_1gathererlvl1
        {               #   quest_build_chiefcottagelvl2
          :id                => 1,
          :symbolic_id       => :quest_build_chiefcottagelvl2,
  
          :type              => :epic,
  
          :advisor           => :chef,
          :hide_start_dialog => true,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Upgrade chief's hut",
  
            :de_DE => "Die Chefhütte",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftain’s hut to level 2.",
  
            :de_DE => "Baue deine Chefhütte auf Level 2 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Halbgott? Und was soll das da sein? Meine Chefhütte? Da kann ja niemand drin leben! Ändere das sofort!",
  
            :en_US => "Demigod?! I don´t think so. Look at my chieftan´s hut! You think I´m going to live in that? Ha! Change it immediately!",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Endlich ein Platz zum Herrschen.",
  
            :en_US => "Finally a space to rule.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_queue_1gathererlvl1',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 58,
              },

              {
                :resource => :resource_wood,
                :amount => 58,
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

          :uimarker => ['mark_home_settlement', 'mark_upgradable_building', 'mark_upgrade_button', ],

        },              #   END OF quest_build_chiefcottagelvl2
        {               #   quest_build_tavern
          :id                => 2,
          :symbolic_id       => :quest_build_tavern,
  
          :type              => :epic,
  
          :advisor           => :warrior,
          :hide_start_dialog => true,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "The Tavern",
  
            :de_DE => "Die Taverne",
                
          },
          :task => {
            
            :en_US => "The warriors need a drink! Build a tavern..",
  
            :de_DE => "Die Krieger brauchen was zu trinken! Baue eine Taverne.",
                
          },
          :flavour => {
            
            :de_DE => "Ein Ort zum trinken? Ganz mein Geschmack.",
  
            :en_US => "Finally a place where i can have a pint in peace.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Prost! Und dann zurück an die Arbeit.",
  
            :en_US => "Cheers! And then back to work.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_build_chiefcottagelvl2',
              },

            ],
  
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

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_tavern',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_free_construction_slot', 'mark_building_option', ],

        },              #   END OF quest_build_tavern
        {               #   quest_assignment
          :id                => 3,
          :symbolic_id       => :quest_assignment,
  
          :type              => :epic,
  
          :advisor           => :warrior,
          :hide_start_dialog => true,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "First Assignment",
  
            :de_DE => "Der erste Auftrag",
                
          },
          :task => {
            
            :en_US => "Startle the drunkards and start your first assignment.",
  
            :de_DE => "Scheuch die Saufnasen auf und starte deinen ersten Auftrag.",
                
          },
          :flavour => {
            
            :de_DE => "Krempel die Ärmel hoch, wir haben Arbeit zu verrichten.",
  
            :en_US => "Pull up those sleeves, looks like we got work to do.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Mit Aufträgen verdienst du ein paar extra Rohstoffe.",
  
            :en_US => "Earn some additional resources through assignments.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_build_tavern',
              },

            ],
  
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

            ],

          },          

          :reward_tests => {
            
            :standard_assignment_test => {},

          },          

          :uimarker => ['mark_first_standard_assignment', ],

        },              #   END OF quest_assignment
        {               #   quest_build_chiefcottagelvl3
          :id                => 4,
          :symbolic_id       => :quest_build_chiefcottagelvl3,
  
          :type              => :epic,
  
          :advisor           => :chef,
          :hide_start_dialog => true,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chief's hut",
  
            :de_DE => "Die Chefhütte",
                
          },
          :task => {
            
            :en_US => "Upgrade your chief's hut to level 3.",
  
            :de_DE => "Baue die Chefhütte für einen neuen Bauplatz aus.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Siedlung kommt ganz schön voran. Aber Du musst jetzt die Chefhütte ausbauen um weiterzukommen.",
  
            :en_US => "Your settlement is coming along nicely, but you're going to have to upgrade the chief's hut if you want to make some more progress.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Die Chefhütte schaltet neue Bauplätze frei.",
  
            :en_US => "The chieftain’s hut unlocks new building spots.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_assignment',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 50,
              },

              {
                :resource => :resource_wood,
                :amount => 25,
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

          :uimarker => ['mark_home_settlement', 'mark_upgradable_building', 'mark_upgrade_button', ],

          :message => {
            
            :en => {
              :subject => 'Welcome to Wack-A-Doo!',
              :body => "<h2>Welcome to the Wack-A-Doo community!</h2>
        <p>Prepare to be surprised!</p>
        <p>We suggest that you follow the tutorial and complete the subsequent quests in order to learn the basics of Wack-A-Doo. Other players will also be happy to answer your questions, both in general chat and in your alliances.</p>
        <p>You can find detailed instructions and on overview of the game mechanics in our in-game encyclopedia an in our wiki:</p>
        <p style='margin-left: 32px;'><a href='http://wiki.wack-a-doo.com/Main_Page' target='_blank'>Wack-A-Doo Wiki</a> (under construction!); <a href='http://wiki.wack-a-doo.com/Tech_Tree' target='_blank'>Tech-Tree</a> ; <a href='http://wiki.wack-a-doo.com/Unit_Tech_Tree' target='_blank'>Unit Overview</a></p>
        <p>We invite you to register and help keep our Wiki up to date.</p>
        <p>Wack-A-Doo can be played on a wide variety of devices, iOS, browser and Android. We invite you to try all versions for yourself.</p>
        <p>Please report all bugs you find and give us feedback. We want to hear your opinion on the game, in items of both what works and what works and what could be improved. Please use our forum if you want to give feedback:</p>
        <p style='margin-left: 32px;'><a href='http://forum.uga-agga.de' target='_blank'>Wack-A-Doo at the Uga Agga Forum</a></p>
        <p>We hope you have lots of fun with Wack-A-Doo.</p>
        <p>The Wack-A-Doo Team</p>",
            },

            :de => {
              :subject => 'Willkommen bei Wack-A-Doo',
              :body => "<p>Herzlich willkommen in der 'Wack-A-Doo'-Community!<p/>
        <p>Wir empfehlen Dir, das Tutorial und die folgenden Quests zu spielen, um die Grundlagen von Wack-A-Doo kennen zu lernen.</p>
        <p>Für den Fall, dass Dir die Bedienung an einer Stelle unklar ist, werden die wichtigsten Spielmechanismen auf folgenden Seiten
        im Detail und mit Bildern erläutert:
        <ul>
        <li><a href='https://ios.wack-a-doo.com/de/encyclopedia/game_mechanism' target='_blank'>Spielprinzip</a></li>
        <li><a href='https://ios.wack-a-doo.com/de/encyclopedia/create_army' target='_blank'>Armee erstellen</a></li>
        <li><a href='https://ios.wack-a-doo.com/de/encyclopedia/move_army' target='_blank'>Armee bewegen</a></li>
        <li><a href='https://ios.wack-a-doo.com/de/encyclopedia/battle' target='_blank'>Kampfablauf</a></li>
        <li><a href='https://ios.wack-a-doo.com/de/encyclopedia/settlement' target='_blank'>Zweite Siedlung</a></li>
        <li><a href='https://ios.wack-a-doo.com/de/encyclopedia/faq' target='_blank'>FAQ</a></li>
        </ul></p>
        <p>
        Du kannst Wack-A-Doo im Browser unter <a href='https://wack-a-doo.de' target='_blank'>https://wack-a-doo.de</a> und auf Deinem
        iPhone, iPad und iPod touch oder deinem Android Gerät mit unserer App spielen. Eine Anleitung, wie Du Deinen Account portabel machst, findest Du hier:
        <a href='https://ios.wack-a-doo.com/de/encyclopedia/account' target='_blank'>Account portabel machen</a>.</p>
        <p>Wir wünschen Dir viel Spaß bei Wack-A-Doo.</p>
        <p>Das Wack-A-Doo Team</p>",
            },

          },          

        },              #   END OF quest_build_chiefcottagelvl3
        {               #   quest_build_barracks
          :id                => 5,
          :symbolic_id       => :quest_build_barracks,
  
          :type              => :epic,
  
          :advisor           => :chef,
          :hide_start_dialog => true,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Training Grounds",
  
            :de_DE => "Ausbildungsgelände",
                
          },
          :task => {
            
            :en_US => "Build training grounds.",
  
            :de_DE => "Baue auf dem freien Bauplatz ein Ausbildungsgelände.",
                
          },
          :flavour => {
            
            :de_DE => "Du kannst ein Ausbildungsgelände bauen, machst es aber nicht? Bau sofort eins und ich gebe Dir etwas aus meiner Schatzkiste.",
  
            :en_US => "You can build a Training Grounds but you're not doing it? If you build one now, I´ll give you something from my treasure chest.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Der Ausbau beschleunigt die Ausbildung der Nahkämpfer.",
  
            :en_US => "Upgrade your training grounds to increase the training speed for melee units.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_build_chiefcottagelvl3',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 25,
              },

              {
                :resource => :resource_wood,
                :amount => 25,
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

          :uimarker => ['mark_home_settlement', 'mark_free_construction_slot', 'mark_building_option', ],

        },              #   END OF quest_build_barracks
        {               #   quest_recruit_warrior
          :id                => 6,
          :symbolic_id       => :quest_recruit_warrior,
  
          :type              => :epic,
  
          :advisor           => :warrior,
          :hide_start_dialog => true,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Your first unit",
  
            :de_DE => "Deine erste Einheit",
                
          },
          :task => {
            
            :en_US => "Train a warrior.",
  
            :de_DE => "Bilde im Ausbildungsgelände einen Krieger aus.",
                
          },
          :flavour => {
            
            :de_DE => "Hmm? Keine Einheiten weit und breit. Da sollte sich mal jemand drum kümmern, sonst wird diese Siedlung demnächst niedergebrannt.",
  
            :en_US => "What? Not a unit to be seen anywhere. Someone should pay attention to that or the settlement will soon be burned to the ground.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Mehrere Einheiten werden nacheinander ausgebildet.",
  
            :en_US => "Several units will be trained one after another.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_build_barracks',
              },

            ],
  
          },

          :rewards => {
            
            :unit_rewards => [

              {
                :unit => :unit_warrior,
                :amount => 10,
              },

            ],

          },          

          :reward_tests => {
            
            :training_queue_tests => [

              {
                :unit => 'unit_warrior',
                :min_count => 1,
              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_units_button', 'mark_training_dialog_flow', ],

        },              #   END OF quest_recruit_warrior
        {               #   quest_settlement_button1
          :id                => 7,
          :symbolic_id       => :quest_settlement_button1,
  
          :type              => :epic,
  
          :advisor           => :chef,
          :hide_start_dialog => true,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "On the map",
  
            :de_DE => "Auf die Karte",
                
          },
          :task => {
            
            :en_US => "Go to the world map.",
  
            :de_DE => "Gehe auf die Weltkarte.",
                
          },
          :flavour => {
            
            :de_DE => "Was? Dir ist es hier zu klein? Es gibt eine riesige Welt zu erobern. Wenn Du mal aus diesem Loch rauskommen würdest, wüsstest Du das auch. Worauf wartest Du? Geh!",
  
            :en_US => "What? It's too small for you here? There's a whole world to conquer. If you made an effort to get out of this hole, you´d realize that. So what are you waiting for?! Go!",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Auf der Weltkarte kannst du die Aktivitäten aller Spieler sehen.",
  
            :en_US => "On the world map you can see the activities of all players.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_recruit_warrior',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_settlement_button1',
            },

          },          

          :uimarker => ['mark_map', ],

        },              #   END OF quest_settlement_button1
        {               #   quest_army_create
          :id                => 8,
          :symbolic_id       => :quest_army_create,
  
          :type              => :epic,
  
          :advisor           => :warrior,
          :hide_start_dialog => true,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Your first army",
  
            :de_DE => "Deine erste Armee",
                
          },
          :task => {
            
            :en_US => "Assemble an army.",
  
            :de_DE => "Stelle deine erste Armee auf.",
                
          },
          :flavour => {
            
            :de_DE => "Um Einheiten zu bewegen, müssen sie aus der Garnison in eine Armee verschoben werden.",
  
            :en_US => "You can't move units that are in the garrison. To move units, you first have to relocate them from the garrison into an army.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Jede Armee belegt einen Kommandopunkt.",
  
            :en_US => "Every Army occupies a command point.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_settlement_button1',
              },

            ],
  
          },

          :rewards => {
            
            :unit_rewards => [

              {
                :unit => :unit_warrior,
                :amount => 10,
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

          :uimarker => ['mark_map', 'mark_select_own_home_settlement', 'mark_create_army', 'mark_create_army_dialog_flow', ],

          :place_npcs => 1,         

        },              #   END OF quest_army_create
        {               #   quest_npc_battle
          :id                => 9,
          :symbolic_id       => :quest_npc_battle,
  
          :type              => :epic,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "First battle",
  
            :de_DE => "Der erste Kampf",
                
          },
          :task => {
            
            :en_US => "Beat a pack of Neanderthals in your region.",
  
            :de_DE => "Besiege eine Gruppe Neandertaler in deiner Region.",
                
          },
          :flavour => {
            
            :de_DE => "Halbgott, die wilden Neandertaler benötigen dringend eine Abreibung!",
  
            :en_US => "Those neanderthals sure are cruising for a bruising. ",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Im Kampf sammelst du wichtige Erfahrung.",
  
            :en_US => "Your armies gather experience through fighting.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_army_create',
              },

            ],
  
          },

          :rewards => {
            
            :unit_rewards => [

              {
                :unit => :unit_warrior,
                :amount => 10,
              },

            ],

            :action_point_reward => true,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 1,
            },

          },          

          :uimarker => ['mark_map', 'mark_select_own_army', 'mark_select_other_army', 'mark_attack_button', ],

        },              #   END OF quest_npc_battle
        {               #   quest_army_move
          :id                => 10,
          :symbolic_id       => :quest_army_move,
  
          :type              => :epic,
  
          :advisor           => :warrior,
          :hide_start_dialog => true,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Army movement",
  
            :de_DE => "Armeebewegung",
                
          },
          :task => {
            
            :en_US => "Send your army to a different location.",
  
            :de_DE => "Sende deine Armee an einen anderen Ort.",
                
          },
          :flavour => {
            
            :de_DE => "Eine Armee kann mehr als nur herumstehen. Sie ist dazu da die Feinde des Stammes zu vernichten.",
  
            :en_US => "An army can do more than just stand around, you know. It´s there to destroy the enemies of the tribe!",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Jeder kann deine Bewegungen beobachten!",
  
            :en_US => "Everyone can watch your troop movement!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_npc_battle',
              },

            ],
  
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

            ],

            :action_point_reward => true,

          },          

          :reward_tests => {
            
            :movement_test => {},

          },          

          :uimarker => ['mark_map', 'mark_select_own_army', 'mark_move_own_army', ],

          :message => {
            
            :en => {
              :subject => 'Moving and battle',
              :body => "
      <p>The World Map is where the real action happens in Wack-a-Doo. The game is focused on battling your enemies and conquering their lands, so to be successful you have to build up your settlement and recruit units.</p>
      <p></p>
      <p>There are two ways to gain additional settlements. You can found them by moving an army with a little chief to an empty field on the map and then hitting the Found button. Alternatively, you can conquer your enemies' camps using your armies. You can also conquer fortresses and take control of the area.</p>
      <p></p>
    ",
            },

            :de => {
              :subject => 'Bewegen und Kämpfen',
              :body => "
      <p>Die richtige Action in Wack-A-Doo findet auf der Weltkarte statt. Wack-A-Doo ist ein Strategiespiel in dem der Aufbau der Siedlung der Rekrutierung von Einheiten und dem Aufstellen von Armeen dient.</p>
      <p></p>
      <p>Wichtige Hilfestellungen erhälst Du hier:</p>
      <p>- Rekrutierung von Einheiten und Aufstellen von Armeen:<a href='https://ios.wack-a-doo.com/de/encyclopedia/create_army' target='blank'>Armee aufstellen</a></p>
      <p>- Armee Bewegen:<a href='https://ios.wack-a-doo.com/de/encyclopedia/move_army' target='blank'>Armee bewegen</a></p>
      <p>- Kämpfe:<a href='https://ios.wack-a-doo.com/de/encyclopedia/battle' target='blank'>Kämpfen</a></p>
      <p></p>
      <p>Weitere Siedlungen kannst Du auf zwei Arten erhalten.</p>
      <p>Lagerstätten kannst Du mit Hilfe eines Kleinen Häuptlings gründen. Bestehenden Lagerstätten und Festungen kannst Du auch von anderen Spielern klauen.</p>
      <p>Weitere Info's erhälst Du hier:<a href='https://ios.wack-a-doo.com/de/encyclopedia/settlement' target='blank'>Zweite Siedlung</a></p>
      <p></p>
      <p>In Wack-A-Doo gibt es mit Nahkämpfern, Fernkämpfern und Berittenen Einheiten drei verschiedene Einheiten-Typen zur Verfügung. Zu Beginn stehen Dir nur Nahkämpfer zur Verfügung, doch im späteren Spielverlauf kannst Du auch Fernkämpfer und Berittene Einheiten rekrutieren.</p>
    ",
            },

          },          

        },              #   END OF quest_army_move
        {               #   quest_settlement_button2
          :id                => 11,
          :symbolic_id       => :quest_settlement_button2,
  
          :type              => :epic,
  
          :advisor           => :girl,
          :hide_start_dialog => true,
  
          :tutorial          => true,
          :tutorial_end_quest => true,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Back to the settlement",
  
            :de_DE => "Zurück in die Siedlung",
                
          },
          :task => {
            
            :en_US => "Get your selfe back to your settlement.",
  
            :de_DE => "Begib dich zurück in deine Siedlung.",
                
          },
          :flavour => {
            
            :de_DE => "Du findest Deine Siedlung nicht mehr? Das ist ganz einfach, ich erklär's Dir. Dann kannst Du es versuchen.",
  
            :en_US => "Can't find your settlement? It's quite easy, if you'll let me explain.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hurra! Drücke der Steinzeit deinen Stempel auf!",
  
            :en_US => "Yeah! Put your stamp on the Stone Age!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_army_move',
              },

            ],
  
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

            ],

            :action_point_reward => true,

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_settlement_button2',
            },

          },          

          :uimarker => ['mark_home_settlement', ],

        },              #   END OF quest_settlement_button2
        {               #   epic_ressources
          :id                => 12,
          :symbolic_id       => :epic_ressources,
  
          :type              => :epic,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Ressources",
  
            :de_DE => "Stein und Holz",
                
          },
          :task => {
            
            :en_US => "Build a quarry and a logger for improved ressource production.",
  
            :de_DE => "Errichte Steinbruch und Holzfäller für eine verbesserte Rohstoffproduktion",
                
          },
          :flavour => {
            
            :de_DE => "Stein und Holz benötigen wir für jeden Ausbau.",
  
            :en_US => "We need stone and wood for every upgrade.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Sehr gut! Daraus lässt sich was machen.",
  
            :en_US => "Well done! This might work as a base.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :subquests => [13, 14, 15, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_settlement_button2',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 750,
              },

              {
                :resource => :resource_wood,
                :amount => 750,
              },

              {
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

          },          

          :reward_tests => {
            
          },          

          :place_npcs => 10,         

        },              #   END OF epic_ressources
        {               #   quest_build_chiefcottagelvl4
          :id                => 13,
          :symbolic_id       => :quest_build_chiefcottagelvl4,
  
          :type              => :sub,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chief's hut",
  
            :de_DE => "Chefhütte ausbauen",
                
          },
          :task => {
            
            :en_US => "Improve your ressource production by upgrading your quarry and logger.",
  
            :de_DE => "Verbessere Deine Rohstoffproduktion durch den Ausbau von Steinbruch und Holzfäller.",
                
          },
          :flavour => {
            
            :de_DE => "Je mehr Rohstoffe desto mehr von allem.",
  
            :en_US => "The more ressources the more of everything.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Du solltest deine Rohstoffproduktion regelmäßig ausbauen.",
  
            :en_US => "You should upgrade your ressource production continuously.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
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

          :uimarker => ['mark_home_settlement', 'mark_upgradable_building', 'mark_upgrade_button', ],

        },              #   END OF quest_build_chiefcottagelvl4
        {               #   quest_build_quarry
          :id                => 14,
          :symbolic_id       => :quest_build_quarry,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Quarry",
  
            :de_DE => "Steinbruch errichten",
                
          },
          :task => {
            
            :en_US => "Build a quarry.",
  
            :de_DE => "Baue einen Steinbruch.",
                
          },
          :flavour => {
            
            :de_DE => "Hey cool, Du kannst Steinbrüche bauen.",
  
            :en_US => "Cool - you can now build quarries.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "So viel Stein, wie toll.",
  
            :en_US => "Wow – that's a lot of stone. Fantastic!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_quarry',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_free_construction_slot', 'mark_building_option', ],

        },              #   END OF quest_build_quarry
        {               #   quest_build_logger
          :id                => 15,
          :symbolic_id       => :quest_build_logger,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => true,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Logger",
  
            :de_DE => "Holzfäller errichten",
                
          },
          :task => {
            
            :en_US => "Build a Logger.",
  
            :de_DE => "Baue einen Holzfäller.",
                
          },
          :flavour => {
            
            :de_DE => "Der Chef sagt immer: 'Ein Brett in Ehren kann niemand verwehren!'.",
  
            :en_US => "If you want to increase production, you'll need to build more quarries and logging camps and then upgrade them.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na, das nenne ich mal Holz vor der Hütte!",
  
            :en_US => "Wow – look at your wood production. That's massive! ",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_logger',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_free_construction_slot', 'mark_building_option', ],

        },              #   END OF quest_build_logger
        {               #   epic__more_ressources
          :id                => 16,
          :symbolic_id       => :epic__more_ressources,
  
          :type              => :epic,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "More Ressources",
  
            :de_DE => "Die Industrie ankurbeln",
                
          },
          :task => {
            
            :en_US => "Improve your ressource production by upgrading your quarry and logger.",
  
            :de_DE => "Verbessere Deine Rohstoffproduktion durch den Ausbau von Steinbruch und Holzfäller.",
                
          },
          :flavour => {
            
            :de_DE => "Je mehr Rohstoffe desto mehr von allem.",
  
            :en_US => "The more ressources the more of everything.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Du solltest deine Rohstoffproduktion regelmäßig ausbauen.",
  
            :en_US => "You should upgrade your ressource production continuously.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :subquests => [17, 18, 19, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_ressources',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 600,
              },

              {
                :resource => :resource_wood,
                :amount => 600,
              },

            ],

            :production_bonus_rewards => [
              
              {
                :resource    => :resource_wood,
                :duration    => 259200,
                :bonus       => 0.3,
              },

              {
                :resource    => :resource_stone,
                :duration    => 259200,
                :bonus       => 0.3,
              },

            ],

          },          

          :reward_tests => {
            
          },          

          :place_npcs => 10,         

        },              #   END OF epic__more_ressources
        {               #   quest_gatherer_lvl3
          :id                => 17,
          :symbolic_id       => :quest_gatherer_lvl3,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Gatherer Level 3",
  
            :de_DE => "Sammler ausbauen",
                
          },
          :task => {
            
            :en_US => "Give an order to a Level 3 Hunter Gatherer.",
  
            :de_DE => "Baue den Sammler auf Level 3 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Willkommen Halbgott. Schau Dir Deine Siedlung an, ist sie nicht wundervoll?",
  
            :en_US => "Welcome Demigod! Look at your settlement – isn't it great? A bit empty, though.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hey, der erste Jäger und Sammler ist eingezogen. So sieht es doch schon viel besser aus, findest Du nicht?",
  
            :en_US => "Hey – that looks much better, don't you think? ",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 3,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_gatherer_lvl3
        {               #   quest_build_quarry_lvl3
          :id                => 18,
          :symbolic_id       => :quest_build_quarry_lvl3,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Quarry Level 3",
  
            :de_DE => "Steinbruch ausbauen",
                
          },
          :task => {
            
            :en_US => "Build a quarry.",
  
            :de_DE => "Baue den Steinbruch auf Level 3 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Hey cool, Du kannst Steinbrüche bauen.",
  
            :en_US => "Cool - you can now build quarries.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "So viel Stein, wie toll.",
  
            :en_US => "Wow – that's a lot of stone. Fantastic!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_quarry',

                :min_level => 3,

                :min_count => 1,

              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_free_construction_slot', 'mark_building_option', ],

        },              #   END OF quest_build_quarry_lvl3
        {               #   quest_build_logger_lvl3
          :id                => 19,
          :symbolic_id       => :quest_build_logger_lvl3,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => true,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Logger",
  
            :de_DE => "Holzfäller ausbauen",
                
          },
          :task => {
            
            :en_US => "Build a logger.",
  
            :de_DE => "Baue den Holzfäller auf Level 3 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Der Chef sagt immer: 'Ein Brett in Ehren kann niemand verwehren!'.",
  
            :en_US => "If you want to increase production, you'll need to build more quarries and logging camps and then upgrade them.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na, das nenne ich mal Holz vor der Hütte!",
  
            :en_US => "Wow – look at your wood production. That's massive! ",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_logger',

                :min_level => 3,

                :min_count => 1,

              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_free_construction_slot', 'mark_building_option', ],

        },              #   END OF quest_build_logger_lvl3
        {               #   epic_alliance
          :id                => 20,
          :symbolic_id       => :epic_alliance,
  
          :type              => :epic,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Alliance",
  
            :de_DE => "Mitglied einer Allianz",
                
          },
          :task => {
            
            :en_US => "Join an alliance. Together you will be much stronger.",
  
            :de_DE => "Werde Teil einer Allianz. Gemeinsam seid ihr viel stärker.",
                
          },
          :flavour => {
            
            :de_DE => "Auf zur Weltherrschaft!",
  
            :en_US => "To the global dominance.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Im Allianzmenü erhälst Du Informationen über die Allianz und Deine Mitstreiter.",
  
            :en_US => "In the alliance menu you receive information about the alliance and your companions.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :subquests => [21, 22, 23, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic__more_ressources',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 600,
              },

              {
                :resource => :resource_wood,
                :amount => 600,
              },

              {
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_warrior,
                :amount => 20,
              },

            ],

          },          

          :reward_tests => {
            
            :alliance_test => {},

          },          

        },              #   END OF epic_alliance
        {               #   quest_build_chiefcottagelvl5
          :id                => 21,
          :symbolic_id       => :quest_build_chiefcottagelvl5,
  
          :type              => :sub,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chief's hut",
  
            :de_DE => "Chefhütte Level 5",
                
          },
          :task => {
            
            :en_US => "Upgrade Chieftain’s Hut",
  
            :de_DE => "Chefhütte ausbauen.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Siedlung kommt ganz schön voran. Aber Du musst jetzt die Chefhütte ausbauen um weiterzukommen.",
  
            :en_US => "Your settlement is coming along nicely, but you're going to have to upgrade the chief's hut if you want to make some more progress.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll. Wieder ein paar Bauplätze mehr. Und eine kleine Hütte kannst Du jetzt auch bauen.",
  
            :en_US => "Great! There are now some more building slots available and you can build a small hut.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
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

          :uimarker => ['mark_home_settlement', 'mark_upgradable_building', 'mark_upgrade_button', ],

        },              #   END OF quest_build_chiefcottagelvl5
        {               #   quest_build_campfire
          :id                => 22,
          :symbolic_id       => :quest_build_campfire,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Campfire",
  
            :de_DE => "Lagerfeuer errichten",
                
          },
          :task => {
            
            :en_US => "Build a campfire.",
  
            :de_DE => "Wärme Dich am Lagerfeuer.",
                
          },
          :flavour => {
            
            :de_DE => "An Lagerfeuern treffen sich die Diplomaten, tauschen Nachrichten aus und schmieden Allianzen. Wäre doch schön, so etwas zu haben, oder?",
  
            :en_US => "Diplomats meet around the campfire to swap messages and forge alliances. It would be great to have someone like that, don't you think?
  ",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ach, wie das Feuer knistert. So schön warm.",
  
            :en_US => "Oh, listen to the fire crackling! Lovely warm flames!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
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

          :uimarker => ['mark_home_settlement', 'mark_free_construction_slot', 'mark_building_option', ],

          :message => {
            
            :en => {
              :subject => 'Alliances',
              :body => "<p>Alliances are an important part of Wack-A-Doo.<p/>
      <p>If you look around and contact players and alliances near you, you should be able to find a nice place to join. In order to join an alliance you have to enter its tag and password in your campfire.</p>
      <p/>
      <p>The advantages of an alliance are:</p>
      <p>- access to alliance chat</p>
      <p>- increased movement speed across the territories controlled by your alliance</p>
      <p>- ability to work together to defend your alliance fortresses </p>
      <p>- possibility of becoming involved in the alliance rankings</p>
      <p>- ability to win the round</p>
      <p/>
      <p>You can also found an alliance of your own once you upgrade your campfire to Level 2.</p>
    ",
            },

            :de => {
              :subject => 'Allianz',
              :body => "<p>In Wack-A-Doo steht die Allianz als Zusammenschluss von Einzelspielern im Vordergrund<p/>
      <p>Schaue Dich in Deiner Umgebung um und schreibe die Spieler in Deiner direkten Nachbarschaft an. Sicher findest Du einen netten Kontakt und kannst in einer Allianz unterkommen. Zum Beitreten in eine Allianz benötigst Du das Passwort Deiner Wunschallianz zur Eingabe im Lagerfeuer.</p>
      <p/>
      <p>Vorteile einer Allianz sind:</p>
      <p>- Ein eigener Allianz-Chat</p>
      <p>- Erhöhte Geschwindigkeit aller Bewegungen im Territorium der Allianz</p>
      <p>- Gemeinsames Verteidigen der Festungen der Allianz</p>
      <p>- Teilnahme am Allianz-Ranking</p>
      <p>- Teilnahme an den Siegbedingungen zum Gewinn der Runde</p>
      <p/>
      <p>Du kannst auch eine eigene Allianz mit Lagerfeuer Level 2 gründen, aber der Beitritt in eine bestehende Allianz ist vorzuziehen.</p>
      <ul>
      <li><a href='https://ios.wack-a-doo.com/de/encyclopedia/game_mechanism' target='_blank'>Spielprinzip</a></li>
      <li><a href='https://ios.wack-a-doo.com/de/encyclopedia/faq' target='_blank'>FAQ</a></li>
      </ul>",
            },

          },          

        },              #   END OF quest_build_campfire
        {               #   quest_alliance
          :id                => 23,
          :symbolic_id       => :quest_alliance,
  
          :type              => :sub,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Alliance",
  
            :de_DE => "Allianz",
                
          },
          :task => {
            
            :en_US => "Enter an alliance, or start your own alliance.",
  
            :de_DE => "Tritt einer Allianz bei oder gründe Deine eigene Allianz.",
                
          },
          :flavour => {
            
            :de_DE => "Werde Mitglied einer Allianz.",
  
            :en_US => "Fighting enemy armies with your own army is great, but it's even better if you have help from your friends or you can work together with other players. You should be in an alliance - allies are there to help each other.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hui, das ist aber eine tolle Allianz. Ich bin sicher, dass Ihr sehr weit kommen werdet.",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :alliance_test => {},

          },          

        },              #   END OF quest_alliance
        {               #   epic_storage
          :id                => 24,
          :symbolic_id       => :epic_storage,
  
          :type              => :epic,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Storage",
  
            :de_DE => "Lager und Handel",
                
          },
          :task => {
            
            :en_US => "Improve your storage and trade with other Chiefs.",
  
            :de_DE => "Erhöhe die Lagerkapazität und handel mit anderen Häuptlingen.",
                
          },
          :flavour => {
            
            :de_DE => "Den Handel sollten wir nicht nur der Amazone überlassen.",
  
            :en_US => "We shouldn’t leave the trading only in the Amazon’s discretion.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Jede Handelsbewegung dauert eine Stunde.",
  
            :en_US => "Every trade movement takes one hour.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :subquests => [25, 26, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_alliance',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 8000,
              },

              {
                :resource => :resource_wood,
                :amount => 8000,
              },

              {
                :resource => :resource_cash,
                :amount => 3,
              },

            ],

          },          

          :reward_tests => {
            
          },          

        },              #   END OF epic_storage
        {               #   quest_build_storage
          :id                => 25,
          :symbolic_id       => :quest_build_storage,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Raw materials store",
  
            :de_DE => "Rohstofflager errichten",
                
          },
          :task => {
            
            :en_US => "Build a raw materials store.",
  
            :de_DE => "Baue ein Rohstofflager.",
                
          },
          :flavour => {
            
            :de_DE => "Noch mag der Lagerplatz ausreichen, doch bald wirst Du mehr brauchen. Baue doch bitte ein Rohstofflager, damit wir mehr Platz haben.",
  
            :en_US => "Doesn't it bug you that your storage capacity is so limited? Why not build a raw materials store so we have more space!",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Endlich hab ich genug Platz für meine ganzen Schu - äh Sachen.",
  
            :en_US => "At last I have enough space for all my shoe…er, things!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
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

          :uimarker => ['mark_home_settlement', 'mark_free_construction_slot', 'mark_building_option', ],

        },              #   END OF quest_build_storage
        {               #   quest_first_trade
          :id                => 26,
          :symbolic_id       => :quest_first_trade,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Trade",
  
            :de_DE => "Treibe Handel",
                
          },
          :task => {
            
            :en_US => "Start a trade.",
  
            :de_DE => "Beginne Deinen ersten Handel.",
                
          },
          :flavour => {
            
            :de_DE => "Tausche Deine Rohstoffe.",
  
            :en_US => "Doesn't it bug you that your storage capacity is so limited? Why not build a raw materials store so we have more space!",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Endlich hab ich genug Platz für meine ganzen Schu - äh Sachen.",
  
            :en_US => "At last I have enough space for all my shoe…er, things!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :trading_carts_tests => [

              {
                :direction => 'outgoing',
                :min_carts_count => 1,
              },

            ],

          },          

        },              #   END OF quest_first_trade
        {               #   epic_cottage
          :id                => 27,
          :symbolic_id       => :epic_cottage,
  
          :type              => :epic,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Cottage",
  
            :de_DE => "Erhöhe die Baugeschwindigkeit",
                
          },
          :task => {
            
            :en_US => "Reduce the construction time for every building through building a Small Hut.",
  
            :de_DE => "Verringere die Bauzeit aller Gebäude durch den Bau von Kleinen Hütten.",
                
          },
          :flavour => {
            
            :de_DE => "Gut erholt arbeitet selbst der faulste Arbeiter schneller.",
  
            :en_US => "Even the lazied Worker works faster if he’s freshly regained.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Mehrere Kleine Hütten verkürzen die Bauzeit noch weiter.",
  
            :en_US => "More Small Huts will reduce the construction time even farer.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :subquests => [28, 29, 30, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_storage',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 750,
              },

              {
                :resource => :resource_wood,
                :amount => 750,
              },

            ],

            :construction_bonus_rewards => [
              
              {
                :duration  => 266400,
                :bonus     => 0.25,
              },

            ],

          },          

          :reward_tests => {
            
          },          

        },              #   END OF epic_cottage
        {               #   quest_build_chiefcottagelvl6
          :id                => 28,
          :symbolic_id       => :quest_build_chiefcottagelvl6,
  
          :type              => :sub,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chief's hut",
  
            :de_DE => "Chefhütte ausbauen",
                
          },
          :task => {
            
            :en_US => "Upgrade Chieftain’s Hut",
  
            :de_DE => "Verringere die Bauzeit aller Gebäude durch den Bau von Kleinen Hütten.",
                
          },
          :flavour => {
            
            :de_DE => "Gut erholt arbeitet selbst der faulste Arbeiter schneller.",
  
            :en_US => "Your settlement is coming along nicely, but you're going to have to upgrade the chief's hut if you want to make some more progress.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll. Wieder ein paar Bauplätze mehr. Und eine kleine Hütte kannst Du jetzt auch bauen.",
  
            :en_US => "Great! There are now some more building slots available and you can build a small hut.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :construction_queue_tests => [

              {
                :building => 'building_chief_cottage',
                :min_count => 1,
                :min_level => 6,
              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_upgradable_building', 'mark_upgrade_button', ],

        },              #   END OF quest_build_chiefcottagelvl6
        {               #   quest_finish_upgrade
          :id                => 29,
          :symbolic_id       => :quest_finish_upgrade,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Finish upgrade",
  
            :de_DE => "Ausbau abschließen",
                
          },
          :task => {
            
            :en_US => "Finish the upgrade of the chief's hut.",
  
            :de_DE => "Schließe den Ausbau sofort mit einer Kröte ab.",
                
          },
          :flavour => {
            
            :de_DE => "Mit ein paar Kröten lässt sich so einiges bewirken.",
  
            :en_US => "With a few golden frogs you can get quite a bit done.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ist es nicht toll, wie Deine Siedlung wächst? Ich habe sogar Chef dazu überreden können, Dir etwas von seinem Rohstoffberg abzugeben.",
  
            :en_US => "Isn't it great how much your settlement is growing? I've even managed to persuade the boss to give you something from his huge store of resources.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_chief_cottage',

                :min_level => 6,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_finish_upgrade
        {               #   quest_build_cottage
          :id                => 30,
          :symbolic_id       => :quest_build_cottage,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "The small huts",
  
            :de_DE => "Kleinen Hütte errichten",
                
          },
          :task => {
            
            :en_US => "Build a small hut.",
  
            :de_DE => "Baue eine Kleine Hütte.",
                
          },
          :flavour => {
            
            :de_DE => "Diese kleinen Hütten sind wirklich nützlich. Mehr Einwohner bedeuten auch mehr helfende Hände.",
  
            :en_US => "Did you know that you can give your workers two orders at the same time? They can only work on one of them, but they'll keep the other order in mind. Why don't you try it? The happier your workers are, the faster they'll build things for you.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut gemacht. Deine Arbeiter freuen sich und bauen schneller.",
  
            :en_US => "Well done! Your workers are happy and they're building things faster because of it.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
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

          :uimarker => ['mark_home_settlement', 'mark_free_construction_slot', 'mark_building_option', ],

        },              #   END OF quest_build_cottage
        {               #   epic_xp
          :id                => 31,
          :symbolic_id       => :epic_xp,
  
          :type              => :epic,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experience",
  
            :de_DE => "Erfahrung",
                
          },
          :task => {
            
            :en_US => "Collect valuable experience. The Training Cave is the first step.",
  
            :de_DE => "Sammel wertvolle Erfahrungen. Die Trainingshöhle ist ein erster Schritt.",
                
          },
          :flavour => {
            
            :de_DE => "Jeder Fortschritt benötigt ausreichend Erfahrung.",
  
            :en_US => "Every progress needs sufficient experience.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Erfahrung erhältst Du in der Trainingshöhle, für Ausbauten und vor allem für Kämpfe.",
  
            :en_US => "You will get experience in the Training Cave, for Upgrades and mainly for fighting.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :subquests => [32, 33, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_cottage',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 1500,
              },

              {
                :resource => :resource_wood,
                :amount => 1500,
              },

            ],

            :experience_reward => 4500,

            :experience_production_bonus_rewards => [
              
              {
                :duration  => 259200,
                :bonus     => 0.1,
              },

            ],

          },          

          :reward_tests => {
            
          },          

        },              #   END OF epic_xp
        {               #   quest_build_chiefcottagelvl7
          :id                => 32,
          :symbolic_id       => :quest_build_chiefcottagelvl7,
  
          :type              => :sub,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chief's hut",
  
            :de_DE => "Chefhütte ausbauen",
                
          },
          :task => {
            
            :en_US => "Upgrade Chieftain’s Hut",
  
            :de_DE => "erbessere die Chefhütte auf Level 7.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Siedlung kommt ganz schön voran. Aber Du musst jetzt die Chefhütte ausbauen um weiterzukommen.",
  
            :en_US => "Your settlement is coming along nicely, but you're going to have to upgrade the chief's hut if you want to make some more progress.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll. Wieder ein paar Bauplätze mehr. Und eine kleine Hütte kannst Du jetzt auch bauen.",
  
            :en_US => "Great! There are now some more building slots available and you can build a small hut.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_chief_cottage',

                :min_level => 7,

                :min_count => 1,

              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_upgradable_building', 'mark_upgrade_button', ],

        },              #   END OF quest_build_chiefcottagelvl7
        {               #   quest_build_training_cave
          :id                => 33,
          :symbolic_id       => :quest_build_training_cave,
  
          :type              => :sub,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Training cave",
  
            :de_DE => "Trainingshöhle errichten",
                
          },
          :task => {
            
            :en_US => "Build a training cave.",
  
            :de_DE => "Baue eine Trainingshöhle.",
                
          },
          :flavour => {
            
            :de_DE => "Hey Halbgott, sitz da nicht so faul rum. Du musst Deinen Armeen als Vorbild dienen, dafür solltest Du etwas trainieren.",
  
            :en_US => "Hey Demigod, don't get bored! You need to inspire your armies to be like you, so make sure you  use your training cave to exercise!",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ein - zwei, eins - zwei, keine Müdigkeit vortäuschen!",
  
            :en_US => "One and two, one and two! Come on, this is fun!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_training_cave',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_training_cave
        {               #   epic_fur
          :id                => 34,
          :symbolic_id       => :epic_fur,
  
          :type              => :epic,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Fur",
  
            :de_DE => "Fell",
                
          },
          :task => {
            
            :en_US => "Build a furrier to produce the worthwhile fur.",
  
            :de_DE => "Errichte einen Kürschner um das wertvolle Fell zu produzieren.",
                
          },
          :flavour => {
            
            :de_DE => "Fell - flauschig und warm.",
  
            :en_US => "Fur - fluffy and warm.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Fell wird vor allem für die Ausrüstung der Krieger benötigt.",
  
            :en_US => "Fur is mainly used to equip warriors.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :subquests => [35, 36, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_xp',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 10000,
              },

              {
                :resource => :resource_wood,
                :amount => 10000,
              },

              {
                :resource => :resource_fur,
                :amount => 10000,
              },

            ],

            :experience_reward => 250,

            :production_bonus_rewards => [
              
              {
                :resource    => :resource_fur,
                :duration    => 259200,
                :bonus       => 0.3,
              },

            ],

          },          

          :reward_tests => {
            
          },          

        },              #   END OF epic_fur
        {               #   quest_build_chiefcottagelvl8
          :id                => 35,
          :symbolic_id       => :quest_build_chiefcottagelvl8,
  
          :type              => :sub,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chief's hut",
  
            :de_DE => "Chefhütte ausbauen",
                
          },
          :task => {
            
            :en_US => "Upgrade Chieftain’s Hut",
  
            :de_DE => "Verbessere die Chefhütte auf Level 8.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Siedlung kommt ganz schön voran. Aber Du musst jetzt die Chefhütte ausbauen um weiterzukommen.",
  
            :en_US => "Your settlement is coming along nicely, but you're going to have to upgrade the chief's hut if you want to make some more progress.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll. Wieder ein paar Bauplätze mehr. Und eine kleine Hütte kannst Du jetzt auch bauen.",
  
            :en_US => "Great! There are now some more building slots available and you can build a small hut.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_chief_cottage',

                :min_level => 8,

                :min_count => 1,

              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_upgradable_building', 'mark_upgrade_button', ],

        },              #   END OF quest_build_chiefcottagelvl8
        {               #   quest_build_furrier
          :id                => 36,
          :symbolic_id       => :quest_build_furrier,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Furrier",
  
            :de_DE => "Kürschner errichten",
                
          },
          :task => {
            
            :en_US => "Build a furrier.",
  
            :de_DE => "Baue einen Kürschner.",
                
          },
          :flavour => {
            
            :de_DE => "Chef will die Felle für die Armee Rekrutierung, aber für mich fällt doch bestimmt auch was schönes ab, oder?",
  
            :en_US => "The chief wants an army, but I'd just like some nice new clothes.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Fell wird vor allem für den Aufbau einer schlagkräftigen Armee benötigt.",
  
            :en_US => "Nice! Now you can build a new army.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_furrier',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_furrier
        {               #   epic_firing_range
          :id                => 37,
          :symbolic_id       => :epic_firing_range,
  
          :type              => :epic,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Artillery",
  
            :de_DE => "Die Fernkämpfer",
                
          },
          :task => {
            
            :en_US => "Use your knowledge to train long-range-units.",
  
            :de_DE => "Nutze Dein Wissen zur Ausbildung von Fernkämpfern. ",
                
          },
          :flavour => {
            
            :de_DE => "Ein Wurf - ein Treffer. Fernkampf ist was feines.",
  
            :en_US => "One shot - one hit. I like long-range-fighting.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Die Ausbildung von Fernkämpfern wird durch verbesserte und zusätzliche Schießstände beschleunigt. ",
  
            :en_US => "The training of long-ranged-fighters will be shortened by building additional firing-ranges or upgrading them.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :subquests => [38, 39, 40, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_fur',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 5000,
              },

              {
                :resource => :resource_wood,
                :amount => 5000,
              },

              {
                :resource => :resource_fur,
                :amount => 2500,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_thrower,
                :amount => 30,
              },

            ],

            :experience_reward => 500,

          },          

          :reward_tests => {
            
          },          

        },              #   END OF epic_firing_range
        {               #   quest_build_chiefcottagelvl9
          :id                => 38,
          :symbolic_id       => :quest_build_chiefcottagelvl9,
  
          :type              => :sub,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chief's hut",
  
            :de_DE => "Chefhütte ausbauen",
                
          },
          :task => {
            
            :en_US => "Upgrade Chieftain’s Hut",
  
            :de_DE => "Verbessere die Chefhütte auf Level 9.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Siedlung kommt ganz schön voran. Aber Du musst jetzt die Chefhütte ausbauen um weiterzukommen.",
  
            :en_US => "Your settlement is coming along nicely, but you're going to have to upgrade the chief's hut if you want to make some more progress.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll. Wieder ein paar Bauplätze mehr. Und eine kleine Hütte kannst Du jetzt auch bauen.",
  
            :en_US => "Great! There are now some more building slots available and you can build a small hut.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_chief_cottage',

                :min_level => 9,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_chiefcottagelvl9
        {               #   quest_build_firing_range
          :id                => 39,
          :symbolic_id       => :quest_build_firing_range,
  
          :type              => :sub,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Firing_range",
  
            :de_DE => "Schießstand errichten",
                
          },
          :task => {
            
            :en_US => "Build a Firing range.",
  
            :de_DE => "Baue einen Schießstand.",
                
          },
          :flavour => {
            
            :de_DE => "Jetzt fehlen uns nur noch die berittenen Einheiten, um uns auch gegen die gegnerischen Fernkämpfer behaupten zu können.",
  
            :en_US => "We need a cavalry to defend ourselves against throwers.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Muhaha, I don't like the smell, but I've got admit… those riders know what they're doing.",
  
            :en_US => "Muhaha, I don´t like the smell, but the riders know thier business.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_firing_range',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_firing_range
        {               #   quest_recruit_thrower
          :id                => 40,
          :symbolic_id       => :quest_recruit_thrower,
  
          :type              => :sub,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Thrower",
  
            :de_DE => "Kieselsteinwerfer ausbilden",
                
          },
          :task => {
            
            :en_US => "Build a thrower.",
  
            :de_DE => "Bilde einen Kieselsteinwerfer aus.",
                
          },
          :flavour => {
            
            :de_DE => "Hmm? Keine Einheiten weit und breit. Da sollte sich mal jemand drum kümmern, sonst wird diese Siedlung demnächst niedergebrannt.",
  
            :en_US => "What? Not a unit to be seen anywhere. Someone should pay attention to that or the settlement will soon be burned to the ground.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Aller Anfang ist schwer, aber da musst Du noch dran arbeiten. Fürs Erste stell ich Dir ein paar meiner Krieger zur Verfügung.",
  
            :en_US => "Everything's always difficult at first. You just have to stick with it. For now, I'll let you have some of my warriors.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :training_queue_tests => [

              {
                :unit => 'unit_thrower',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_recruit_thrower
        {               #   epic_coppersmelter
          :id                => 41,
          :symbolic_id       => :epic_coppersmelter,
  
          :type              => :epic,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Copper age",
  
            :de_DE => "Kupferzeit",
                
          },
          :task => {
            
            :en_US => "The production of cupper means a great leap forward in development.",
  
            :de_DE => "Die Herstellung von Kupfer bedeutet einen großen Sprung in der Entwicklung.",
                
          },
          :flavour => {
            
            :de_DE => "Mit Kupfer können wir alles besser machen.",
  
            :en_US => "With copper we can improve everything.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Der Ausbau der Kupferschmelze ermöglicht die Verbesserung von Gebäuden sowie den Bau von neuartigen Gebäude.",
  
            :en_US => "Upgrading the Copper Smelter enables upgrades for existing buildings and unlocks even new buildings.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :subquests => [42, 43, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_firing_range',
              },

            ],
  
          },

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
                :amount => 4000,
              },

              {
                :resource => :resource_cash,
                :amount => 3,
              },

            ],

            :experience_reward => 1000,

          },          

          :reward_tests => {
            
          },          

        },              #   END OF epic_coppersmelter
        {               #   quest_build_chiefcottagelvl10
          :id                => 42,
          :symbolic_id       => :quest_build_chiefcottagelvl10,
  
          :type              => :sub,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chief's hut",
  
            :de_DE => "Chefhütte Level 10",
                
          },
          :task => {
            
            :en_US => "Upgrade Chieftain’s Hut",
  
            :de_DE => "Chefhütte ausbauen.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Siedlung kommt ganz schön voran. Aber Du musst jetzt die Chefhütte ausbauen um weiterzukommen.",
  
            :en_US => "Your settlement is coming along nicely, but you're going to have to upgrade the chief's hut if you want to make some more progress.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll. Wieder ein paar Bauplätze mehr. Und eine kleine Hütte kannst Du jetzt auch bauen.",
  
            :en_US => "Great! There are now some more building slots available and you can build a small hut.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_chief_cottage',

                :min_level => 10,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_chiefcottagelvl10
        {               #   quest_build_copper_smelter
          :id                => 43,
          :symbolic_id       => :quest_build_copper_smelter,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Copper smelter",
  
            :de_DE => "Kupferschmelze",
                
          },
          :task => {
            
            :en_US => "Upgrade your Copper Smleter",
  
            :de_DE => "Kupferschmelze ausbauen",
                
          },
          :flavour => {
            
            :de_DE => "In der Kupferzeit stehen Dir neue Gebäude und verbesserte Versionen bereits bekannter Gebäude zur Verfügung.",
  
            :en_US => "In the Copper Age, you can create new buildings as well as improved versions of the buildings you already know.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Wow, eine neues Zeitalter! So viele Möglichkeiten.",
  
            :en_US => "Wow, a new age! So many opportunities! ",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_copper_smelter',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_copper_smelter
        {               #   epic_cavalry
          :id                => 44,
          :symbolic_id       => :epic_cavalry,
  
          :type              => :epic,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Cavalry",
  
            :de_DE => "Die Reiter",
                
          },
          :task => {
            
            :en_US => "Recruit your first cavalry.",
  
            :de_DE => "Rekrutiere Deine ersten berittenen Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Feindliche Armeen mit Deinen eigenen Armeen zu bekämpfen, ist ja nett. Aber viel besser wäre es doch, wenn ihr zusammenarbeiten würdet oder wenn Deine Freunde Dir helfen würden.",
  
            :en_US => "Fighting enemy armies with your own army is great, but it's even better if you have help from your friends or you can work together with other players. You should be in an alliance - allies are there to help each other.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Die Reiter sind schneller und können die Nahkämpfer umgehen um die Fernkämpfer direkt anzugreifen.",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :subquests => [45, 46, 47, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_firing_range',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 5000,
              },

              {
                :resource => :resource_wood,
                :amount => 5000,
              },

              {
                :resource => :resource_fur,
                :amount => 3000,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_light_cavalry,
                :amount => 30,
              },

            ],

            :experience_reward => 1500,

          },          

          :reward_tests => {
            
          },          

        },              #   END OF epic_cavalry
        {               #   quest_build_copper_smelter_lvl5
          :id                => 45,
          :symbolic_id       => :quest_build_copper_smelter_lvl5,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Copper smelter level 5",
  
            :de_DE => "Kupferschmelze Level 5",
                
          },
          :task => {
            
            :en_US => "Build a copper smelter levle 5.",
  
            :de_DE => "Verbessere die Kupferschmelze auf Level 5.",
                
          },
          :flavour => {
            
            :de_DE => "In der Kupferzeit stehen Dir neue Gebäude und verbesserte Versionen bereits bekannter Gebäude zur Verfügung.",
  
            :en_US => "In the Copper Age, you can create new buildings as well as improved versions of the buildings you already know.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Wow, eine neues Zeitalter! So viele Möglichkeiten.",
  
            :en_US => "Wow, a new age! So many opportunities! ",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_copper_smelter',

                :min_level => 5,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_copper_smelter_lvl5
        {               #   quest_build_stid
          :id                => 46,
          :symbolic_id       => :quest_build_stid,
  
          :type              => :sub,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Stud",
  
            :de_DE => "Der Stall",
                
          },
          :task => {
            
            :en_US => "Build a smelly barn.",
  
            :de_DE => "Baue einen Stall.",
                
          },
          :flavour => {
            
            :de_DE => "Jetzt fehlen uns nur noch die berittenen Einheiten, um uns auch gegen die gegnerischen Fernkämpfer behaupten zu können.",
  
            :en_US => "We need a cavalry to defend ourselves against throwers.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Muhaha, I don't like the smell, but I've got admit… those riders know what they're doing.",
  
            :en_US => "Muhaha, I don´t like the smell, but the riders know thier business.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_stud',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_stid
        {               #   quest_light_cavalry
          :id                => 47,
          :symbolic_id       => :quest_light_cavalry,
  
          :type              => :sub,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Ostrich rider",
  
            :de_DE => "Der Straußenreiter",
                
          },
          :task => {
            
            :en_US => "Recruit a ostrich rider.",
  
            :de_DE => "Rekrutiere einen Straußenreiter.",
                
          },
          :flavour => {
            
            :de_DE => "Hmm? Keine Einheiten weit und breit. Da sollte sich mal jemand drum kümmern, sonst wird diese Siedlung demnächst niedergebrannt.",
  
            :en_US => "What? Not a unit to be seen anywhere. Someone should pay attention to that or the settlement will soon be burned to the ground.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Aller Anfang ist schwer, aber da musst Du noch dran arbeiten. Fürs Erste stell ich Dir ein paar meiner Krieger zur Verfügung.",
  
            :en_US => "Everything's always difficult at first. You just have to stick with it. For now, I'll let you have some of my warriors.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :training_queue_tests => [

              {
                :unit => 'unit_light_cavalry',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_light_cavalry
        {               #   epic_encampment
          :id                => 48,
          :symbolic_id       => :epic_encampment,
  
          :type              => :epic,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Encampment",
  
            :de_DE => "Lagerstätte gründen",
                
          },
          :task => {
            
            :en_US => "Found an Encampment as a further settlement to accelerate your progression.",
  
            :de_DE => "Gründe mit der Lagerstätte eine weitere Siedlung um Deinen Fortschritt zu beschleunigen.",
                
          },
          :flavour => {
            
            :de_DE => "Eine weitere  Siedlung - mehr geht kaum.",
  
            :en_US => "An additional settlement - more is nearly impossible.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Die Siedlungspunkte begrenzen die Anzahl deiner Siedlungen. Sammel Erfahrung um deinen Einfluss weiter zu erhöhen.",
  
            :en_US => "The Settlement Points restrict your number of settlements. Collect experience to raise your clout.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :subquests => [49, 50, 51, ],

          :triggers => {
            
            :mundane_rank_trigger => 2,
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 2000,
              },

              {
                :resource => :resource_wood,
                :amount => 2000,
              },

              {
                :resource => :resource_fur,
                :amount => 1000,
              },

              {
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

            :experience_reward => 1000,

          },          

          :reward_tests => {
            
          },          

        },              #   END OF epic_encampment
        {               #   quest_build_campfirelvl10
          :id                => 49,
          :symbolic_id       => :quest_build_campfirelvl10,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Campfire Level 10",
  
            :de_DE => "Lagerfeuer ausbauen",
                
          },
          :task => {
            
            :en_US => "Upgrade your Campfire",
  
            :de_DE => "Verbessere das Lagerfeuer auf Level 10.",
                
          },
          :flavour => {
            
            :de_DE => "An Lagerfeuern treffen sich die Diplomaten, tauschen Nachrichten aus und schmieden Allianzen. Wäre doch schön, so etwas zu haben, oder?",
  
            :en_US => "Diplomats meet around the campfire to swap messages and forge alliances. It would be great to have someone like that, don't you think?
  ",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ach, wie das Feuer knistert. So schön warm.",
  
            :en_US => "Oh, listen to the fire crackling! Lovely warm flames!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_campfire',

                :min_level => 10,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_campfirelvl10
        {               #   quest_little_chief
          :id                => 50,
          :symbolic_id       => :quest_little_chief,
  
          :type              => :sub,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Little Chief",
  
            :de_DE => "Der Kleine Chef",
                
          },
          :task => {
            
            :en_US => "Train a Little Chief",
  
            :de_DE => "Bilde einen Kleinen Häuptling aus.",
                
          },
          :flavour => {
            
            :de_DE => "Hmm? Keine Einheiten weit und breit. Da sollte sich mal jemand drum kümmern, sonst wird diese Siedlung demnächst niedergebrannt.",
  
            :en_US => "What? Not a unit to be seen anywhere. Someone should pay attention to that or the settlement will soon be burned to the ground.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Aller Anfang ist schwer, aber da musst Du noch dran arbeiten. Fürs Erste stell ich Dir ein paar meiner Krieger zur Verfügung.",
  
            :en_US => "Everything's always difficult at first. You just have to stick with it. For now, I'll let you have some of my warriors.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
          },          

          :reward_tests => {
            
            :training_queue_tests => [

              {
                :unit => 'unit_little_chief',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_little_chief
        {               #   quest_outpost
          :id                => 51,
          :symbolic_id       => :quest_outpost,
  
          :type              => :sub,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Founding an encampment",
  
            :de_DE => "Lagerstätte gründen",
                
          },
          :task => {
            
            :en_US => "Start an encampment.",
  
            :de_DE => "Gründe eine Lagerstätte.",
                
          },
          :flavour => {
            
            :de_DE => "Wie? Nur eine Siedlung? Du musst Dich mehr ausbreiten. Gründe eine Lagerstätte, aber flott! Dann findet sich bei mir vielleicht auch etwas, das ich Dir überlassen kann.",
  
            :en_US => "What? Only one settlement? You've got to spread out a bit. Start another settlement, and quick! Then I might find something lying around that I could let you have.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Du hast eine Lagerstätte gegründet? Brauchst Du immer so lange für einfache Aufgaben? Hier, nimm die Rohstoffe und geh mir aus den Augen.",
  
            :en_US => "You've started an encampment? Do you always take this long to complete a simple task? Here – take the raw materials and get lost.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :rewards => {
            
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
        {               #   quest_profile
          :id                => 52,
          :symbolic_id       => :quest_profile,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Your Name",
  
            :de_DE => "Dein Name",
                
          },
          :task => {
            
            :en_US => "Change your name.",
  
            :de_DE => "Im Profil kannst Du Deinen Namen und Dein Avatar ändern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, wie heißt Du eigentlich?",
  
            :en_US => "Hey, what's your name?",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Danke. Wir werden noch viel Spaß miteinander haben.",
  
            :en_US => "Thanks. I think we're going to have loads of fun together!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic__more_ressources',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 1,
              },

            ],

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_profile',
            },

          },          

          :uimarker => ['mark_profile', 'mark_name_change', ],

        },              #   END OF quest_profile
        {               #   quest_build_2quarry_lvl4
          :id                => 53,
          :symbolic_id       => :quest_build_2quarry_lvl4,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "More Quarries",
  
            :de_DE => "Mehr Steinbrüche",
                
          },
          :task => {
            
            :en_US => "Built two quarries up to level 4.",
  
            :de_DE => "Baue zwei Steinbrüche bis Level 4 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Stein auf Stein, die Hütten werden bald fertig sein.",
  
            :en_US => "Cool - you can now build quarries.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Steigere Deine Steinproduktion durch weitere und verbesserte Steinbrüche.",
  
            :en_US => "Quarries are very effective. Build more quarries!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_storage',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 407,
              },

              {
                :resource => :resource_wood,
                :amount => 203,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_quarry',

                :min_level => 4,

                :min_count => 2,

              },

            ],

          },          

        },              #   END OF quest_build_2quarry_lvl4
        {               #   quest_build_2logger_lvl4
          :id                => 54,
          :symbolic_id       => :quest_build_2logger_lvl4,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "More logger",
  
            :de_DE => "Mehr Holzfäller",
                
          },
          :task => {
            
            :en_US => "Built two logger up to level 4.",
  
            :de_DE => "Baue zwei Holzfäller bis Level 4 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Der Chef sagt immer: 'Ein Brett in Ehren kann niemand verwehren!'.",
  
            :en_US => "If you want to increase production, you'll need to build more quarries and logging camps and then upgrade them.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na, das nenne ich mal Holz vor der Hütte!",
  
            :en_US => "Wow – look at your wood production. That's massive!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_storage',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 203,
              },

              {
                :resource => :resource_wood,
                :amount => 407,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_logger',

                :min_level => 4,

                :min_count => 2,

              },

            ],

          },          

        },              #   END OF quest_build_2logger_lvl4
        {               #   quest_gatherer_lvl10
          :id                => 55,
          :symbolic_id       => :quest_gatherer_lvl10,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Gatherer Level 10",
  
            :de_DE => "Maximallevel Sammler",
                
          },
          :task => {
            
            :en_US => "Give an order to a Level 10 Hunter Gatherer.",
  
            :de_DE => "Verbessere Deinen Sammler auf das Maximallevel 10.",
                
          },
          :flavour => {
            
            :de_DE => "Willkommen Halbgott. Schau Dir Deine Siedlung an, ist sie nicht wundervoll?",
  
            :en_US => "Welcome Demigod! Look at your settlement – isn't it great? A bit empty, though.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Der Sammler ist nicht so effektiv wie Steinbruch und Holzfäller.",
  
            :en_US => "Hey – that looks much better, don't you think?",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_build_2quarry_lvl4',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 2000,
              },

              {
                :resource => :resource_wood,
                :amount => 2000,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 10,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_gatherer_lvl10
        {               #   quest_build_quarry_lvl10
          :id                => 56,
          :symbolic_id       => :quest_build_quarry_lvl10,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Quarry Level 10",
  
            :de_DE => "Maximallevel Steinbruch",
                
          },
          :task => {
            
            :en_US => "Build a quarry level 10.",
  
            :de_DE => "Baue einen Steinbruch bis Level 10.",
                
          },
          :flavour => {
            
            :de_DE => "Hey cool, Du kannst Steinbrüche bauen.",
  
            :en_US => "Cool - you can now build quarries.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Steigere Deine Steinproduktion durch weitere Steinbrüche.",
  
            :en_US => "Quarries are very effective. Build more quarries!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_build_2quarry_lvl4',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 5000,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_quarry',

                :min_level => 10,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_quarry_lvl10
        {               #   quest_build_logger_lvl10
          :id                => 57,
          :symbolic_id       => :quest_build_logger_lvl10,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Logger Level 10",
  
            :de_DE => "Maximallevel Holzfäller",
                
          },
          :task => {
            
            :en_US => "Build a logger level 10.",
  
            :de_DE => "Baue einen Holzfäller bis Level 10.",
                
          },
          :flavour => {
            
            :de_DE => "Aufpassen, die jungen Bäume nicht fällen.",
  
            :en_US => "If you want to increase production, you'll need to build more quarries and logging camps and then upgrade them.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Mehr Holzfäller sind immer eine gute Idee.",
  
            :en_US => "Wow – look at your wood production. That's massive! ",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_build_2quarry_lvl4',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_wood,
                :amount => 5000,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_logger',

                :min_level => 10,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_logger_lvl10
        {               #   quest_build_2furrierlvl4
          :id                => 58,
          :symbolic_id       => :quest_build_2furrierlvl4,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "More furrier",
  
            :de_DE => "Mehr Kürschner",
                
          },
          :task => {
            
            :en_US => "Build two furrier up to level 4.",
  
            :de_DE => "Baue zwei Kürschner bis Level 4.",
                
          },
          :flavour => {
            
            :de_DE => "Ich mag die Lendenschurze der Keulenkrieger.",
  
            :en_US => "We need much more fur.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Verbessere und baue weitere Kürschner.",
  
            :en_US => "Upgrade and build new furrier.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_fur',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_fur,
                :amount => 500,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_furrier',

                :min_level => 4,

                :min_count => 2,

              },

            ],

          },          

        },              #   END OF quest_build_2furrierlvl4
        {               #   quest_build_furrier_lvl10
          :id                => 59,
          :symbolic_id       => :quest_build_furrier_lvl10,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Furrier Level 10",
  
            :de_DE => "Maximallevel Kürschner",
                
          },
          :task => {
            
            :en_US => "Build a furrier level 10.",
  
            :de_DE => "Baue einen Kürschner bis Level 10.",
                
          },
          :flavour => {
            
            :de_DE => "Lendenschurze find ich klasse.",
  
            :en_US => "I like lionclothes.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Steigere die Fellproduktion durch den Bau weiterer Kürschner.",
  
            :en_US => "Raise your fur production by building more furrier.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_build_2furrierlvl4',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_fur,
                :amount => 2000,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_furrier',

                :min_level => 10,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_furrier_lvl10
        {               #   quest_resourcescore_1
          :id                => 60,
          :symbolic_id       => :quest_resourcescore_1,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Resource Production",
  
            :de_DE => "Rohstoffproduktion",
                
          },
          :task => {
            
            :en_US => "Increase the resource production of one settlement to 200 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 200 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Du zahlst Steuern? Warum?",
  
            :en_US => "Your pay taxes? Why!?",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Rohstoffe haben wir nie genug. Wir brauchen mehr!",
  
            :en_US => "We will never have enough recourses. We need more!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_build_furrier_lvl10',
              },

            ],
  
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
                :amount => 250,
              },

            ],

            :experience_reward => 50,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 200,
            },

          },          

        },              #   END OF quest_resourcescore_1
        {               #   quest_build_barrackslvl5
          :id                => 61,
          :symbolic_id       => :quest_build_barrackslvl5,
  
          :type              => :optional,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Improve Barracks",
  
            :de_DE => "Ausblidungsgelände verbessern",
                
          },
          :task => {
            
            :en_US => "Upgrade the training grounds to level 5.",
  
            :de_DE => "Verbessere das Ausbildungsgelände auf Level 5.",
                
          },
          :flavour => {
            
            :de_DE => "Die Ausbildung der Keulenkrieger geht auch schneller.",
  
            :en_US => "Training Warriors will be faster too.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Die Keulenkrieger sind vernünftige Einheiten. Mit Keulen und so.",
  
            :en_US => "The club warriors are reasonable units. With clubs and stuff.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_fur',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 1000,
              },

              {
                :resource => :resource_wood,
                :amount => 500,
              },

              {
                :resource => :resource_fur,
                :amount => 400,
              },

            ],

            :experience_reward => 200,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_barracks',

                :min_level => 5,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_barrackslvl5
        {               #   quest_recruit_clubber
          :id                => 62,
          :symbolic_id       => :quest_recruit_clubber,
  
          :type              => :optional,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Clubber",
  
            :de_DE => "Keulenkrieger",
                
          },
          :task => {
            
            :en_US => "Train a club warrior.",
  
            :de_DE => "Bilde einen Keulenkrieger aus.",
                
          },
          :flavour => {
            
            :de_DE => "Einfache Krieger sind nicht zu gebrauchen.",
  
            :en_US => "Simple warriors are not very useful.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Endlich vernüftige Keulen. Jetzt tut das Hauen wenigstens weh!",
  
            :en_US => "Finally decent clubs. Now chopping will hurt!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_build_barrackslvl5',
              },

            ],
  
          },

          :rewards => {
            
            :unit_rewards => [

              {
                :unit => :unit_clubber,
                :amount => 30,
              },

            ],

            :experience_reward => 300,

          },          

          :reward_tests => {
            
            :training_queue_tests => [

              {
                :unit => 'unit_clubber',
                :min_count => 1,
              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_units_button', 'mark_training_dialog_flow', ],

        },              #   END OF quest_recruit_clubber
        {               #   quest_fortress
          :id                => 63,
          :symbolic_id       => :quest_fortress,
  
          :type              => :optional,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Conquer Fortress",
  
            :de_DE => "Festung erobern",
                
          },
          :task => {
            
            :en_US => "Conquer a fortress from the Neanderthals or an other chieftain.",
  
            :de_DE => "Erobere eine Festung von den Neandertalern oder von anderen Häuptlingen.",
                
          },
          :flavour => {
            
            :de_DE => "Wir brauchen mehr Siedlungen! So eine Festung wäre genau das richtige.",
  
            :en_US => "Such a fortress would be the ticket.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Jede Festung erhält die Steuereinnahmen aller Siedlungen der Region.",
  
            :en_US => "Each fortress receives the taxes from all settlements of a region.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_xp',
              },

            ],
  
            :mundane_rank_trigger => 1,
  
          },

          :rewards => {
            
            :unit_rewards => [

              {
                :unit => :unit_warrior,
                :amount => 30,
              },

            ],

            :experience_reward => 500,

          },          

          :reward_tests => {
            
            :settlement_tests => [

              {
                :type => 'settlement_fortress',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_fortress
        {               #   quest_infantry_tower
          :id                => 64,
          :symbolic_id       => :quest_infantry_tower,
  
          :type              => :optional,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Build an Infantry tower",
  
            :de_DE => "Knüppler Gelände errichten",
                
          },
          :task => {
            
            :en_US => "Build clubber grounds in your fortress.",
  
            :de_DE => "Baue ein Knüppler Gelände in Deiner Festung.",
                
          },
          :flavour => {
            
            :de_DE => "Wir brauchen Nahkämpfer für die Verteidigung.",
  
            :en_US => "We need melee fighters for defense.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Jetzt kannst du Nahkämpfer in deiner Festung ausbilden.",
  
            :en_US => "Now you can train melee fighters in your fortress.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_fortress',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_fur,
                :amount => 500,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_infantry_tower',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_infantry_tower
        {               #   quest_fortress_fortification_lvl5
          :id                => 65,
          :symbolic_id       => :quest_fortress_fortification_lvl5,
  
          :type              => :optional,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Improve Fortress fortification",
  
            :de_DE => "Festungsanlagen verbessern",
                
          },
          :task => {
            
            :en_US => "Upgrade the fortification to level 5.",
  
            :de_DE => "Verbessere die Festungsanlagen auf Level 5.",
                
          },
          :flavour => {
            
            :de_DE => "Mit dem Ausbau der Festungsanlagen steigt der Kampfbonus.",
  
            :en_US => "Upgrading the fortification increases the combat bonus.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Jetzt kannst Du das Werfer Gelände bauen.",
  
            :en_US => "Now you can build throwing grounds.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_infantry_tower',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 1500,
              },

              {
                :resource => :resource_wood,
                :amount => 1500,
              },

              {
                :resource => :resource_fur,
                :amount => 750,
              },

            ],

            :experience_reward => 300,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_fortress_fortification',

                :min_level => 5,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_fortress_fortification_lvl5
        {               #   quest_artillery_tower
          :id                => 66,
          :symbolic_id       => :quest_artillery_tower,
  
          :type              => :optional,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Artillery tower",
  
            :de_DE => "Werfer Gelände errichten",
                
          },
          :task => {
            
            :en_US => "Build throwing grounds in your fortress.",
  
            :de_DE => "Baue ein Werfer Gelände in deiner Festung.",
                
          },
          :flavour => {
            
            :de_DE => "Fernkampf ist das einzieg wahre. Weit weg und doch tödlich.",
  
            :en_US => "Ranged fighting is the one and only. Far away but still deadly.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Der weitere Ausbau beschleunigt die Ausbildung der Fernkämpfer.",
  
            :en_US => "Further upgrading increases the building speed of ranged fighters.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_fortress_fortification_lvl5',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_fur,
                :amount => 750,
              },

            ],

            :experience_reward => 150,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_artillery_tower',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_artillery_tower
        {               #   quest_fortress_fortification_lvl7
          :id                => 67,
          :symbolic_id       => :quest_fortress_fortification_lvl7,
  
          :type              => :optional,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Improve Fortress fortification",
  
            :de_DE => "Festungsanlagen verbessern",
                
          },
          :task => {
            
            :en_US => "Upgrade the fortification to level 7.",
  
            :de_DE => "Verbessere die Festungsanlagen auf Level 7.",
                
          },
          :flavour => {
            
            :de_DE => "Bald ist unsere Festung uneinnehmbar!",
  
            :en_US => "We need more settlements. A fortress would be the way to go.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Du musst dich für maximal zwei Kampfarten in der Festung entscheiden.",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_fortress_fortification_lvl5',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 3000,
              },

              {
                :resource => :resource_wood,
                :amount => 3000,
              },

              {
                :resource => :resource_fur,
                :amount => 1500,
              },

            ],

            :experience_reward => 300,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_fortress_fortification',

                :min_level => 7,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_fortress_fortification_lvl7
        {               #   quest_cavalry_tower
          :id                => 68,
          :symbolic_id       => :quest_cavalry_tower,
  
          :type              => :optional,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Cavalry tower",
  
            :de_DE => "Reiteranlage errichten",
                
          },
          :task => {
            
            :en_US => "Build cavalry grounds in your fortress.",
  
            :de_DE => "Baue eine Reiteranlage in deiner Festung.",
                
          },
          :flavour => {
            
            :de_DE => "Reiter sind schnell. Aber sie stinken auch.",
  
            :en_US => "Riders are fast. But they also smell.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Reine Reiterarmeen sind schneller als andere Armeen.",
  
            :en_US => "Pure cavalry armies are faster than others.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_fortress_fortification_lvl7',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_fur,
                :amount => 1000,
              },

            ],

            :experience_reward => 200,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_cavalry_tower',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_cavalry_tower
        {               #   quest_haunt_lvl6
          :id                => 69,
          :symbolic_id       => :quest_haunt_lvl6,
  
          :type              => :optional,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Haunt level 6",
  
            :de_DE => "Versammlungsplatz ausbauen",
                
          },
          :task => {
            
            :en_US => "Upgrade your encampment’s haunt to level 6.",
  
            :de_DE => "Verbessere den Versammlungsplatz Deiner Lagerstätte auf Level 6.",
                
          },
          :flavour => {
            
            :de_DE => "Wir brauchen mehr Platz am Feuer für unsere Versammlungen.",
  
            :en_US => "We need more space next to the fire for our assemblies.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Du kannst jetzt eins der drei Spezialgebäude bauen. Entscheide Dich weise!",
  
            :en_US => "Now you can build one of three special buildings. Decide wisely!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_encampment',
              },

            ],
  
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 1000,
              },

              {
                :resource => :resource_wood,
                :amount => 1000,
              },

              {
                :resource => :resource_fur,
                :amount => 500,
              },

            ],

            :experience_reward => 150,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_haunt',

                :min_level => 6,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_haunt_lvl6
        {               #   quest_altar
          :id                => 70,
          :symbolic_id       => :quest_altar,
  
          :type              => :optional,
  
          :advisor           => :chef,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Build an altar",
  
            :de_DE => "Ritualstein errichten",
                
          },
          :task => {
            
            :en_US => "Choose the altar as special building for your encampment.",
  
            :de_DE => "Entscheide dich für das Spezialgebäude Ritualstein in deiner Lagerstätte.",
                
          },
          :flavour => {
            
            :de_DE => "Der Ritualstein schützt Deine Lagerstätte vor feindlichen Übernahmen.",
  
            :en_US => "The altar protects your encampment from being conquered.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Endlich in Sicherheit. Diese Lagerstätte kann von Feinden nicht mehr geklaut werden.",
  
            :en_US => "Finally safe. This encampment cannot be stolen by your enemies anymore.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_haunt_lvl6',
              },

            ],
  
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
                :amount => 100,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_altar',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_altar
        {               #   quest_field_camp
          :id                => 71,
          :symbolic_id       => :quest_field_camp,
  
          :type              => :optional,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Build Field camp",
  
            :de_DE => "Feldlager errichten",
                
          },
          :task => {
            
            :en_US => "Choose the field camp as special building for your encampment.",
  
            :de_DE => "Entscheide dich für das Spezialgebäude Feldlager in deiner Lagerstätte.",
                
          },
          :flavour => {
            
            :de_DE => "Das Feldlager stärkt die Armee der Lagerstätte.",
  
            :en_US => "The field camp reinforces encampment’s armies.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "The field camp extends your armies and on level 10 it will provide another command point.",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_haunt_lvl6',
              },

            ],
  
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
                :amount => 100,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_field_camp',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_field_camp
        {               #   quest_trade_center
          :id                => 72,
          :symbolic_id       => :quest_trade_center,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Build Trade Center",
  
            :de_DE => "Handelsplatz errichten",
                
          },
          :task => {
            
            :en_US => "Choose the trading center as special building for your encampment.",
  
            :de_DE => "Entscheide dich für das Spezialgebäude Handelsplatz in deiner Lagerstätte.",
                
          },
          :flavour => {
            
            :de_DE => "Der Handelsplatz verbessert die Rohstoffproduktion der Lagerstätte.",
  
            :en_US => "The trading center increases the encampment’s ressource production.",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Mit dem Handelsplatz verbessert sich deine Rohstoffproduktion, läßt Deine Lagerstätte aber fast wehrlos.",
  
            :en_US => "The trading center increases your ressource production, but leaves your encampment nearly unprotected.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_haunt_lvl6',
              },

            ],
  
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
                :amount => 100,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_trade_center',

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_trade_center
        {               #   quest_charkills_1
          :id                => 73,
          :symbolic_id       => :quest_charkills_1,
  
          :type              => :optional,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Decimate enemy units",
  
            :de_DE => "Gegner dezimieren",
                
          },
          :task => {
            
            :en_US => "Defeat 10 units.",
  
            :de_DE => "Besiege 10 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Muhaha, kämpfen heißt leben!",
  
            :en_US => "Muhaha, fighting means living!",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Für einen siegreichen Kampf erhälst du zusätzliche Erfahrung.",
  
            :en_US => "You receive additional experience for a victorious fight.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :play_time_trigger => 1200,
  
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_outpost',
              },

            ],
  
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

            ],

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 10,
            },

          },          

        },              #   END OF quest_charkills_1
        {               #   quest_charkills_2
          :id                => 74,
          :symbolic_id       => :quest_charkills_2,
  
          :type              => :optional,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Decimate enemy units",
  
            :de_DE => "Gegner dezimieren",
                
          },
          :task => {
            
            :en_US => "Defeat 100 units.",
  
            :de_DE => "Besiege 100 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Muhaha, kämpfen heißt leben!",
  
            :en_US => "Muhaha, fighting means living!",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Für einen siegreichen Kampf erhälst du zusätzliche Erfahrung.",
  
            :en_US => "You receive additional experience for a victorious fight.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :play_time_trigger => 7200,
  
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_charkills_1',
              },

            ],
  
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
                :amount => 200,
              },

            ],

            :experience_reward => 50,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 100,
            },

          },          

        },              #   END OF quest_charkills_2
        {               #   quest_charkills_3
          :id                => 75,
          :symbolic_id       => :quest_charkills_3,
  
          :type              => :optional,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Decimate enemy units",
  
            :de_DE => "Gegner dezimieren",
                
          },
          :task => {
            
            :en_US => "Defeat 250 units.",
  
            :de_DE => "Besiege 250 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Muhaha, kämpfen heißt leben!",
  
            :en_US => "Muhaha, fighting means living!",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Für einen siegreichen Kampf erhälst du zusätzliche Erfahrung.",
  
            :en_US => "You receive additional experience for a victorious fight.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :play_time_trigger => 14400,
  
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_charkills_2',
              },

            ],
  
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
                :amount => 300,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 250,
            },

          },          

        },              #   END OF quest_charkills_3
        {               #   quest_charkills_4
          :id                => 76,
          :symbolic_id       => :quest_charkills_4,
  
          :type              => :optional,
  
          :advisor           => :warrior,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Decimate enemy units",
  
            :de_DE => "Gegner dezimieren",
                
          },
          :task => {
            
            :en_US => "Defeat 500 enemy units.",
  
            :de_DE => "Besiege 500 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Muhaha, kämpfen heißt leben!",
  
            :en_US => "Muhaha, fighting means living!",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p></p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Für einen siegreichen Kampf erhälst du zusätzliche Erfahrung.",
  
            :en_US => "You receive additional experience for a victorious fight.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :triggers => {
            
            :play_time_trigger => 86400,
  
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_charkills_3',
              },

            ],
  
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
                :amount => 400,
              },

            ],

            :experience_reward => 150,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 500,
            },

          },          

        },              #   END OF quest_charkills_4
      ],                # END OF QUESTS

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts Tutorial::Tutorial.the_tutorial.to_json
#Tutorial.tutorial.quests.each do |value| 
#  puts value[:name][:de_DE] 
#end

