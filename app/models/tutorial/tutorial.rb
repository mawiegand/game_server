# encoding: utf-8  

require 'active_model'

# A module containing the tutorial quests of a particular game instance using the
# Augmented Worlds Engine.
#
# This particular file does hold the following set of rules:
# Game:    Wack-A-Doo
# Branch:  development (alpha)
# Version: 0.4.0
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
        :major => 0, 
        :minor => 4, 
        :build => 0, 
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
  
      :num_tutorial_quests => 19,
  
      :quests => [  # ALL QUESTS

        {               #   quest_queue_1gathererlvl1
          :id                => 0,
          :symbolic_id       => :quest_queue_1gathererlvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 1,
          :blocking          => true,

          :name => {
            
            :en_US => "The first building",
  
            :de_DE => "Der erste Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Give an order to a Level 1 Hunter Gatherer.",
  
            :de_DE => "Gib einen Jäger und Sammler Level 1 in Auftrag.",
                
          },
          :flavour => {
            
            :de_DE => "Willkommen Halbgott. Schau Dir Deine Siedlung an, ist sie nicht wundervoll?",
  
            :en_US => "Welcome Demigod! Look at your settlement – isn't it great? A bit empty, though.",
                
          },
          :description => {
            
            :de_DE => "<p>Um einen Jäger und Sammler in Auftrag zu geben, drücke auf einen Bauplatz und wähle dort den Jäger und Sammler.</p>",
  
            :en_US => "<p>To give an order to a Hunter Gatherer, press on an empty building site and click Hunter Gatherer.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hey, der erste Jäger und Sammler ist eingezogen. So sieht es doch schon viel besser aus, findest Du nicht?",
  
            :en_US => "Hey – that looks much better, don't you think? ",
                
          },
          :reward_text => {
            
            :de_DE => "Der Jäger und Sammler sammelt Steine, Holz und Felle für Deinen Rohstoffvorrat.",
  
            :en_US => "The job of a Hunter Gatherer is to collect small quantities of stone, wood and fur - all the raw materials you need to succeed. ",
                
          },

          :requirement => {
            
            :quest => 'quest_found_home_base',

          },

          :successor_quests => [1, ],

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

              {
                :resource => :resource_fur,
                :amount => 25,
              },

            ],

            :experience_reward => 25,

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
        {               #   quest_build_1gathererlvl2
          :id                => 1,
          :symbolic_id       => :quest_build_1gathererlvl2,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 1,
          :blocking          => true,

          :name => {
            
            :en_US => "Upgrade",
  
            :de_DE => "Jäger und Sammler Level 2",
                
          },
          :task => {
            
            :en_US => "Upgrade a Hunter Gatherer to Level 2.",
  
            :de_DE => "Baue einen Jäger und Sammler auf Level 2 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Könntest Du bitte einen Jäger und Sammler auf Level 2 ausbauen? Dann arbeitet er effektiver und liefert Dir mehr Rohstoffe.",
  
            :en_US => "Do you think you could upgrade a Hunter Gatherer to level 2? He'd feel better, and he´d be able to collect more resources for you. ",
                
          },
          :description => {
            
            :de_DE => "<p>Wähle dazu einen Jäger und Sammler aus. Im sich öffnenden Fenster siehst Du den aktuellen Level, darunter die nächste Ausbaustufe. Drücke auf den 'Ausbauen' Knopf, um den Ausbau zu beginnen.</p>",
  
            :en_US => "<p>Choose a Hunter Gatherer. A window open showing the current status of your development, including the next upgrade level. Press Upgrade to get started.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Wie nett von Dir. Der Sammler freut sich wie verrückt und die Produktion ist gestiegen. Außerdem erhältst Du wertvolle Erfahrung.",
  
            :en_US => "Oh that's nice of you! The Hunter Gatherer is really happy. He gave me some raw materials to give you.",
                
          },
          :reward_text => {
            
            :de_DE => "Du solltest weitere Jäger und Sammler bauen um Deine Rohstoffproduktion zu verbessern.",
  
            :en_US => "You should create more Hunter Gatherer to improve your raw material production.",
                
          },

          :requirement => {
            
            :quest => 'quest_queue_1gathererlvl1',

          },

          :successor_quests => [2, ],

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

              {
                :resource => :resource_fur,
                :amount => 25,
              },

            ],

            :experience_reward => 50,

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

          :uimarker => ['mark_home_settlement', 'mark_upgradable_building', 'mark_upgrade_button', ],

        },              #   END OF quest_build_1gathererlvl2
        {               #   quest_build_chiefcottagelvl2
          :id                => 2,
          :symbolic_id       => :quest_build_chiefcottagelvl2,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Upgrade the chieftan's hut",
  
            :de_DE => "Ausbau der Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 2.",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 2 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Halbgott? Und was soll das da sein? Meine Häuptlingshütte? Da kann ja niemand drin leben! Ändere das sofort!",
  
            :en_US => "Demigod?! I don´t think so. Look at my chieftan´s hut! You think I´m going to live in that? Ha! Change it immediately!",
                
          },
          :description => {
            
            :de_DE => "<p>Die Häuptlingshütte ist das große Gebäude in der Mitte der Siedlung.</p>",
  
            :en_US => "<p>The chieftain's hut is the big building in the middle of the settlement.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Endlich fertig, hm? Hat ja ewig gedauert. Wie Belohnung?",
  
            :en_US => "Finished at last, eh? That took you long enough. What do you mean, reward? What for? Isn't it enough that your settlement is bigger and you can build a new building?
      ",
                
          },
          :reward_text => {
            
            :de_DE => "Baue zunächst nur auf den kleinen Bauplätzen und spare Dir die großen Bauplätze in der Mitte. Nutze diese, wenn Du Dich besser auskennst.",
  
            :en_US => "At the moment you should build your building at the small building slots.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl2',

          },

          :successor_quests => [5, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 100,
              },

              {
                :resource => :resource_wood,
                :amount => 100,
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
                :building => 'building_chief_cottage',

                :min_level => 2,

                :min_count => 1,

              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_upgradable_building', 'mark_upgrade_button', ],

          :message => {
            
            :en => {
              :subject => 'Welcome to Wack-A-Doo!',
              :body => "<h2>Welcome to Round 3 of Wack-A-Doo's Public Beta.</h2>
          <p>Wack-A-Doo has finished the first rounds of its Public Beta, but the game is still in development.<br/>
          As before, we will be adding lots of new content and mechanics during this round of public Beta, trying to improve your game experience. <br/>
          Prepare to be surprised!</p>
          <p>We suggest that you follow the tutorial and complete the subsequent quests in order to learn the basics of Wack-A-Doo. Other players will also be happy to answer your questions, both in general chat and in your alliances.</p>
          <p>You can find detailed instructions and on overview of the game mechanics in our in-game encyclopedia an in our wiki:</p>
          <p style='margin-left: 32px;'><a href='http://wiki.wack-a-doo.com/Main_Page' target='_blank'>Wack-A-Doo Wiki</a> (under construction!); <a href='http://wiki.wack-a-doo.com/Tech_Tree' target='_blank'>Tech-Tree</a> ; <a href='http://wiki.wack-a-doo.com/Unit_Tech_Tree' target='_blank'>Unit Overview</a></p>
          <p>We invite you to register and help keep our Wiki up to date.</p>
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
          iPhone, iPad und iPod touch mit unserer App spielen. Eine Anleitung, wie Du Deinen Account portabel machst, findest Du hier:
          <a href='https://ios.wack-a-doo.com/de/encyclopedia/account' target='_blank'>Account portabel machen</a>.</p>
          <p>Wir wünschen Dir viel Spaß bei Wack-A-Doo.</p>
          <p>Das Wack-A-Doo Team</p>",
            },

          },          

        },              #   END OF quest_build_chiefcottagelvl2
        {               #   quest_quest_button
          :id                => 3,
          :symbolic_id       => :quest_quest_button,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Quest button",
  
            :de_DE => "Questknopf",
                
          },
          :task => {
            
            :en_US => "Find the quest button and press it. Then close the dialog and come back here.",
  
            :de_DE => "Finde und drücke den Questknopf. Schließe dann den Dialog und komm hierher zurück.",
                
          },
          :flavour => {
            
            :de_DE => "Du kannst Dir übrigens jederzeit die laufenden Quests in der Quest-Übersicht anschauen.",
  
            :en_US => "You can also see all your current quests at any time by using the quest overview.",
                
          },
          :description => {
            
            :de_DE => "<p>Finde den Questknopf beschriftet mit 'Quest'. Dort findest Du sowohl die aktuellen als auch bereits gelösten Quests, deren Belohnungen Du noch nicht eingelöst hast.</p>",
  
            :en_US => "<p>Find the button labeled Quest. That's where you'll find your current quests and any completed quests for which you haven´t claimed the reward yet.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Klasse, jetzt hast Du alle Quests auf einen Blick.",
  
            :en_US => "Great – now you can see all your quests at a glance.",
                
          },
          :reward_text => {
            
            :de_DE => "Schaue regelmäßig in die Questübersicht, dann verlierst Du nie den Überblick.",
  
            :en_US => "Take a look at the quest overview regularly, then you won't lose track of them.",
                
          },

          :successor_quests => [],

          :rewards => {
            
            :experience_reward => 50,

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_quest_button',
            },

          },          

          :uimarker => ['mark_quest_button', ],

        },              #   END OF quest_quest_button
        {               #   quest_profile
          :id                => 4,
          :symbolic_id       => :quest_profile,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => true,
          :priority          => 2,
          :blocking          => false,

          :name => {
            
            :en_US => "Name and profile",
  
            :de_DE => "Namen und Profil",
                
          },
          :task => {
            
            :en_US => "Change your name.",
  
            :de_DE => "Ändere Deinen Namen.",
                
          },
          :flavour => {
            
            :de_DE => "Jetzt haben wir schon so viel zusammen erlebt und ich weiß immer noch nicht, wie Du heißt. Bitte sag mir Deinen Namen.
      ",
  
            :en_US => "We've gone through so much together already, but I still don't know who you are! What's your name?
      ",
                
          },
          :description => {
            
            :de_DE => "<p>Drücke dazu auf den Profil-Knopf. Drücke dann auf 'Anpassung' und wähle dort 'Namen ändern'. Die ersten zwei Namensänderungen sind kostenlos.</p>",
  
            :en_US => "<p>Press the profile button, then select Customization. Select Choose Your Name. The first two name changes are free.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Danke. Wir werden noch viel Spaß miteinander haben.",
  
            :en_US => "Thanks. I think we're going to have loads of fun together!",
                
          },
          :reward_text => {
            
            :de_DE => "Im Profil kannst Du Deinen Fortschritt sehen und weitere Änderungen vornehmen.",
  
            :en_US => "In your profile you can see your progress and make other changes.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1campfirelvl1',

          },

          :successor_quests => [130, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

            :experience_reward => 200,

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_profile',
            },

          },          

          :uimarker => ['mark_profile', 'mark_name_change', ],

        },              #   END OF quest_profile
        {               #   quest_build_1barrackslvl1
          :id                => 5,
          :symbolic_id       => :quest_build_1barrackslvl1,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 2,
          :blocking          => false,

          :name => {
            
            :en_US => "Training Grounds",
  
            :de_DE => "Ausbildungsgelände",
                
          },
          :task => {
            
            :en_US => "Build a Training Grounds.",
  
            :de_DE => "Baue ein Ausbildungsgelände.",
                
          },
          :flavour => {
            
            :de_DE => "Du kannst ein Ausbildungsgelände bauen, machst es aber nicht? Bau sofort eins und ich gebe Dir etwas aus meiner Schatzkiste.
      ",
  
            :en_US => "You can build a Training Grounds but you're not doing it? If you build one now, I´ll give you something from my treasure chest.
      ",
                
          },
          :description => {
            
            :de_DE => "<p>Ein Ausbildungsgelände bildet Nahkampfeinheiten aus. Nahkampfeinheiten sind die Basis jeder Armee!</p>",
  
            :en_US => "<p>Training Grounds are where melee fighters are trained. Melees are the backbone of every army!</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Fertig? Na endlich! Da, Deine Belohnung, mehr gibt's nicht. Verschwinde.
      ",
  
            :en_US => "Finished? About time, too. There's your reward – that's all there is. Push off.",
                
          },
          :reward_text => {
            
            :de_DE => "Das Ausbildungsgelände verkürzt auch die Rekrutierungszeit der Nahkampfeinheiten.",
  
            :en_US => "Having a Training Grounds speeds up the time it takes to recruit melee fighters.
      ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl2',

          },

          :successor_quests => [6, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 80,
              },

              {
                :resource => :resource_wood,
                :amount => 70,
              },

              {
                :resource => :resource_fur,
                :amount => 180,
              },

            ],

            :experience_reward => 100,

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

        },              #   END OF quest_build_1barrackslvl1
        {               #   quest_recruit_1clubbers
          :id                => 6,
          :symbolic_id       => :quest_recruit_1clubbers,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 2,
          :blocking          => false,

          :name => {
            
            :en_US => "Your first unit",
  
            :de_DE => "Deine erste Einheit",
                
          },
          :task => {
            
            :en_US => "Build a warrior.",
  
            :de_DE => "Baue einen Krieger.",
                
          },
          :flavour => {
            
            :de_DE => "Hmm? Keine Einheiten weit und breit. Da sollte sich mal jemand drum kümmern, sonst wird diese Siedlung demnächst niedergebrannt.",
  
            :en_US => "What? Not a unit to be seen anywhere. Someone should pay attention to that or the settlement will soon be burned to the ground.",
                
          },
          :description => {
            
            :de_DE => "<p>Gehe in das Ausbildungsgelände, wähle dort in der Rekrutierungsliste ganz unten den Krieger aus und drücke auf 'Rekrutiere Krieger'.</p>",
  
            :en_US => "<p>Go to the Training Grounds, select a warrior from the recruiting list at the bottom and then start training. Recruited units end up in the settlement´s garrison.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Aller Anfang ist schwer, aber da musst Du noch dran arbeiten. Fürs Erste stell ich Dir ein paar meiner Krieger zur Verfügung.",
  
            :en_US => "Everything's always difficult at first. You just have to stick with it. For now, I'll let you have some of my warriors.",
                
          },
          :reward_text => {
            
            :de_DE => "Du kannst mehrere Einheiten gleichzeitig trainieren, gib einfach die gewünschte Anzahl an.",
  
            :en_US => "You can train several units at the same time. Just select the number of units you want.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1barrackslvl1',

          },

          :successor_quests => [7, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 1,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_warrior,
                :amount => 5,
              },

            ],

            :experience_reward => 150,

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

        },              #   END OF quest_recruit_1clubbers
        {               #   quest_settlement_button1
          :id                => 7,
          :symbolic_id       => :quest_settlement_button1,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 2,
          :blocking          => false,

          :name => {
            
            :en_US => "On the map",
  
            :de_DE => "Auf die Karte",
                
          },
          :task => {
            
            :en_US => "Go to the world map.",
  
            :de_DE => "Begib Dich auf die Weltkarte.",
                
          },
          :flavour => {
            
            :de_DE => "Was? Dir ist es hier zu klein? Es gibt eine riesige Welt zu erobern. Wenn Du mal aus diesem Loch rauskommen würdest, wüsstest Du das auch. Worauf wartest Du? Geh!",
  
            :en_US => "What? It's too small for you here? There's a whole world to conquer. If you made an effort to get out of this hole, you´d realize that. So what are you waiting for?! Go!",
                
          },
          :description => {
            
            :de_DE => "<p>Finde und drücke den Kartenknopf.</p><p>Der Knopf wechselt auf die Weltkarte und zentriert sie auf die Region mit Deiner Siedlung, egal, wo Du bist, oder wo Deine Armeen stehen.</p><p>Wenn Du zurück in Deine Siedlung willst, wähle Deine Siedlung aus und klicke auf 'Betreten'.</p>",
  
            :en_US => "<p>Find and press the Map button.</p><p>You´ll be able to see the World Map and focus on the region of your sattlement, no matter where you are. If you want to go back to yout settlement, select it and click Enter.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na, was gelernt? Hier hast Du noch ein paar Ressourcen, bevor Du wieder nach einer Belohnung fragst.",
  
            :en_US => "So, did you learn anything? Here are a couple of resources for you, before you start asking for rewards again.",
                
          },
          :reward_text => {
            
            :de_DE => "Auf der Weltkarte kannst Du andere Spieler um Dich herum sehen.",
  
            :en_US => "On the World Map you can also see the other gamers who are active arround you.",
                
          },

          :requirement => {
            
            :quest => 'quest_recruit_1clubbers',

          },

          :successor_quests => [17, ],

          :rewards => {
            
            :experience_reward => 200,

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_settlement_button1',
            },

          },          

          :uimarker => ['mark_map', ],

        },              #   END OF quest_settlement_button1
        {               #   quest_build_1storagelvl1
          :id                => 8,
          :symbolic_id       => :quest_build_1storagelvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Raw materials store",
  
            :de_DE => "Rohstofflager ",
                
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
            
            :de_DE => "<p>Rohstofflager erhöhen die maximale Menge an Rohstoffen, die Du lagern kannst. Wenn Du die Grenze erreichst, verfällt jede weitere Produktion.</p>",
  
            :en_US => "<p>Having raw materials store increases the maximum number of raw materials you can store. Once you´ve reached the limit, any further production is lost.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Endlich hab ich genug Platz für meine ganzen Schu - äh Sachen.",
  
            :en_US => "At last I have enough space for all my shoe…er, things!",
                
          },
          :reward_text => {
            
            :de_DE => "Die Handelskarren im Rohstofflager erlauben Dir den Handel mit anderen Spielern. Jeder Handelskarren kann zehn Ressourcen befördern.",
  
            :en_US => "The tradings carts in the raw material store let you trade with other players. Each trading cart can transport ten resources.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl4',

          },

          :successor_quests => [18, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 325,
              },

              {
                :resource => :resource_wood,
                :amount => 325,
              },

              {
                :resource => :resource_fur,
                :amount => 225,
              },

            ],

            :experience_reward => 100,

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

        },              #   END OF quest_build_1storagelvl1
        {               #   quest_army_move
          :id                => 9,
          :symbolic_id       => :quest_army_move,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 2,
          :blocking          => false,

          :name => {
            
            :en_US => "Army movement",
  
            :de_DE => "Armeebewegung",
                
          },
          :task => {
            
            :en_US => "Move your army to the fortress.",
  
            :de_DE => "Bewege Deine Armee zur Festung.",
                
          },
          :flavour => {
            
            :de_DE => "Eine Armee kann mehr als nur herumstehen. Sie ist dazu da die Feinde des Stammes zu vernichten.",
  
            :en_US => "An army can do more than just stand around, you know. It´s there to destroy the enemies of the tribe!",
                
          },
          :description => {
            
            :de_DE => "<p>Wähle Deine Armee aus und klicke auf 'Bewegen' und dann auf das Ziel. Mögliche Ziele sind mit einem grünen Pfeil markiert. Bewegungen von Spielern zu kontrollierten Festungen sollten nur mit Einverständnis des Spielers oder mit genügend Kampfstärke erfolgen.</p>",
  
            :en_US => "<p>Select your army, click on Move, and then on the destination you want to go to. Possible destinations are marked with a green arrow. Moves to fortresses controlled by other players can only be made if the other player agrees or if you have enough fighting strenght.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hm? Die Armee ist unterwegs? Sicher, dass Du genug Truppen hast? Na okay, ich glaub Dir ja.",
  
            :en_US => "Hm. The army is on its way? Are you sure you have enough units? OK, I believe you.",
                
          },
          :reward_text => {
            
            :de_DE => "Unter Deiner Armee siehst Du die verfügbaren Aktionspunkte. Jede Bewegung und jeder Angriff kostet Dich einen Aktionspunkt. Deine Armeen generieren alle 3 Stunden einen Aktionspunkt.",
  
            :en_US => "Below your army you'll see your available action points. Movements and attacks cost one action point and your army regenerates one action point every three hours.",
                
          },

          :requirement => {
            
            :quest => 'quest_army_create',

          },

          :successor_quests => [11, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 110,
              },

              {
                :resource => :resource_wood,
                :amount => 110,
              },

              {
                :resource => :resource_fur,
                :amount => 110,
              },

            ],

            :experience_reward => 200,

            :action_point_reward => true,

          },          

          :reward_tests => {
            
            :movement_test => {},

          },          

          :uimarker => ['mark_map', 'mark_select_own_army', 'mark_move_own_army', ],

          :place_npcs => 1,         

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
        {               #   quest_build_2gathererlvl3
          :id                => 10,
          :symbolic_id       => :quest_build_2gathererlvl3,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "More Hunter Gatherers",
  
            :de_DE => "Noch mehr Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Upgrade a Hunter Gatherer to Level 3.",
  
            :de_DE => "Baue einen Jäger und Sammler auf Level 3 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Ich bin ganz begeistert, wie sich Deine Jäger und Sammler bemühen, Dir Rohstoffe zu bringen. Gewähre ihnen doch bitte eine weitere Ausbildung.",
  
            :en_US => "I'm really impressed by your Hunter Gatherers' efforts to get raw materials for you. Why not give them some more training?  ",
                
          },
          :description => {
            
            :de_DE => "<p>Sorge doch bitte dafür, dass Du immer genug Rohstoffe hast. Baue und verbessere dafür mindestens zwei Deiner Jäger und Sammler auf Level 3.</p>",
  
            :en_US => "<p>You need to make sure your population always has enough raw materials to survive. To do this, you should upgrade at least two of your Hunter Gatherers to Level 3.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Danke, Halbgott. Sehr vorausschauend, Deine Rohstoffproduktion weiter zu erhöhen.",
  
            :en_US => "Thank you Demigod. That was great foresight on your part, raising your raw materials production like that.",
                
          },
          :reward_text => {
            
            :de_DE => "Jäger und Sammler bauen ist immer eine gute Idee.",
  
            :en_US => "Creating more Hunter Gatherers is always a good idea.",
                
          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 90,
              },

              {
                :resource => :resource_wood,
                :amount => 60,
              },

              {
                :resource => :resource_fur,
                :amount => 45,
              },

            ],

            :experience_reward => 50,

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

        },              #   END OF quest_build_2gathererlvl3
        {               #   quest_settlement_button2
          :id                => 11,
          :symbolic_id       => :quest_settlement_button2,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 2,
          :blocking          => false,

          :name => {
            
            :en_US => "Back to the settlement",
  
            :de_DE => "Zurück in die Siedlung",
                
          },
          :task => {
            
            :en_US => "Get yourself back to your settlement.",
  
            :de_DE => "Begib Dich zurück in Deine Siedlung.",
                
          },
          :flavour => {
            
            :de_DE => "Du findest Deine Siedlung nicht mehr? Das ist ganz einfach, ich erklär's Dir. Dann kannst Du es versuchen.",
  
            :en_US => "Can't find your settlement? It's quite easy, if you'll let me explain.",
                
          },
          :description => {
            
            :de_DE => "<p>Drücke auf den Siedlungsknopf oder wähle Deine Siedlung aus und drücke 'Betreten' um zurück in Deine Siedlung zu kommen.</p>",
  
            :en_US => "<p>Use the Settlement button or press on your settlement and then click Enter to get back to your settlement.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na? Ging doch ganz einfach, oder?",
  
            :en_US => "See? How easy was that.",
                
          },
          :reward_text => {
            
            :de_DE => "Alle Deine Siedlungen und Festungen kannst Du betreten, indem Du sie auswählst und 'Betreten' klickst.",
  
            :en_US => "You can enter all of your settlements and fortresses by selecting them and clicking Enter.",
                
          },

          :requirement => {
            
            :quest => 'quest_army_move',

          },

          :successor_quests => [12, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

            :experience_reward => 150,

            :action_point_reward => true,

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_settlement_button2',
            },

          },          

          :uimarker => ['mark_home_settlement', ],

        },              #   END OF quest_settlement_button2
        {               #   quest_build_chiefcottagelvl3
          :id                => 12,
          :symbolic_id       => :quest_build_chiefcottagelvl3,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chieftain's hut",
  
            :de_DE => "Eine noch größere Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 3",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 3 aus, um neue Gebäude freizuschalten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Siedlung kommt ganz schön voran. Aber Du musst jetzt die Häuptlingshütte ausbauen um weiterzukommen.",
  
            :en_US => "Your settlement is coming along nicely, but you're going to have to upgrade the chieftan's hut if you want to make some more progress.",
                
          },
          :description => {
            
            :de_DE => "<p>Mit Ausbau der Häuptlingshütte kannst Du mehr Gebäude und auch neue Gebäude bauen.</p>",
  
            :en_US => "<p>By upgrading your chieftan's hut, you'll have the option to create a wider range of buildings for your settlement.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll. Wieder ein paar Bauplätze mehr. Und eine kleine Hütte kannst Du jetzt auch bauen.",
  
            :en_US => "Great! There are now some more building slots available and you can build a small hut.",
                
          },
          :reward_text => {
            
            :de_DE => "Der Ausbau der Häuptlingshütte schaltet neue Gebäudearten frei und erlaubt Dir mehr Gebäude zu bauen.",
  
            :en_US => "Upgrading the chieftan's hut gives you the option to construct a wider range of buildings.",
                
          },

          :requirement => {
            
            :quest => 'quest_settlement_button2',

          },

          :successor_quests => [13, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 175,
              },

              {
                :resource => :resource_wood,
                :amount => 175,
              },

              {
                :resource => :resource_fur,
                :amount => 175,
              },

            ],

            :experience_reward => 225,

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

        },              #   END OF quest_build_chiefcottagelvl3
        {               #   quest_build_cottagelvl1
          :id                => 13,
          :symbolic_id       => :quest_build_cottagelvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "The small huts",
  
            :de_DE => "Die kleinen Hütten",
                
          },
          :task => {
            
            :en_US => "Build a small hut.",
  
            :de_DE => "Baue eine kleine Hütte.",
                
          },
          :flavour => {
            
            :de_DE => "Diese kleinen Hütten sind wirklich nützlich. Mehr Einwohner bedeuten auch mehr helfende Hände.",
  
            :en_US => "Did you know that you can give your workers two orders at the same time? They can only work on one of them, but they'll keep the other order in mind. Why don't you try it? The happier your workers are, the faster they'll build things for you.",
                
          },
          :description => {
            
            :de_DE => "<p>Kleine Hütten verkürzen die Bauzeit von Gebäuden. Du kannst mehrere bauen, um die Bauzeit deutlich zu senken.</p>",
  
            :en_US => "<p>Having small huts reduces the time it takes to construct other buildings.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut gemacht. Deine Arbeiter freuen sich und bauen schneller.",
  
            :en_US => "Well done! Your workers are happy and they're building things faster because of it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Dir die Bauaufträge zu lange dauern, kannst Du mehr kleine Hütten bauen und weiter ausbauen.",
  
            :en_US => "choose a Hunter Gatherer. A window will open showing the current status of your development, including the next upgrade level. Press Upgrade to get started.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl3',

          },

          :successor_quests => [129, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 120,
              },

              {
                :resource => :resource_wood,
                :amount => 100,
              },

              {
                :resource => :resource_fur,
                :amount => 100,
              },

            ],

            :experience_reward => 150,

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

        },              #   END OF quest_build_cottagelvl1
        {               #   quest_improve_production_1
          :id                => 14,
          :symbolic_id       => :quest_improve_production_1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Improve your production of raw materials",
  
            :de_DE => "Erhöhe Deine Rohstoffproduktion",
                
          },
          :task => {
            
            :en_US => "Improve your production of stone and wood to at least 12 units per hour.",
  
            :de_DE => "Erhöhe Deine Produktion von Steinen und Holz auf je mindestens 12 Rohstoffeinheiten pro Stunde.",
                
          },
          :flavour => {
            
            :de_DE => "Rohstoffe sind die halbe Miete. Wir brauchen dringend eine Produktion!",
  
            :en_US => "We need to produce more raw materials.",
                
          },
          :description => {
            
            :de_DE => "<p>Du solltest zum Erreichen des Ziels 3 oder 4 Jäger und Sammler bauen und  auf Level 2 oder 3 ausbauen. Die Produktionsrate pro Stunde siehst Du oben bei den Rohstoffanzeigen.</p>",
  
            :en_US => "<p>To do this, you need to build three or four Hunter Gatherers and upgrade them to Level 2 or 3. You can see your current production of raw materials on the display at the top.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Super! Das ist schon mal ein Anfang.",
  
            :en_US => "Great! That's a start.",
                
          },
          :reward_text => {
            
            :de_DE => "Denk dran, wann immer möglich Deine Rohstoffproduktion auszubauen. Du solltest jeden freien und nicht anderweitig benötigten Bauplatz dafür verwenden.",
  
            :en_US => "Remember to increase your production of raw materials. You need to use every free building slot you have available.",
                
          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 125,
              },

              {
                :resource => :resource_wood,
                :amount => 125,
              },

              {
                :resource => :resource_fur,
                :amount => 125,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :resource_production_tests => [

              {
                :resource => 'resource_wood',
                :minimum  => 12,
              },

              {
                :resource => 'resource_stone',
                :minimum  => 12,
              },

            ],

          },          

        },              #   END OF quest_improve_production_1
        {               #   quest_build_chiefcottagelvl4
          :id                => 15,
          :symbolic_id       => :quest_build_chiefcottagelvl4,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => true,

          :name => {
            
            :en_US => "Finish upgrade",
  
            :de_DE => "Ausbau beenden",
                
          },
          :task => {
            
            :en_US => "Finish the upgrade of the chieftan's hut.",
  
            :de_DE => "Beende den Ausbau der Häuptlingshütte.",
                
          },
          :flavour => {
            
            :de_DE => "Mit ein paar Kröten lässt sich so einiges bewirken.",
  
            :en_US => "With a few golden frogs you can get quite a bit done.",
                
          },
          :description => {
            
            :de_DE => "<p>Du hast von mir zwei Kröten erhalten. Stelle den Ausbau der Häutplingshütte sofort fertig, indem Du auf 'Hurtig!' drückst.</p>",
  
            :en_US => "<p>Use these Golden Frogs to finish the upgrade right now! Press the button marked 'Hurry!' to speed the building process up.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ist es nicht toll, wie Deine Siedlung wächst? Ich habe sogar Chef dazu überreden können, Dir etwas von seinem Rohstoffberg abzugeben.",
  
            :en_US => "Isn't it great how much your settlement is growing? I've even managed to persuade the boss to give you something from his huge store of resources.",
                
          },
          :reward_text => {
            
            :de_DE => "Erhöhe Deine Rohstoffproduktion durch den Bau neuer Jäger und Sammler.",
  
            :en_US => "Boost your raw materials production by building a new Hunter Gatherer.",
                
          },

          :requirement => {
            
            :quest => 'quest_queue_chiefcottagelvl4',

          },

          :successor_quests => [8, ],

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

            :experience_reward => 300,

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
        {               #   quest_queue_chiefcottagelvl4
          :id                => 16,
          :symbolic_id       => :quest_queue_chiefcottagelvl4,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "And another chieftan's hut upgrade",
  
            :de_DE => "Noch einmal die Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 4.",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 4 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Ich denke, es ist mal wieder Zeit für eine größere Häuptlingshütte. Baue sie doch bitte aus, dann haben wir mehr Platz.",
  
            :en_US => "I think it's time to build another big chieftain's hut. Upgrade this one and then we'll have more space.",
                
          },
          :description => {
            
            :de_DE => "<p>Erweitere Deine Häuptlingshütte um weitere Vorteile zu gewinnen.</p>",
  
            :en_US => "<p>Upgrade your Chieftain's Hut to gain more advantages.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Jetzt muss es nur noch fertig werden.",
  
            :en_US => "Now we've just got to finish it.",
                
          },
          :reward_text => {
            
            :de_DE => "Das ist ein größeres Projekt, als wir es bisher hatten und dauert eine Weile.",
  
            :en_US => "This is a bigger project than any of our previous work and it's going to take some time to complete.",
                
          },

          :requirement => {
            
            :quest => 'quest_assignment1',

          },

          :successor_quests => [15, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 165,
              },

              {
                :resource => :resource_wood,
                :amount => 150,
              },

              {
                :resource => :resource_fur,
                :amount => 120,
              },

              {
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

          },          

          :reward_tests => {
            
            :construction_queue_tests => [

              {
                :building => 'building_chief_cottage',
                :min_count => 1,
                :min_level => 4,
              },

            ],

          },          

          :uimarker => ['mark_home_settlement', 'mark_upgradable_building', 'mark_upgrade_button', ],

        },              #   END OF quest_queue_chiefcottagelvl4
        {               #   quest_army_create
          :id                => 17,
          :symbolic_id       => :quest_army_create,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 2,
          :blocking          => false,

          :name => {
            
            :en_US => "Your first army",
  
            :de_DE => "Deine erste Armee",
                
          },
          :task => {
            
            :en_US => "Assemble an army.",
  
            :de_DE => "Stelle eine Armee auf.",
                
          },
          :flavour => {
            
            :de_DE => "Um Einheiten zu bewegen, müssen sie aus der Garnison in eine Armee verschoben werden.",
  
            :en_US => "You can't move units that are in the garrison. To move units, you first have to relocate them from the garrison into an army.",
                
          },
          :description => {
            
            :de_DE => "<p>Gehe auf die Karte und wähle Deine Siedlung aus. Drücke den 'Verstärken' Knopf.</p><p>Der Dialog zeigt Dir auf der linken Seite die Einheiten der Garnison und auf der rechten Seite die Einheiten in der Armee. Du kannst die Krieger in die Armee bewegen.</p><p>Gib Deiner Armee einen Namen und drücke zum Bestätigen auf 'Erzeugen'.</p>",
  
            :en_US => "<p>Go to the map and select your settlement. Press the Reinforce button. You'll be able to see the units in the garrison on the left and the warriors in the army on the right. You can then move units into the army. Give your army a name and click on Create to confirm.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Das soll eine Armee sein? Ziemlich klein, oder?",
  
            :en_US => "Call that an army? Rather small, don't you think?",
                
          },
          :reward_text => {
            
            :de_DE => "Jede Armee benötigt einen Kommandopunkt in der Siedlung, aus der sie erstellt wird. und  Sie kann auch nur an ihrer Heimatsiedlung verstärkt werden.",
  
            :en_US => "Every army needs a command point in the settlement - that's where they receive their commands from. You can only reinforce your army at their home settlement.",
                
          },

          :requirement => {
            
            :quest => 'quest_settlement_button1',

          },

          :successor_quests => [9, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_fur,
                :amount => 150,
              },

              {
                :resource => :resource_cash,
                :amount => 1,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_warrior,
                :amount => 10,
              },

            ],

            :experience_reward => 300,

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

        },              #   END OF quest_army_create
        {               #   quest_build_1campfirelvl1
          :id                => 18,
          :symbolic_id       => :quest_build_1campfirelvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Campfire",
  
            :de_DE => "Lagerfeuer",
                
          },
          :task => {
            
            :en_US => "Build a campfire.",
  
            :de_DE => "Baue ein Lagerfeuer.",
                
          },
          :flavour => {
            
            :de_DE => "An Lagerfeuern treffen sich die Diplomaten, tauschen Nachrichten aus und schmieden Allianzen. Wäre doch schön, so etwas zu haben, oder?",
  
            :en_US => "Diplomats meet around the campfire to swap messages and forge alliances. It would be great to have someone like that, don't you think?
      ",
                
          },
          :description => {
            
            :de_DE => "<p>Lagerfeuer werden benötigt, um Allianzen zu gründen oder ihnen beizutreten. Außerdem wird hier der Kleine Häuptling rekrutiert.</p>",
  
            :en_US => "<p>Campfires are needed to start or enter alliances. They're also where little chieftans are recruited.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ach, wie das Feuer knistert. So schön warm.",
  
            :en_US => "Oh, listen to the fire crackling! Lovely warm flames!",
                
          },
          :reward_text => {
            
            :de_DE => "Versuch doch Deine Nachbarn zu kontaktieren und mit ihnen eine Allianz aufzubauen.",
  
            :en_US => "Try to contact your neighbors and form an alliance with them.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1storagelvl1',

          },

          :successor_quests => [4, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 75,
              },

              {
                :resource => :resource_wood,
                :amount => 75,
              },

              {
                :resource => :resource_cash,
                :amount => 3,
              },

            ],

            :experience_reward => 150,

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

        },              #   END OF quest_build_1campfirelvl1
        {               #   quest_alliance
          :id                => 19,
          :symbolic_id       => :quest_alliance,
          :advisor           => :girl,
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
            
            :de_DE => "Feindliche Armeen mit Deinen eigenen Armeen zu bekämpfen, ist ja nett. Aber viel besser wäre es doch, wenn ihr zusammenarbeiten würdet oder wenn Deine Freunde Dir helfen würden.",
  
            :en_US => "Fighting enemy armies with your own army is great, but it's even better if you have help from your friends or you can work together with other players. You should be in an alliance - allies are there to help each other.",
                
          },
          :description => {
            
            :de_DE => "<p>Ab jetzt kannst Du einer Allianz beitreten. Eine Allianz hat viele Vorteile, man tauscht Rohstoffe, hilft sich gegenseitig bei der Verteidigung und koordiniert Angriffe. Nur eine Allianz kann ein großes Territorium halten. Wenn Du Dich bereit fühlst, tritt doch einer bei.</p>",
  
            :en_US => "<p>From now on, you can enter an alliance. This has many advantages: you can exchange raw materials, help each other with defense and coordinate attacks. Only an alliance can hold a large territory.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hui, das ist aber eine tolle Allianz. Ich bin sicher, dass Ihr sehr weit kommen werdet.",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "Du kannst das Profil der Allianz einsehen, indem Du auf den Allianzwimpel oben rechts neben der Rohstoffübersicht klickst.",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1campfirelvl2',

          },

          :successor_quests => [131, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_clubbers,
                :amount => 10,
              },

            ],

            :experience_reward => 350,

          },          

          :reward_tests => {
            
            :alliance_test => {},

          },          

        },              #   END OF quest_alliance
        {               #   quest_resourcescore_0
          :id                => 20,
          :symbolic_id       => :quest_resourcescore_0,
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
            
            :en_US => "Increase the resource production of one settlement to 50 resource points.",
  
            :de_DE => "Steigere die Rohstoffproduktion einer Siedlung auf 50 Rohstoffpunkte.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut, wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, your settlements are looking fine, but it would be even better if they produced more resources. Could you do something about that?",
                
          },
          :description => {
            
            :de_DE => "<p>Weitere Jäger und Sammler helfen Dir dabei. Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert.</p>",
  
            :en_US => "<p>Having more Hunter Gatherers would be helpful right now. Stone, wood and fur are all worth one resource point.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.",
  
            :en_US => "The fortress takes up to 15% tax on the resource production of each settlement in the region.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1campfirelvl2',

          },

          :successor_quests => [21, 103, 134, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 450,
              },

              {
                :resource => :resource_wood,
                :amount => 450,
              },

              {
                :resource => :resource_fur,
                :amount => 450,
              },

            ],

            :experience_reward => 75,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 50,
            },

          },          

        },              #   END OF quest_resourcescore_0
        {               #   quest_build_chiefcottagelvl5
          :id                => 21,
          :symbolic_id       => :quest_build_chiefcottagelvl5,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Chieftan's hut level five",
  
            :de_DE => "Häuptlingshütte Level 5",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 5.",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 5 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Du bist wieder so weit Deine Häuptlingshütte auszubauen. Ein wenig Prunk kann nicht schaden, oder?",
  
            :en_US => "Hey, you're ready to upgrade your chieftan's hut again. A bit of style never hurt, right?",
                
          },
          :description => {
            
            :de_DE => "<p>Baue Deine Häuptlingshütte auf Level 5 aus. Ab Level 5 kannst Du die beiden spezialisierten Rohstoffproduzenten Steinbruch und Holzfäller bauen.</p>",
  
            :en_US => "<p>Once you've upgraded your chieftan's hut to Level 5 you can start to build quarries and carry out logging to improve your raw material production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll, wie weit Du schon gekommen bist. Weiter so!",
  
            :en_US => "Your progress so far has been awesome! Keep it up!",
                
          },
          :reward_text => {
            
            :de_DE => "Jetzt kannst Du die beiden spezialisierten Rohstoffproduzenten Steinbruch und Holzfäller bauen!",
  
            :en_US => "From now on, you can build quarries and loggers for specialized raw material production.",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_0',

          },

          :successor_quests => [22, 24, ],

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

            :experience_reward => 300,

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

          :place_npcs => 20,         

        },              #   END OF quest_build_chiefcottagelvl5
        {               #   quest_build_1quarrylvl2
          :id                => 22,
          :symbolic_id       => :quest_build_1quarrylvl2,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Quarry",
  
            :de_DE => "Steinbruch",
                
          },
          :task => {
            
            :en_US => "Build a quarry and a logging camp.",
  
            :de_DE => "Baue einen Steinbruch auf Level 2.",
                
          },
          :flavour => {
            
            :de_DE => "Hey cool, Du kannst Steinbrüche bauen.",
  
            :en_US => "Cool - you can now build quarries.",
                
          },
          :description => {
            
            :de_DE => "<p>Mit der Häuptlingshütte hast Du den Steinbruch freigeschaltet. Warte nicht, baue sofort einen auf Level 2.</p>",
  
            :en_US => "<p>Build a quarry level 2 to improve your production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "So viel Stein, wie toll.",
  
            :en_US => "Wow – that's a lot of stone. Fantastic!",
                
          },
          :reward_text => {
            
            :de_DE => "Steinbrüche sind sehr effektiv. Baue eine Viezahl davon.",
  
            :en_US => "Quarries are very effective. Build more quarries!",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl5',

          },

          :successor_quests => [23, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 137,
              },

              {
                :resource => :resource_wood,
                :amount => 274,
              },

              {
                :resource => :resource_cash,
                :amount => 1,
              },

            ],

            :experience_reward => 125,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_quarry',

                :min_level => 2,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1quarrylvl2
        {               #   quest_build_1loggerlvl2
          :id                => 23,
          :symbolic_id       => :quest_build_1loggerlvl2,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Logger",
  
            :de_DE => "Holzfäller",
                
          },
          :task => {
            
            :en_US => "Build a Level 2 logger.",
  
            :de_DE => "Baue einen Holzfäller Level 2.",
                
          },
          :flavour => {
            
            :de_DE => "Der Chef sagt immer: 'Ein Brett in Ehren kann niemand verwehren!'.",
  
            :en_US => "If you want to increase production, you'll need to build more quarries and logging camps and then upgrade them.",
                
          },
          :description => {
            
            :de_DE => "<p>Du kannst jetzt Holzfäller bauen. Holzfäller erhöhen Deine Holzproduktion deutlich stärker als Jäger und Sammler.</p>",
  
            :en_US => "<p>Upgrade the logger to level 2 to increase your production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na, das nenne ich mal Holz vor der Hütte!",
  
            :en_US => "Wow – look at your wood production. That's massive! ",
                
          },
          :reward_text => {
            
            :de_DE => "Achte auf Deine Lagerkapazität, sonst laufen die Lager in Deiner Abwesenheit über.",
  
            :en_US => "You will need more loggers.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1quarrylvl2',

          },

          :successor_quests => [37, 58, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 274,
              },

              {
                :resource => :resource_wood,
                :amount => 137,
              },

              {
                :resource => :resource_cash,
                :amount => 1,
              },

            ],

            :experience_reward => 125,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_logger',

                :min_level => 2,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1loggerlvl2
        {               #   quest_build_chiefcottagelvl6
          :id                => 24,
          :symbolic_id       => :quest_build_chiefcottagelvl6,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Chieftan's hut level 6",
  
            :de_DE => "Häuptlingshütte Level 6",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to Level 6.",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 6 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Ich brauche Raum für mein Ego!",
  
            :en_US => "I need room for my ego!",
                
          },
          :description => {
            
            :de_DE => "<p>Der Ausbau der Häuptlingshütte schaltet nicht nur vier neue Baugelände frei, mit Level 6 steht Dir auch die Trainingshöhle zur Verfügung. Speziell für Halbgötter!</p>",
  
            :en_US => "<p>Upgrading the chieftan's hut gives you four new building slots. At Level 6, you also get access to the training cave, especially made for demigods such as yourself!</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na endlich, endlich habe ich Platz zur Entfaltung! Da geht aber noch mehr, oder?",
  
            :en_US => "At least, more room for my great personality.",
                
          },
          :reward_text => {
            
            :de_DE => "Mit Level 6 der Häuptlingshütte hast Du auch einen 2ten Kommandopunkt erhalten. Du kannst jetzt eine weitere Armee aufstellen.",
  
            :en_US => "Having a chieftan's hut at Level 6 gives you one more command point, which means you can now levy another army. Build your campfire to Level 10.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl5',

          },

          :successor_quests => [25, 26, 28, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 900,
              },

              {
                :resource => :resource_wood,
                :amount => 900,
              },

              {
                :resource => :resource_fur,
                :amount => 900,
              },

            ],

            :experience_reward => 350,

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

        },              #   END OF quest_build_chiefcottagelvl6
        {               #   quest_build_training_cave
          :id                => 25,
          :symbolic_id       => :quest_build_training_cave,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Training cave",
  
            :de_DE => "Trainingshöhle",
                
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
            
            :de_DE => "<p>In der Trainingshöhle kannst Du ungestört trainieren und Erfahrung sammeln.</p>",
  
            :en_US => "<p>It takes time to execute building orders, but the work will continue while you're away if you leave the game.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ein - zwei, eins - zwei, keine Müdigkeit vortäuschen!",
  
            :en_US => "One and two, one and two! Come on, this is fun!",
                
          },
          :reward_text => {
            
            :de_DE => "In der Trainingshöhle kannst Du ungestört trainieren und Erfahrung sammeln",
  
            :en_US => "You can do your workout in the training cave without any interruptions.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl6',

          },

          :successor_quests => [],

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

              {
                :resource => :resource_fur,
                :amount => 116,
              },

            ],

            :experience_reward => 500,

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
        {               #   quest_build_chiefcottagelvl7
          :id                => 26,
          :symbolic_id       => :quest_build_chiefcottagelvl7,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Upgrade the chieftan's hut",
  
            :de_DE => "Häuptlingshütte Level 7",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to Level 7.",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 7 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Halbgott? Ich brauche einen Raum, in dem ich Gäste empfangen kann. Verstanden?",
  
            :en_US => "Demigod? I need somewhere for my guests to stay. Got it?",
                
          },
          :description => {
            
            :de_DE => "<p>Weitere vier Bauplätze und die Möglichkeit einen Artefakt Stand zu bauen.</p>",
  
            :en_US => "<p>You have four new building slots and the option to build an artifact stand.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ähm? So klein? Wie soll ich denn da einen ordentlichen Empfang veranstalten? Allein die Nachbarn kommen mit über zwanzig Leuten...",
  
            :en_US => "Hmm? That small? It's impossible to seat all of our guests in here… there are at least twenty neighbours to invite!",
                
          },
          :reward_text => {
            
            :de_DE => "Jetzt kannst Du einen Artefakt Stand bauen. Nur mit einem Artfakt Stand kannst Du ein erobertes Artefakt in einem Ritual initiieren.",
  
            :en_US => "You can now build an artifact stand. That's great!",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl6',

          },

          :successor_quests => [27, 29, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 1600,
              },

              {
                :resource => :resource_wood,
                :amount => 1600,
              },

              {
                :resource => :resource_fur,
                :amount => 1600,
              },

            ],

            :experience_reward => 450,

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

        },              #   END OF quest_build_chiefcottagelvl7
        {               #   quest_fortress
          :id                => 27,
          :symbolic_id       => :quest_fortress,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Fortress ",
  
            :de_DE => "Festung erobern",
                
          },
          :task => {
            
            :en_US => "Conquer a fortress.",
  
            :de_DE => "Erobere eine Festung.",
                
          },
          :flavour => {
            
            :de_DE => "Wir brauchen mehr Siedlungen! So eine Festung wäre genau das richtige.",
  
            :en_US => "We need more settlements. A fortress would be the way to go.",
                
          },
          :description => {
            
            :de_DE => "<p>Um eine Festung in Deinen Besitz zu bringen musst Du die Festung angreifen. Dafür benötigst Du eine große Armee. Du kannst sowohl die Festung im Besitz von Neandertalern als auch von Spielern angreifen. Neandertaler sind dabei nicht nachtragend.</p>",
  
            :en_US => "<p>You have to attack the fortress, and to do that you'll need a bigger army. You can attack both neanderthals and other players, but a neanderthal might be a good option for a first attack.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Du hast eine Festung in Deinen Besitz gebracht? Das ist großartig!",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "In der Festung kannst Du Steuern erheben und den Steuersatz ändern. Die Festung ist auch Standort einer weiteren Armee.",
  
            :en_US => "You can edit the tax rate in the fortress. A fortress is another army garrison.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl7',

          },

          :successor_quests => [],

          :rewards => {
            
            :unit_rewards => [

              {
                :unit => :unit_clubbers,
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
        {               #   quest_build_1barrackslvl5
          :id                => 28,
          :symbolic_id       => :quest_build_1barrackslvl5,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Training Grounds level 5",
  
            :de_DE => "Ausbildungsgelände Level 5",
                
          },
          :task => {
            
            :en_US => "Upgrade your training grounds to Level 5.",
  
            :de_DE => "Baue ein Ausbildungsgelände auf Level 5.",
                
          },
          :flavour => {
            
            :de_DE => "Nur mit Kriegern können wir uns nicht behaupten! Wir brauchen auch die Keulenkrieger. Es mag lange dauern, aber sorge für den Ausbau des Ausbildungsgeländes.",
  
            :en_US => "If we're going to stand our ground, we need some clubbers! It might take a while, but make sure you upgrade the training grounds.",
                
          },
          :description => {
            
            :de_DE => "<p>Auf Level 5 können im Ausbildungsgelände die Keulenkrieger ausgebildet werden.</p>",
  
            :en_US => "<p>At Level 5, clubbers can be trained in the training grounds.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Sehr gut. Jetzt sind wir endlcih die Möchtegern-Krieger los.",
  
            :en_US => "Thank you Demigod. They may not be the brightest crayons in the box, but clubbers can take a lot of punishment – and hand it out too! ",
                
          },
          :reward_text => {
            
            :de_DE => "Der Keulenkrieger! Mehr Kraft für Deine Nahkämpfer.",
  
            :en_US => "TA clubber is born! This is great reinforcement for your melee fighters.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl6',

          },

          :successor_quests => [126, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 800,
              },

              {
                :resource => :resource_wood,
                :amount => 400,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_clubbers,
                :amount => 20,
              },

            ],

            :experience_reward => 400,

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

        },              #   END OF quest_build_1barrackslvl5
        {               #   quest_build_chiefcottagelvl8
          :id                => 29,
          :symbolic_id       => :quest_build_chiefcottagelvl8,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Upgrade of the chieftan's hut",
  
            :de_DE => "Häuptlingshütte Level 8",
                
          },
          :task => {
            
            :en_US => "Upgrade of the chieftan's hut to level 8.",
  
            :de_DE => "Erweitere die Häuptlingshütte auf Level 8.",
                
          },
          :flavour => {
            
            :de_DE => "Behalte Deine Rohstoffproduktion im Auge. Mehr ist immer besser!",
  
            :en_US => "Keep an eye on your raw materials production. More is better!",
                
          },
          :description => {
            
            :de_DE => "<p>Mit dem nächsten Level hast Du Zugang zum Kürschner und kannst Deine Fellproduktion deutlich verbessern.</p>",
  
            :en_US => "<p>At this level you'll be able to make use of a furrier, which will allow you to massively increase your fur production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Sehr schön! Endlich hast Du den Kürschner erreicht!",
  
            :en_US => "Cool, you get accesss to the furrier!",
                
          },
          :reward_text => {
            
            :de_DE => "Jetzt hast Du den Kürschner freigeschaltet.",
  
            :en_US => "You’ve now got a furrier.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl7',

          },

          :successor_quests => [30, 31, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 2500,
              },

              {
                :resource => :resource_wood,
                :amount => 2500,
              },

              {
                :resource => :resource_fur,
                :amount => 2500,
              },

            ],

            :experience_reward => 500,

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

          :place_npcs => 100,         

        },              #   END OF quest_build_chiefcottagelvl8
        {               #   quest_build_1furrierlvl2
          :id                => 30,
          :symbolic_id       => :quest_build_1furrierlvl2,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Furrier",
  
            :de_DE => "Kürschner",
                
          },
          :task => {
            
            :en_US => "Build a Level 2 furrier.",
  
            :de_DE => "Baue einen Kürschner auf Level 2.",
                
          },
          :flavour => {
            
            :de_DE => "Chef will die Felle für die Armee Rekrutierung, aber für mich fällt doch bestimmt auch was schönes ab, oder?",
  
            :en_US => "The chief wants an army, but I'd just like some nice new clothes.",
                
          },
          :description => {
            
            :de_DE => "<p>Eine hohe Fellproduktion ist die Grundlage jeder größeren Armee. In den Kämpfen werden immer mal wieder Armeen aufgerieben, die gilt es nachzubauen.</p>",
  
            :en_US => "<p>You need good fur production if you want to recruit an impressive army.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, jetzt kannst Du Chef mit dem Bau einer Armee erfreuen. Und mir was nettes schenken.",
  
            :en_US => "Nice! Now you can build a new army.",
                
          },
          :reward_text => {
            
            :de_DE => "Steigere Deine Fellproduktion laufend weiter. Mit dem Besitz von Festungen oder Lagerstätten steigen auch Deine Kosten für die Verteidigung.",
  
            :en_US => "Increase your fur production so that you can defend your settlements with more armies.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl8',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 137,
              },

              {
                :resource => :resource_wood,
                :amount => 137,
              },

              {
                :resource => :resource_fur,
                :amount => 137,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_furrier',

                :min_level => 2,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1furrierlvl2
        {               #   quest_build_chiefcottagelvl9
          :id                => 31,
          :symbolic_id       => :quest_build_chiefcottagelvl9,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Upgrade of the chieftan's hut",
  
            :de_DE => "Häuptlingshütte Level 9",
                
          },
          :task => {
            
            :en_US => "Upgrade of the chieftan's hut to level 9.",
  
            :de_DE => "Erweitere die Häuptlingshütte auf Level 9.",
                
          },
          :flavour => {
            
            :de_DE => "Jetzt hast Du bereits 32 Deiner maximal 40 Bauplätze freigeschaltet.",
  
            :en_US => "You've now got 32 of your 40 building slots.",
                
          },
          :description => {
            
            :de_DE => "<p>Die Häuptlingshütte ausbauen bringt Dir weitere 4 Bauplätze.</p>",
  
            :en_US => "<p>At this level you'll get four new building slots.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Wunderbar, selbst der Chef ist fast zufrieden.",
  
            :en_US => "Nice work. Even the chief is pleased. And let's face it, that never happens.",
                
          },
          :reward_text => {
            
            :de_DE => "Jetzt hast Du den Kürschner freigeschaltet.",
  
            :en_US => "You've now got a furrier.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl8',

          },

          :successor_quests => [32, 33, ],

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
                :amount => 3000,
              },

            ],

            :experience_reward => 650,

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
        {               #   quest_outpost
          :id                => 32,
          :symbolic_id       => :quest_outpost,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Encampment",
  
            :de_DE => "Lagerstätte",
                
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
            
            :de_DE => "<p>Um eine Lagerstätte zu gründen, musst Du das Lagerfeuer auf Level 10 ausgebaut haben, um dort einen Kleinen Häuptling auszu bilden. Mit dem Kleinen Häuptling musst Du Deine Armee zu einem freien Siedlungsort bewegen.</p><p>Du kannst allerdings nur eine Lagerstätte pro Region haben und benötigst für die Gründung einer Siedlung einen freien Siedlungspunkt.</p>",
  
            :en_US => "<p>To start an encampment you need to train a little chieftan at campfire Level 10 and move both him and an army to a free field. You can only have one encampment per region and you'll need a free settlement point.</p><p>But you can only have one encampment per region, and you need a free settlement point.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Du hast eine Lagerstätte gegründet? Brauchst Du immer so lange für einfache Aufgaben? Hier, nimm die Rohstoffe und geh mir aus den Augen.",
  
            :en_US => "You've started an encampment? Do you always take this long to complete a simple task? Here – take the raw materials and get lost.",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl9',

          },

          :successor_quests => [],

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

            :experience_reward => 750,

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
        {               #   quest_build_chiefcottagelvl10
          :id                => 33,
          :symbolic_id       => :quest_build_chiefcottagelvl10,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Upgrade of the chieftan's hut",
  
            :de_DE => "Häuptlingshütte Level 10",
                
          },
          :task => {
            
            :en_US => "Upgrade of the chieftan's hut to level 10.",
  
            :de_DE => "Erweitere die Häuptlingshütte auf Level 10.",
                
          },
          :flavour => {
            
            :de_DE => "Jetzt hat Deine Hauptsiedlung die volle Größe!",
  
            :en_US => "You've got all 40 building slots now. Great job!",
                
          },
          :description => {
            
            :de_DE => "<p>Mit Level 10 der Häuptlingshütte wirst Du alle 40 Bauplätze Deiner Hauptsiedlung freigeschaltet haben.</p>",
  
            :en_US => "<p>When your chieftan's hut gets to Level 10, all 40 building slots will be unlocked.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Das wurde wirklich Zeit! Jetzt hat Deine Hauptsiedlung die volle Größe!",
  
            :en_US => "It´s about time! Now we have all the space we need!",
                
          },
          :reward_text => {
            
            :de_DE => "<p>Die Häuptlingshütte kann bis Level 20 ausgebaut werden. Jeder Level steigert den Kampfbonus.</p>
        <p>Auf Level 12 und 20 bekommst Du je einen weiteren Kommandopunkt für eine zusätzliche Armee.</p>",
  
            :en_US => "<p>The maximum level for a chieftan's hut is Level 20.  Each level increases the battle bonus you can get. At Level 12 and 20 you'll receive a command point for another army.</p>",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl9',

          },

          :successor_quests => [34, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 4000,
              },

              {
                :resource => :resource_wood,
                :amount => 4000,
              },

              {
                :resource => :resource_fur,
                :amount => 4000,
              },

            ],

            :experience_reward => 800,

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
          :id                => 34,
          :symbolic_id       => :quest_build_copper_smelter,
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
            
            :en_US => "Build a copper smelter.",
  
            :de_DE => "Baue eine Kupferschmelze.",
                
          },
          :flavour => {
            
            :de_DE => "In der Kupferzeit stehen Dir neue Gebäude und verbesserte Versionen bereits bekannter Gebäude zur Verfügung.",
  
            :en_US => "In the Copper Age, you can create new buildings as well as improved versions of the buildings you already know.",
                
          },
          :description => {
            
            :de_DE => "<p>Die Kupferschmelze ist ein kleines Gebäude für einen kleinen Bauplatz, sie ermöglicht Dir den Bau der Gebäude der Kupferzeit.</p>",
  
            :en_US => "<p>A copper smelter can be created in a small building slot. It gives you acces to buildings from the Copper Age.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Wow, eine neues Zeitalter! So viele Möglichkeiten.",
  
            :en_US => "Wow, a new age! So many opportunities! ",
                
          },
          :reward_text => {
            
            :de_DE => "Sollen wir die Steinzeit verlassen und in die Kupferzeit fortschreiten?",
  
            :en_US => "So, should we leave the Stone Age and move forward to the Copper Age?",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl10',

          },

          :successor_quests => [35, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 3750,
              },

              {
                :resource => :resource_wood,
                :amount => 3750,
              },

              {
                :resource => :resource_fur,
                :amount => 3750,
              },

            ],

            :experience_reward => 900,

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
        {               #   quest_build_firing_range
          :id                => 35,
          :symbolic_id       => :quest_build_firing_range,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Firing Range",
  
            :de_DE => "Schießstand",
                
          },
          :task => {
            
            :en_US => "Build a firing range.",
  
            :de_DE => "Baue einen Schießstand.",
                
          },
          :flavour => {
            
            :de_DE => "Die Nahkämpfer brauchen Unterstützung! Wir brauchen einen Schießstand um Fernkämpfer auszubilden.",
  
            :en_US => "The melee need support, so we need a firing range. Once we have that, we can recruit a thrower.",
                
          },
          :description => {
            
            :de_DE => "<p>Dir steht jetzt der Schießstand zur Verfügung. Baue einen um Fernkämpfer ausbilden zu können.</p>",
  
            :en_US => "<p>You have unlocked the firing range. Build one and then recruit a thrower.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Wunderbar, dann werde ich gleich mal ein paar Rekruten anschreien.",
  
            :en_US => "Wonderful! And now they'll have the chance to know their drill instructor.",
                
          },
          :reward_text => {
            
            :de_DE => "Mit den Fernkämpfer wird Deine Armee deutlich stärker. Doch hüte Dich vor berittenen Einheiten.",
  
            :en_US => "Keep an eye on your raw materials production. Upgrading your Hunter Gatherers is always worthwhile.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_copper_smelter',

          },

          :successor_quests => [36, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 2000,
              },

              {
                :resource => :resource_wood,
                :amount => 4000,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_thrower,
                :amount => 30,
              },

            ],

            :experience_reward => 750,

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
        {               #   quest_build_stud
          :id                => 36,
          :symbolic_id       => :quest_build_stud,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Smelly barn",
  
            :de_DE => "Stinkender Stall",
                
          },
          :task => {
            
            :en_US => "Build a smelly barn.",
  
            :de_DE => "Baue einen Stinkenden Stall.",
                
          },
          :flavour => {
            
            :de_DE => "Jetzt fehlen uns nur noch die berittenen Einheiten, um uns auch gegen die gegnerischen Fernkämpfer behaupten zu können.",
  
            :en_US => "We need a cavalry to defend ourselves against throwers.",
                
          },
          :description => {
            
            :de_DE => "<p>Bau die Kupferschmelze weiter aus, auf Level 5 steht dir der stinkende Stall zur Verfügung.</p>",
  
            :en_US => "<p>Keep upgrading the copper smelter. At Level 5, you can unlock the smelly barn.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Muhaha, I don't like the smell, but I've got admit… those riders know what they're doing.",
  
            :en_US => "Muhaha, I don´t like the smell, but the riders know thier business.",
                
          },
          :reward_text => {
            
            :de_DE => "Berittene Einheiten können mit Flankenangriffen die gegnerischen Nahkämpfer umgehen und Fernkämpfer direkt angreifen. Zudem sind sie als Reiterarmee schneller als normalen Kämpfer.",
  
            :en_US => "A cavalry can flank the melee and attack throwers directly. A riding army is also quicker than normal warriors.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_firing_range',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 4000,
              },

              {
                :resource => :resource_wood,
                :amount => 2000,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_light_cavalry,
                :amount => 30,
              },

            ],

            :experience_reward => 1000,

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

        },              #   END OF quest_build_stud
        {               #   quest_charkills_1
          :id                => 37,
          :symbolic_id       => :quest_charkills_1,
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
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1loggerlvl2',

          },

          :successor_quests => [38, ],

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

            :experience_reward => 25,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 10,
            },

          },          

        },              #   END OF quest_charkills_1
        {               #   quest_charkills_2
          :id                => 38,
          :symbolic_id       => :quest_charkills_2,
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
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_1',

          },

          :successor_quests => [39, ],

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

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 100,
            },

          },          

        },              #   END OF quest_charkills_2
        {               #   quest_charkills_3
          :id                => 39,
          :symbolic_id       => :quest_charkills_3,
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
            
            :en_US => "Defeat 500 units.",
  
            :de_DE => "Besiege 500 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_2',

          },

          :successor_quests => [40, ],

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
                :amount => 1000,
              },

            ],

            :experience_reward => 320,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 500,
            },

          },          

        },              #   END OF quest_charkills_3
        {               #   quest_charkills_4
          :id                => 40,
          :symbolic_id       => :quest_charkills_4,
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
            
            :en_US => "Defeat 1,000 units.",
  
            :de_DE => "Besiege 1.000 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_3',

          },

          :successor_quests => [41, ],

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
                :amount => 1500,
              },

            ],

            :experience_reward => 500,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 1000,
            },

          },          

        },              #   END OF quest_charkills_4
        {               #   quest_charkills_5
          :id                => 41,
          :symbolic_id       => :quest_charkills_5,
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
            
            :en_US => "Defeat 5,000 units.",
  
            :de_DE => "Besiege 5.000 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste (oben links im Menü der Knopf mit dem Pokal) kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "YThings are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_4',

          },

          :successor_quests => [42, ],

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
                :amount => 2000,
              },

            ],

            :experience_reward => 720,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 5000,
            },

          },          

        },              #   END OF quest_charkills_5
        {               #   quest_charkills_6
          :id                => 42,
          :symbolic_id       => :quest_charkills_6,
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
            
            :en_US => "Defeat 10,000 units.",
  
            :de_DE => "Besiege 10.000 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_5',

          },

          :successor_quests => [43, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 2500,
              },

              {
                :resource => :resource_wood,
                :amount => 2500,
              },

              {
                :resource => :resource_fur,
                :amount => 2500,
              },

            ],

            :experience_reward => 980,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 10000,
            },

          },          

        },              #   END OF quest_charkills_6
        {               #   quest_charkills_7
          :id                => 43,
          :symbolic_id       => :quest_charkills_7,
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
            
            :en_US => "Defeat 20,000 units.",
  
            :de_DE => "Besiege 20.000 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_6',

          },

          :successor_quests => [44, ],

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
                :amount => 3000,
              },

            ],

            :experience_reward => 1280,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 20000,
            },

          },          

        },              #   END OF quest_charkills_7
        {               #   quest_charkills_8
          :id                => 44,
          :symbolic_id       => :quest_charkills_8,
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
            
            :en_US => "Defeat 25,850 units.",
  
            :de_DE => "Besiege 25.850 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_7',

          },

          :successor_quests => [45, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 3750,
              },

              {
                :resource => :resource_wood,
                :amount => 3750,
              },

              {
                :resource => :resource_fur,
                :amount => 3750,
              },

            ],

            :experience_reward => 1620,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 25850,
            },

          },          

        },              #   END OF quest_charkills_8
        {               #   quest_charkills_9
          :id                => 45,
          :symbolic_id       => :quest_charkills_9,
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
            
            :en_US => "Defeat 32,650 units.",
  
            :de_DE => "Besiege 32.650 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_8',

          },

          :successor_quests => [46, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 4250,
              },

              {
                :resource => :resource_wood,
                :amount => 4250,
              },

              {
                :resource => :resource_fur,
                :amount => 4250,
              },

            ],

            :experience_reward => 2000,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 32650,
            },

          },          

        },              #   END OF quest_charkills_9
        {               #   quest_charkills_10
          :id                => 46,
          :symbolic_id       => :quest_charkills_10,
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
            
            :en_US => "Defeat 40,250 units.",
  
            :de_DE => "Besiege 40.250 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_9',

          },

          :successor_quests => [47, ],

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
                :amount => 5000,
              },

            ],

            :experience_reward => 2420,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 40250,
            },

          },          

        },              #   END OF quest_charkills_10
        {               #   quest_charkills_11
          :id                => 47,
          :symbolic_id       => :quest_charkills_11,
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
            
            :en_US => "Defeat 48,650 units.",
  
            :de_DE => "Besiege 48.650 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_10',

          },

          :successor_quests => [48, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 5500,
              },

              {
                :resource => :resource_wood,
                :amount => 5500,
              },

              {
                :resource => :resource_fur,
                :amount => 5500,
              },

            ],

            :experience_reward => 2880,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 48650,
            },

          },          

        },              #   END OF quest_charkills_11
        {               #   quest_charkills_12
          :id                => 48,
          :symbolic_id       => :quest_charkills_12,
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
            
            :en_US => "Defeat 57,850 units.",
  
            :de_DE => "Besiege 57.850 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_11',

          },

          :successor_quests => [49, ],

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

            :experience_reward => 3380,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 57850,
            },

          },          

        },              #   END OF quest_charkills_12
        {               #   quest_charkills_13
          :id                => 49,
          :symbolic_id       => :quest_charkills_13,
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
            
            :en_US => "Defeat 67,850 units.",
  
            :de_DE => "Besiege 67.850 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_12',

          },

          :successor_quests => [50, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 6500,
              },

              {
                :resource => :resource_wood,
                :amount => 6500,
              },

              {
                :resource => :resource_fur,
                :amount => 6500,
              },

            ],

            :experience_reward => 3920,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 67850,
            },

          },          

        },              #   END OF quest_charkills_13
        {               #   quest_charkills_14
          :id                => 50,
          :symbolic_id       => :quest_charkills_14,
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
            
            :en_US => "Defeat 78,650 units.",
  
            :de_DE => "Besiege 78.650 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_13',

          },

          :successor_quests => [51, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 7000,
              },

              {
                :resource => :resource_wood,
                :amount => 7000,
              },

              {
                :resource => :resource_fur,
                :amount => 7000,
              },

            ],

            :experience_reward => 4500,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 78650,
            },

          },          

        },              #   END OF quest_charkills_14
        {               #   quest_charkills_15
          :id                => 51,
          :symbolic_id       => :quest_charkills_15,
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
            
            :en_US => "Defeat 90,250 units.",
  
            :de_DE => "Besiege 90.250 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_14',

          },

          :successor_quests => [52, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 7500,
              },

              {
                :resource => :resource_wood,
                :amount => 7500,
              },

              {
                :resource => :resource_fur,
                :amount => 7500,
              },

            ],

            :experience_reward => 5120,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 90250,
            },

          },          

        },              #   END OF quest_charkills_15
        {               #   quest_charkills_16
          :id                => 52,
          :symbolic_id       => :quest_charkills_16,
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
            
            :en_US => "Defeat 102,650 units.",
  
            :de_DE => "Besiege 102.650 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_15',

          },

          :successor_quests => [53, ],

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
                :resource => :resource_fur,
                :amount => 8000,
              },

            ],

            :experience_reward => 5780,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 102650,
            },

          },          

        },              #   END OF quest_charkills_16
        {               #   quest_charkills_17
          :id                => 53,
          :symbolic_id       => :quest_charkills_17,
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
            
            :en_US => "Defeat 115,850 units.",
  
            :de_DE => "Besiege 115.850 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_16',

          },

          :successor_quests => [54, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 8500,
              },

              {
                :resource => :resource_wood,
                :amount => 8500,
              },

              {
                :resource => :resource_fur,
                :amount => 8500,
              },

            ],

            :experience_reward => 6480,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 115850,
            },

          },          

        },              #   END OF quest_charkills_17
        {               #   quest_charkills_18
          :id                => 54,
          :symbolic_id       => :quest_charkills_18,
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
            
            :en_US => "Defeat 129,850 units.",
  
            :de_DE => "Besiege 129.850 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_17',

          },

          :successor_quests => [55, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 9000,
              },

              {
                :resource => :resource_wood,
                :amount => 9000,
              },

              {
                :resource => :resource_fur,
                :amount => 9000,
              },

            ],

            :experience_reward => 7220,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 129850,
            },

          },          

        },              #   END OF quest_charkills_18
        {               #   quest_charkills_19
          :id                => 55,
          :symbolic_id       => :quest_charkills_19,
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
            
            :en_US => "Defeat 144,640 units.",
  
            :de_DE => "Besiege 144.640 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_18',

          },

          :successor_quests => [56, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 9500,
              },

              {
                :resource => :resource_wood,
                :amount => 9500,
              },

              {
                :resource => :resource_fur,
                :amount => 9500,
              },

            ],

            :experience_reward => 8000,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 144640,
            },

          },          

        },              #   END OF quest_charkills_19
        {               #   quest_charkills_20
          :id                => 56,
          :symbolic_id       => :quest_charkills_20,
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
            
            :en_US => "Defeat 160,250 units.",
  
            :de_DE => "Besiege 160.250 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_19',

          },

          :successor_quests => [57, ],

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

            :experience_reward => 10000,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 160250,
            },

          },          

        },              #   END OF quest_charkills_20
        {               #   quest_charkills_21
          :id                => 57,
          :symbolic_id       => :quest_charkills_21,
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
            
            :en_US => "Defeat 500,000 units.",
  
            :de_DE => "Besiege 500.000 Einheiten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Feinde sind stark, ändere das! Vernichte ihre Einheiten. Das wird sie schwächen.",
  
            :en_US => "Your enemies are strong - that has to change! Destroy their units. That will weaken them.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Rangliste kannst Du sehen, wie viele Einheiten Du schon besiegt hast.</p>",
  
            :en_US => "<p>You can check how many Units you have already killed by visiting the Ranking.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ha, das gefällt mir. Deine Feinde sind dezimiert und zittern vor Angst, wenn jemand Deinen Namen sagt.",
  
            :en_US => "Things are going extremely well. Your enemies are counting their losses and they cower in fear when someone mentions your name. I like it.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du einen Kampf gewinnst, bekommst Du für jede besiegte Einheit Erfahrung.",
  
            :en_US => "If you win a fight, you will be rewarded for each enemy unit killed.",
                
          },

          :requirement => {
            
            :quest => 'quest_charkills_20',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 15000,
              },

              {
                :resource => :resource_wood,
                :amount => 15000,
              },

              {
                :resource => :resource_fur,
                :amount => 15000,
              },

            ],

            :experience_reward => 15000,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 500000,
            },

          },          

        },              #   END OF quest_charkills_21
        {               #   quest_armyXP_1
          :id                => 58,
          :symbolic_id       => :quest_armyXP_1,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 10 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 10 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee für jede Einheit, die sie verliert. Du kannst die Erfahrung Deiner Armeen in der Armee-Info ablesen.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1loggerlvl2',

          },

          :successor_quests => [59, ],

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

            :experience_reward => 20,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 10,
            },

          },          

        },              #   END OF quest_armyXP_1
        {               #   quest_armyXP_2
          :id                => 59,
          :symbolic_id       => :quest_armyXP_2,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 80 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 80 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert. Du kannst die Erfahrung Deiner Armeen in der Armee-Info ablesen.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_1',

          },

          :successor_quests => [60, ],

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

            :experience_reward => 80,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 80,
            },

          },          

        },              #   END OF quest_armyXP_2
        {               #   quest_armyXP_3
          :id                => 60,
          :symbolic_id       => :quest_armyXP_3,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 200 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 200 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert. Du kannst die Erfahrung Deiner Armeen in der Armee-Info ablesen.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_2',

          },

          :successor_quests => [61, ],

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
                :amount => 1000,
              },

            ],

            :experience_reward => 180,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 200,
            },

          },          

        },              #   END OF quest_armyXP_3
        {               #   quest_armyXP_4
          :id                => 61,
          :symbolic_id       => :quest_armyXP_4,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 500 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 500 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert. Du kannst die Erfahrung Deiner Armeen in der Armee-Info ablesen.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_3',

          },

          :successor_quests => [62, ],

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
                :amount => 1500,
              },

            ],

            :experience_reward => 320,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 500,
            },

          },          

        },              #   END OF quest_armyXP_4
        {               #   quest_armyXP_5
          :id                => 62,
          :symbolic_id       => :quest_armyXP_5,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 1,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 1.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_4',

          },

          :successor_quests => [63, ],

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
                :amount => 2000,
              },

            ],

            :experience_reward => 500,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 1000,
            },

          },          

        },              #   END OF quest_armyXP_5
        {               #   quest_armyXP_6
          :id                => 63,
          :symbolic_id       => :quest_armyXP_6,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 2,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 2.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_5',

          },

          :successor_quests => [64, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 2500,
              },

              {
                :resource => :resource_wood,
                :amount => 2500,
              },

              {
                :resource => :resource_fur,
                :amount => 2500,
              },

            ],

            :experience_reward => 720,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 2000,
            },

          },          

        },              #   END OF quest_armyXP_6
        {               #   quest_armyXP_7
          :id                => 64,
          :symbolic_id       => :quest_armyXP_7,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 4,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 4.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_6',

          },

          :successor_quests => [65, ],

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
                :amount => 3000,
              },

            ],

            :experience_reward => 980,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 4000,
            },

          },          

        },              #   END OF quest_armyXP_7
        {               #   quest_armyXP_8
          :id                => 65,
          :symbolic_id       => :quest_armyXP_8,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 6,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 6.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_7',

          },

          :successor_quests => [66, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 3500,
              },

              {
                :resource => :resource_wood,
                :amount => 3500,
              },

              {
                :resource => :resource_fur,
                :amount => 3500,
              },

            ],

            :experience_reward => 1280,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 6000,
            },

          },          

        },              #   END OF quest_armyXP_8
        {               #   quest_armyXP_9
          :id                => 66,
          :symbolic_id       => :quest_armyXP_9,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 10,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 10.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_8',

          },

          :successor_quests => [67, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 4000,
              },

              {
                :resource => :resource_wood,
                :amount => 4000,
              },

              {
                :resource => :resource_fur,
                :amount => 4000,
              },

            ],

            :experience_reward => 1620,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 10000,
            },

          },          

        },              #   END OF quest_armyXP_9
        {               #   quest_armyXP_10
          :id                => 67,
          :symbolic_id       => :quest_armyXP_10,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 15,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 15.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_9',

          },

          :successor_quests => [68, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 4500,
              },

              {
                :resource => :resource_wood,
                :amount => 4500,
              },

              {
                :resource => :resource_fur,
                :amount => 4500,
              },

            ],

            :experience_reward => 2000,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 15000,
            },

          },          

        },              #   END OF quest_armyXP_10
        {               #   quest_armyXP_11
          :id                => 68,
          :symbolic_id       => :quest_armyXP_11,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 22,500 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 22.500 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_10',

          },

          :successor_quests => [69, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 5500,
              },

              {
                :resource => :resource_wood,
                :amount => 5500,
              },

              {
                :resource => :resource_fur,
                :amount => 5500,
              },

            ],

            :experience_reward => 2420,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 22500,
            },

          },          

        },              #   END OF quest_armyXP_11
        {               #   quest_armyXP_12
          :id                => 69,
          :symbolic_id       => :quest_armyXP_12,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 30,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 30.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_11',

          },

          :successor_quests => [70, ],

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

            :experience_reward => 2880,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 30000,
            },

          },          

        },              #   END OF quest_armyXP_12
        {               #   quest_armyXP_13
          :id                => 70,
          :symbolic_id       => :quest_armyXP_13,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 40,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 40.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "WWith each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_12',

          },

          :successor_quests => [71, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 6500,
              },

              {
                :resource => :resource_wood,
                :amount => 6500,
              },

              {
                :resource => :resource_fur,
                :amount => 6500,
              },

            ],

            :experience_reward => 3380,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 40000,
            },

          },          

        },              #   END OF quest_armyXP_13
        {               #   quest_armyXP_14
          :id                => 71,
          :symbolic_id       => :quest_armyXP_14,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 50,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 50.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_13',

          },

          :successor_quests => [72, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 7000,
              },

              {
                :resource => :resource_wood,
                :amount => 7000,
              },

              {
                :resource => :resource_fur,
                :amount => 7000,
              },

            ],

            :experience_reward => 3920,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 50000,
            },

          },          

        },              #   END OF quest_armyXP_14
        {               #   quest_armyXP_15
          :id                => 72,
          :symbolic_id       => :quest_armyXP_15,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 60,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 60.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_14',

          },

          :successor_quests => [73, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 7500,
              },

              {
                :resource => :resource_wood,
                :amount => 7500,
              },

              {
                :resource => :resource_fur,
                :amount => 7500,
              },

            ],

            :experience_reward => 4500,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 60000,
            },

          },          

        },              #   END OF quest_armyXP_15
        {               #   quest_armyXP_16
          :id                => 73,
          :symbolic_id       => :quest_armyXP_16,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 72,500 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 72.500 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_15',

          },

          :successor_quests => [74, ],

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
                :resource => :resource_fur,
                :amount => 8000,
              },

            ],

            :experience_reward => 5120,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 72500,
            },

          },          

        },              #   END OF quest_armyXP_16
        {               #   quest_armyXP_17
          :id                => 74,
          :symbolic_id       => :quest_armyXP_17,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 85,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 85.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_16',

          },

          :successor_quests => [75, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 8500,
              },

              {
                :resource => :resource_wood,
                :amount => 8500,
              },

              {
                :resource => :resource_fur,
                :amount => 8500,
              },

            ],

            :experience_reward => 5780,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 85000,
            },

          },          

        },              #   END OF quest_armyXP_17
        {               #   quest_armyXP_18
          :id                => 75,
          :symbolic_id       => :quest_armyXP_18,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 100,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 100.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_17',

          },

          :successor_quests => [76, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 9000,
              },

              {
                :resource => :resource_wood,
                :amount => 9000,
              },

              {
                :resource => :resource_fur,
                :amount => 9000,
              },

            ],

            :experience_reward => 6480,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 100000,
            },

          },          

        },              #   END OF quest_armyXP_18
        {               #   quest_armyXP_19
          :id                => 76,
          :symbolic_id       => :quest_armyXP_19,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 150,000 Army Experience points.",
  
            :de_DE => "Kämpfe bis Du 150.000 Armee Erfahrung erlangst.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_18',

          },

          :successor_quests => [77, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 9500,
              },

              {
                :resource => :resource_wood,
                :amount => 9500,
              },

              {
                :resource => :resource_fur,
                :amount => 9500,
              },

            ],

            :experience_reward => 7220,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 150000,
            },

          },          

        },              #   END OF quest_armyXP_19
        {               #   quest_armyXP_20
          :id                => 77,
          :symbolic_id       => :quest_armyXP_20,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 200,000 Army Experience points.",
  
            :de_DE => "Kämpfe mit einer Armee, bis sie 200.000 Armee Erfahrung erlangt.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_19',

          },

          :successor_quests => [78, ],

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

            :experience_reward => 8000,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 200000,
            },

          },          

        },              #   END OF quest_armyXP_20
        {               #   quest_armyXP_21
          :id                => 78,
          :symbolic_id       => :quest_armyXP_21,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 300,000 Army Experience points.",
  
            :de_DE => "Kämpfe mit einer Armee, bis sie 300.000 Armee Erfahrung erlangt.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_20',

          },

          :successor_quests => [79, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 12000,
              },

              {
                :resource => :resource_wood,
                :amount => 12000,
              },

              {
                :resource => :resource_fur,
                :amount => 12000,
              },

            ],

            :experience_reward => 10000,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 300000,
            },

          },          

        },              #   END OF quest_armyXP_21
        {               #   quest_armyXP_22
          :id                => 79,
          :symbolic_id       => :quest_armyXP_22,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Experienced armies",
  
            :de_DE => "Erfahrene Armeen",
                
          },
          :task => {
            
            :en_US => "Fight with an army until it has 500,000 Army Experience points.",
  
            :de_DE => "Kämpfe mit einer Armee, bis sie 500.000 Armee Erfahrung erlangt.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Armeen haben nicht genug Kampferfahrung. Zeig ihnen, wie eine Schlacht aussieht. Das wird sie stärker machen.",
  
            :en_US => "Your armies are lacking battle experience. Show them what a fight looks like if you want to strengthen them.",
                
          },
          :description => {
            
            :de_DE => "<p>Erfahrung bekommt die Armee, für jede Einheit, die sie verliert.</p>",
  
            :en_US => "<p>An army gains experience for each unit it loses.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut, Deine Krieger sind schon ein bisschen erfahrener.",
  
            :en_US => "Well done, your warriors are a little bit more experienced.",
                
          },
          :reward_text => {
            
            :de_DE => "Armeen bekommen mit jedem zusätzlichen Rang Boni auf ihre Kampfkraft.",
  
            :en_US => "With each increase in the rank of an army, all units will get a bonus added to their attributes.",
                
          },

          :requirement => {
            
            :quest => 'quest_armyXP_21',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 15000,
              },

              {
                :resource => :resource_wood,
                :amount => 15000,
              },

              {
                :resource => :resource_fur,
                :amount => 15000,
              },

            ],

            :experience_reward => 15000,

          },          

          :reward_tests => {
            
            :army_experience_test => {
              :min_experience => 500000,
            },

          },          

        },              #   END OF quest_armyXP_22
        {               #   quest_score_0
          :id                => 80,
          :symbolic_id       => :quest_score_0,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 200",
  
            :de_DE => "Erreiche 200 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :successor_quests => [81, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 100,
              },

              {
                :resource => :resource_wood,
                :amount => 100,
              },

              {
                :resource => :resource_fur,
                :amount => 100,
              },

            ],

            :experience_reward => 20,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 200,
            },

          },          

        },              #   END OF quest_score_0
        {               #   quest_score_1
          :id                => 81,
          :symbolic_id       => :quest_score_1,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 400",
  
            :de_DE => "Erreiche 400 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_0',

          },

          :successor_quests => [82, ],

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

            :experience_reward => 40,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 400,
            },

          },          

        },              #   END OF quest_score_1
        {               #   quest_score_2
          :id                => 82,
          :symbolic_id       => :quest_score_2,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 500",
  
            :de_DE => "Erreiche 500 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_1',

          },

          :successor_quests => [83, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 400,
              },

              {
                :resource => :resource_wood,
                :amount => 400,
              },

              {
                :resource => :resource_fur,
                :amount => 400,
              },

            ],

            :experience_reward => 80,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 500,
            },

          },          

        },              #   END OF quest_score_2
        {               #   quest_score_3
          :id                => 83,
          :symbolic_id       => :quest_score_3,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 700",
  
            :de_DE => "Erreiche 700 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_2',

          },

          :successor_quests => [84, ],

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
                :amount => 1000,
              },

            ],

            :experience_reward => 180,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 700,
            },

          },          

        },              #   END OF quest_score_3
        {               #   quest_score_4
          :id                => 84,
          :symbolic_id       => :quest_score_4,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 1,000.",
  
            :de_DE => "Erreiche 1.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_3',

          },

          :successor_quests => [85, ],

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
                :amount => 1500,
              },

            ],

            :experience_reward => 320,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 1000,
            },

          },          

        },              #   END OF quest_score_4
        {               #   quest_score_5
          :id                => 85,
          :symbolic_id       => :quest_score_5,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 1,500.",
  
            :de_DE => "Erreiche 1.500 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_4',

          },

          :successor_quests => [86, ],

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
                :amount => 2000,
              },

            ],

            :experience_reward => 500,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 1500,
            },

          },          

        },              #   END OF quest_score_5
        {               #   quest_score_6
          :id                => 86,
          :symbolic_id       => :quest_score_6,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 2,000.",
  
            :de_DE => "Erreiche 2.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_5',

          },

          :successor_quests => [87, ],

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
                :amount => 3000,
              },

            ],

            :experience_reward => 720,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 2000,
            },

          },          

        },              #   END OF quest_score_6
        {               #   quest_score_7
          :id                => 87,
          :symbolic_id       => :quest_score_7,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 2,800.",
  
            :de_DE => "Erreiche 2.800 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_6',

          },

          :successor_quests => [88, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 3500,
              },

              {
                :resource => :resource_wood,
                :amount => 3500,
              },

              {
                :resource => :resource_fur,
                :amount => 3500,
              },

            ],

            :experience_reward => 980,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 2800,
            },

          },          

        },              #   END OF quest_score_7
        {               #   quest_score_8
          :id                => 88,
          :symbolic_id       => :quest_score_8,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 4,000.",
  
            :de_DE => "Erreiche 4.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_7',

          },

          :successor_quests => [89, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 4000,
              },

              {
                :resource => :resource_wood,
                :amount => 4000,
              },

              {
                :resource => :resource_fur,
                :amount => 4000,
              },

            ],

            :experience_reward => 1280,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 4000,
            },

          },          

        },              #   END OF quest_score_8
        {               #   quest_score_9
          :id                => 89,
          :symbolic_id       => :quest_score_9,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 6,000.",
  
            :de_DE => "Erreiche 6.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_8',

          },

          :successor_quests => [90, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 4500,
              },

              {
                :resource => :resource_wood,
                :amount => 4500,
              },

              {
                :resource => :resource_fur,
                :amount => 4500,
              },

            ],

            :experience_reward => 1620,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 6000,
            },

          },          

        },              #   END OF quest_score_9
        {               #   quest_score_10
          :id                => 90,
          :symbolic_id       => :quest_score_10,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 10,000.",
  
            :de_DE => "Erreiche 10.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_9',

          },

          :successor_quests => [91, ],

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
                :amount => 5000,
              },

            ],

            :experience_reward => 2000,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 10000,
            },

          },          

        },              #   END OF quest_score_10
        {               #   quest_score_11
          :id                => 91,
          :symbolic_id       => :quest_score_11,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 15,000.",
  
            :de_DE => "Erreiche 15.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_10',

          },

          :successor_quests => [92, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 5500,
              },

              {
                :resource => :resource_wood,
                :amount => 5500,
              },

              {
                :resource => :resource_fur,
                :amount => 5500,
              },

            ],

            :experience_reward => 2420,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 15000,
            },

          },          

        },              #   END OF quest_score_11
        {               #   quest_score_12
          :id                => 92,
          :symbolic_id       => :quest_score_12,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 22,500.",
  
            :de_DE => "Erreiche 22.500 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_11',

          },

          :successor_quests => [93, ],

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

            :experience_reward => 2880,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 22500,
            },

          },          

        },              #   END OF quest_score_12
        {               #   quest_score_13
          :id                => 93,
          :symbolic_id       => :quest_score_13,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 30,000.",
  
            :de_DE => "Erreiche 30.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_12',

          },

          :successor_quests => [94, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 6500,
              },

              {
                :resource => :resource_wood,
                :amount => 6500,
              },

              {
                :resource => :resource_fur,
                :amount => 6500,
              },

            ],

            :experience_reward => 3380,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 30000,
            },

          },          

        },              #   END OF quest_score_13
        {               #   quest_score_14
          :id                => 94,
          :symbolic_id       => :quest_score_14,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 40,000.",
  
            :de_DE => "Erreiche 40.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_13',

          },

          :successor_quests => [95, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 7000,
              },

              {
                :resource => :resource_wood,
                :amount => 7000,
              },

              {
                :resource => :resource_fur,
                :amount => 7000,
              },

            ],

            :experience_reward => 3920,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 40000,
            },

          },          

        },              #   END OF quest_score_14
        {               #   quest_score_15
          :id                => 95,
          :symbolic_id       => :quest_score_15,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 50,000.",
  
            :de_DE => "Erreiche 50.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_14',

          },

          :successor_quests => [96, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 7500,
              },

              {
                :resource => :resource_wood,
                :amount => 7500,
              },

              {
                :resource => :resource_fur,
                :amount => 7500,
              },

            ],

            :experience_reward => 4500,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 50000,
            },

          },          

        },              #   END OF quest_score_15
        {               #   quest_score_16
          :id                => 96,
          :symbolic_id       => :quest_score_16,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 60,000.",
  
            :de_DE => "Erreiche 60.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_15',

          },

          :successor_quests => [97, ],

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
                :resource => :resource_fur,
                :amount => 8000,
              },

            ],

            :experience_reward => 5120,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 60000,
            },

          },          

        },              #   END OF quest_score_16
        {               #   quest_score_17
          :id                => 97,
          :symbolic_id       => :quest_score_17,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 75,000.",
  
            :de_DE => "Erreiche 75.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_16',

          },

          :successor_quests => [98, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 8500,
              },

              {
                :resource => :resource_wood,
                :amount => 8500,
              },

              {
                :resource => :resource_fur,
                :amount => 8500,
              },

            ],

            :experience_reward => 5780,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 75000,
            },

          },          

        },              #   END OF quest_score_17
        {               #   quest_score_18
          :id                => 98,
          :symbolic_id       => :quest_score_18,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 80,000.",
  
            :de_DE => "Erreiche 80.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_17',

          },

          :successor_quests => [99, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 9000,
              },

              {
                :resource => :resource_wood,
                :amount => 9000,
              },

              {
                :resource => :resource_fur,
                :amount => 9000,
              },

            ],

            :experience_reward => 6480,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 80000,
            },

          },          

        },              #   END OF quest_score_18
        {               #   quest_score_19
          :id                => 99,
          :symbolic_id       => :quest_score_19,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 100,000.",
  
            :de_DE => "Erreiche 100.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_18',

          },

          :successor_quests => [100, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 9500,
              },

              {
                :resource => :resource_wood,
                :amount => 9500,
              },

              {
                :resource => :resource_fur,
                :amount => 9500,
              },

            ],

            :experience_reward => 7220,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 100000,
            },

          },          

        },              #   END OF quest_score_19
        {               #   quest_score_20
          :id                => 100,
          :symbolic_id       => :quest_score_20,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 150,000.",
  
            :de_DE => "Erreiche 150.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_19',

          },

          :successor_quests => [101, ],

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

            :experience_reward => 8000,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 150000,
            },

          },          

        },              #   END OF quest_score_20
        {               #   quest_score_21
          :id                => 101,
          :symbolic_id       => :quest_score_21,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Populatoin of 250,000.",
  
            :de_DE => "Erreiche 250.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig.",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_20',

          },

          :successor_quests => [102, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 12000,
              },

              {
                :resource => :resource_wood,
                :amount => 12000,
              },

              {
                :resource => :resource_fur,
                :amount => 12000,
              },

            ],

            :experience_reward => 10000,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 250000,
            },

          },          

        },              #   END OF quest_score_21
        {               #   quest_score_22
          :id                => 102,
          :symbolic_id       => :quest_score_22,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Population",
  
            :de_DE => "Einwohner",
                
          },
          :task => {
            
            :en_US => "Reach a Population of 500,000.",
  
            :de_DE => "Erreiche 500.000 Einwohner",
                
          },
          :flavour => {
            
            :de_DE => "Dein Stamm ist vielleicht gewachsen, aber er ist immer noch nicht groß genug. Guck Dir mal die ganzen anderen Stämme an, die sind viel größer. Vergrößere Deinen Stamm!",
  
            :en_US => "Your tribe has definitely grown, but it's still not big enough. Look at the other tribes. They are way bigger! You need to fix this by building up your population.",
                
          },
          :description => {
            
            :de_DE => "<p>Einwohner kommen hinzu, wenn Du neue Gebäude baust oder ausbaust.</p>",
  
            :en_US => "<p>You gain additional population for each building you build or upgrade.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Okay, ein bisschen größer ist Dein Stamm ja geworden, nimm Deine Belohnung. Aber Du bist noch lange nicht fertig",
  
            :en_US => "Yeah, okay, I admit that your tribe has grown a bit. You can have a reward - just don't think you're done yet.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist standardmäßig nach Bewohnern sortiert.",
  
            :en_US => "By default the ranking is sorted by population.",
                
          },

          :requirement => {
            
            :quest => 'quest_score_21',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 15000,
              },

              {
                :resource => :resource_wood,
                :amount => 15000,
              },

              {
                :resource => :resource_fur,
                :amount => 15000,
              },

            ],

            :experience_reward => 15000,

          },          

          :reward_tests => {
            
            :score_test => {
              :min_population => 500000,
            },

          },          

        },              #   END OF quest_score_22
        {               #   quest_resourcescore_1
          :id                => 103,
          :symbolic_id       => :quest_resourcescore_1,
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
            
            :en_US => "Increase the resource production of one settlement to 120 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 120 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_0',

          },

          :successor_quests => [104, ],

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
              :min_resources => 120,
            },

          },          

        },              #   END OF quest_resourcescore_1
        {               #   quest_resourcescore_2
          :id                => 104,
          :symbolic_id       => :quest_resourcescore_2,
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
            
            :en_US => "Increase the resource production of one settlement to 210 resource points after taxes.",
  
            :de_DE => "Steigere die Rohstoffproduktion einer Siedlung auf 210 Rohstoffpunkte nach Steuern. ",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.",
  
            :en_US => "The fortress takes up to 15% tax on the resource production of each settlement in the region.",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_1',

          },

          :successor_quests => [105, ],

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
                :amount => 300,
              },

            ],

            :experience_reward => 60,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 210,
            },

          },          

        },              #   END OF quest_resourcescore_2
        {               #   quest_resourcescore_3
          :id                => 105,
          :symbolic_id       => :quest_resourcescore_3,
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
            
            :en_US => "Increase the resource production of one settlement to 420 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 420 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_2',

          },

          :successor_quests => [106, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 450,
              },

              {
                :resource => :resource_wood,
                :amount => 450,
              },

              {
                :resource => :resource_fur,
                :amount => 450,
              },

            ],

            :experience_reward => 80,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 420,
            },

          },          

        },              #   END OF quest_resourcescore_3
        {               #   quest_resourcescore_4
          :id                => 106,
          :symbolic_id       => :quest_resourcescore_4,
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
            
            :en_US => "Increase the resource production of one settlement to 750 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 750 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_3',

          },

          :successor_quests => [107, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 720,
              },

              {
                :resource => :resource_wood,
                :amount => 720,
              },

              {
                :resource => :resource_fur,
                :amount => 720,
              },

            ],

            :experience_reward => 180,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 750,
            },

          },          

        },              #   END OF quest_resourcescore_4
        {               #   quest_resourcescore_5
          :id                => 107,
          :symbolic_id       => :quest_resourcescore_5,
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
            
            :en_US => "Increase the resource production of one settlement to 1,300 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 1.300 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_4',

          },

          :successor_quests => [108, ],

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
                :amount => 1500,
              },

            ],

            :experience_reward => 320,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 1300,
            },

          },          

        },              #   END OF quest_resourcescore_5
        {               #   quest_resourcescore_6
          :id                => 108,
          :symbolic_id       => :quest_resourcescore_6,
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
            
            :en_US => "Increase the resource production of one settlement to 1,900 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 1.900 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_5',

          },

          :successor_quests => [109, ],

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
                :amount => 2000,
              },

            ],

            :experience_reward => 500,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 1900,
            },

          },          

        },              #   END OF quest_resourcescore_6
        {               #   quest_resourcescore_7
          :id                => 109,
          :symbolic_id       => :quest_resourcescore_7,
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
            
            :en_US => "Increase the resource production of one settlement to 2,720 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 2.720 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_6',

          },

          :successor_quests => [110, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 2500,
              },

              {
                :resource => :resource_wood,
                :amount => 2500,
              },

              {
                :resource => :resource_fur,
                :amount => 2500,
              },

            ],

            :experience_reward => 720,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 2720,
            },

          },          

        },              #   END OF quest_resourcescore_7
        {               #   quest_resourcescore_8
          :id                => 110,
          :symbolic_id       => :quest_resourcescore_8,
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
            
            :en_US => "Increase the resource production of one settlement to 3,500 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 3.500 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_7',

          },

          :successor_quests => [111, ],

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
                :amount => 3000,
              },

            ],

            :experience_reward => 980,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 3500,
            },

          },          

        },              #   END OF quest_resourcescore_8
        {               #   quest_resourcescore_9
          :id                => 111,
          :symbolic_id       => :quest_resourcescore_9,
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
            
            :en_US => "Increase the resource production of one settlement to 4,340 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 4.340 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_8',

          },

          :successor_quests => [112, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 3500,
              },

              {
                :resource => :resource_wood,
                :amount => 3500,
              },

              {
                :resource => :resource_fur,
                :amount => 3500,
              },

            ],

            :experience_reward => 1280,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 4340,
            },

          },          

        },              #   END OF quest_resourcescore_9
        {               #   quest_resourcescore_10
          :id                => 112,
          :symbolic_id       => :quest_resourcescore_10,
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
            
            :en_US => "Increase the resource production of one settlement to 5,540 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 5.540 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_9',

          },

          :successor_quests => [113, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 4000,
              },

              {
                :resource => :resource_wood,
                :amount => 4000,
              },

              {
                :resource => :resource_fur,
                :amount => 4000,
              },

            ],

            :experience_reward => 1620,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 5540,
            },

          },          

        },              #   END OF quest_resourcescore_10
        {               #   quest_resourcescore_11
          :id                => 113,
          :symbolic_id       => :quest_resourcescore_11,
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
            
            :en_US => "Increase the resource production of one settlement to 6,900 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 6.900 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_10',

          },

          :successor_quests => [114, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 4500,
              },

              {
                :resource => :resource_wood,
                :amount => 4500,
              },

              {
                :resource => :resource_fur,
                :amount => 4500,
              },

            ],

            :experience_reward => 2000,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 6900,
            },

          },          

        },              #   END OF quest_resourcescore_11
        {               #   quest_resourcescore_12
          :id                => 114,
          :symbolic_id       => :quest_resourcescore_12,
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
            
            :en_US => "Increase the resource production of one settlement to 8,420 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 8.420 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_11',

          },

          :successor_quests => [115, ],

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
                :amount => 5000,
              },

            ],

            :experience_reward => 2420,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 8420,
            },

          },          

        },              #   END OF quest_resourcescore_12
        {               #   quest_resourcescore_13
          :id                => 115,
          :symbolic_id       => :quest_resourcescore_13,
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
            
            :en_US => "Increase the resource production of one settlement to 10,100 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 10.100 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_12',

          },

          :successor_quests => [116, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 5500,
              },

              {
                :resource => :resource_wood,
                :amount => 5500,
              },

              {
                :resource => :resource_fur,
                :amount => 5500,
              },

            ],

            :experience_reward => 2880,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 10100,
            },

          },          

        },              #   END OF quest_resourcescore_13
        {               #   quest_resourcescore_14
          :id                => 116,
          :symbolic_id       => :quest_resourcescore_14,
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
            
            :en_US => "Increase the resource production of one settlement to 11,940 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 11.940 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_13',

          },

          :successor_quests => [117, ],

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

            :experience_reward => 3380,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 11940,
            },

          },          

        },              #   END OF quest_resourcescore_14
        {               #   quest_resourcescore_15
          :id                => 117,
          :symbolic_id       => :quest_resourcescore_15,
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
            
            :en_US => "Increase the resource production of one settlement to 13,940 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 13.940 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_14',

          },

          :successor_quests => [118, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 6500,
              },

              {
                :resource => :resource_wood,
                :amount => 6500,
              },

              {
                :resource => :resource_fur,
                :amount => 6500,
              },

            ],

            :experience_reward => 3920,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 13940,
            },

          },          

        },              #   END OF quest_resourcescore_15
        {               #   quest_resourcescore_16
          :id                => 118,
          :symbolic_id       => :quest_resourcescore_16,
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
            
            :en_US => "Increase the resource production of one settlement to 16,100 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 16.100 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_15',

          },

          :successor_quests => [119, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 7000,
              },

              {
                :resource => :resource_wood,
                :amount => 7000,
              },

              {
                :resource => :resource_fur,
                :amount => 7000,
              },

            ],

            :experience_reward => 4500,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 16100,
            },

          },          

        },              #   END OF quest_resourcescore_16
        {               #   quest_resourcescore_17
          :id                => 119,
          :symbolic_id       => :quest_resourcescore_17,
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
            
            :en_US => "Increase the resource production of one settlement to 18,420 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 18.420 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_16',

          },

          :successor_quests => [120, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 7500,
              },

              {
                :resource => :resource_wood,
                :amount => 7500,
              },

              {
                :resource => :resource_fur,
                :amount => 7500,
              },

            ],

            :experience_reward => 5120,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 18420,
            },

          },          

        },              #   END OF quest_resourcescore_17
        {               #   quest_resourcescore_18
          :id                => 120,
          :symbolic_id       => :quest_resourcescore_18,
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
            
            :en_US => "Increase the resource production of one settlement to 20,900 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 20.900 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_17',

          },

          :successor_quests => [121, ],

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
                :resource => :resource_fur,
                :amount => 8000,
              },

            ],

            :experience_reward => 5780,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 20900,
            },

          },          

        },              #   END OF quest_resourcescore_18
        {               #   quest_resourcescore_19
          :id                => 121,
          :symbolic_id       => :quest_resourcescore_19,
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
            
            :en_US => "Increase the resource production of one settlement to 23,540 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 23.540 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_18',

          },

          :successor_quests => [122, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 8500,
              },

              {
                :resource => :resource_wood,
                :amount => 8500,
              },

              {
                :resource => :resource_fur,
                :amount => 8500,
              },

            ],

            :experience_reward => 6480,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 23540,
            },

          },          

        },              #   END OF quest_resourcescore_19
        {               #   quest_resourcescore_20
          :id                => 122,
          :symbolic_id       => :quest_resourcescore_20,
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
            
            :en_US => "Increase the resource production of one settlement to 26,340 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 26.340 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_19',

          },

          :successor_quests => [123, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 9000,
              },

              {
                :resource => :resource_wood,
                :amount => 9000,
              },

              {
                :resource => :resource_fur,
                :amount => 9000,
              },

            ],

            :experience_reward => 7220,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 26340,
            },

          },          

        },              #   END OF quest_resourcescore_20
        {               #   quest_resourcescore_21
          :id                => 123,
          :symbolic_id       => :quest_resourcescore_21,
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
            
            :en_US => "Increase the resource production of one settlement to 29,300 resource points after taxes.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 29.300 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_20',

          },

          :successor_quests => [124, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 9500,
              },

              {
                :resource => :resource_wood,
                :amount => 9500,
              },

              {
                :resource => :resource_fur,
                :amount => 9500,
              },

            ],

            :experience_reward => 8000,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 29300,
            },

          },          

        },              #   END OF quest_resourcescore_21
        {               #   quest_resourcescore_22
          :id                => 124,
          :symbolic_id       => :quest_resourcescore_22,
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
            
            :en_US => "Increase the resource production of one settlement to 32,400 resource points.",
  
            :de_DE => "Steigere die Produktion einer Siedlung auf 32.420 Rohstoffpunkte nach Steuern.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert. Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point. The fortress takes up to 15% tax on the resource production of each settlement in the region.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Du nicht selber der Festungsbesitzer bist, solltest Du über den Steuersatz verhandeln. 15% müssen nicht sein.",
  
            :en_US => "Are you still paying taxes? Why?",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_21',

          },

          :successor_quests => [125, ],

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

            :experience_reward => 10000,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 32420,
            },

          },          

        },              #   END OF quest_resourcescore_22
        {               #   quest_resourcescore_23
          :id                => 125,
          :symbolic_id       => :quest_resourcescore_23,
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
            
            :en_US => "Increase the resource production of one settlement to 35,420 reource points.",
  
            :de_DE => "Steigere die Rohstoffproduktion einer Siedlung auf 35.420 Rohstoffpunkte",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Alle drei Rohstoffe Stein, Holz und Fell sind je einen Rohstoffpunkt wert.</p>",
  
            :en_US => "<p>Stone, wood and fur are all worth one resource point.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung produziert mehr und wächst schneller.",
  
            :en_US => "Nice! Your settlement is producing more resources and growing rapidly.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.",
  
            :en_US => "The fortress takes up to 15% tax on the resource production of each settlement in the region.",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_22',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 12000,
              },

              {
                :resource => :resource_wood,
                :amount => 12000,
              },

              {
                :resource => :resource_fur,
                :amount => 12000,
              },

            ],

            :experience_reward => 15000,

          },          

          :reward_tests => {
            
            :settlement_production_test => {
              :min_resources => 35420,
            },

          },          

        },              #   END OF quest_resourcescore_23
        {               #   quest_build_1barrackslvl10
          :id                => 126,
          :symbolic_id       => :quest_build_1barrackslvl10,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Training Grounds level 10",
  
            :de_DE => "Ausbildungsgelände Level 10",
                
          },
          :task => {
            
            :en_US => "Upgrade a Training Grounds to Level 10.",
  
            :de_DE => "Baue ein Ausbildungsgelände auf Level 10.",
                
          },
          :flavour => {
            
            :de_DE => "Nur mit Kriegern und Keulenkriegern können wir uns nicht behaupten! Wir brauchen auch die Dicken Keulen. Es mag lange dauern, aber sorge für den Ausbau des Ausbildungsgeländes.",
  
            :en_US => "We need to train our clubbers if we're going to stand our ground! If we train them well, they'll become thick-skinned clubbers. It might take a while, but make sure you upgrade the training grounds.",
                
          },
          :description => {
            
            :de_DE => "<p>Auf Level 10 können im Ausbildungsgelände neue Einheiten ausgebildet werden.</p>",
  
            :en_US => "<p>At Level 10, new units can be trained in the training grounds.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Danke Halbgott. Zwar nicht die schlausten, aber einstecken und draufhauen können die Dickhäuter wirklich.",
  
            :en_US => "Thank you Demigod. They may not be the brightest crayons in the box, but thick-skinned clubbers can take a lot of punishment – and hand it out too! ",
                
          },
          :reward_text => {
            
            :de_DE => "Der Dickhäutige Keulenkrieger! Mehr Kraft für Deine Nahkämpfer.",
  
            :en_US => "Behold the thick-skinned clubber! Excellent reinforcement for your melee fighters.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1barrackslvl5',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 6000,
              },

              {
                :resource => :resource_wood,
                :amount => 3000,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_clubbers_2,
                :amount => 20,
              },

            ],

            :experience_reward => 750,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_barracks',

                :min_level => 10,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1barrackslvl10
        {               #   quest_npc_battle
          :id                => 127,
          :symbolic_id       => :quest_npc_battle,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "First battle",
  
            :de_DE => "Der erste Kampf",
                
          },
          :task => {
            
            :en_US => "Fight for the first time!",
  
            :de_DE => "Kämpfe Deinen ersten Kampf!",
                
          },
          :flavour => {
            
            :de_DE => "Halbgott, die wilden Neandertaler benötigen dringend eine Abreibung!",
  
            :en_US => "Those neanderthals sure are cruising for a bruising. ",
                
          },
          :description => {
            
            :de_DE => "<p>Während deine Armee unterwegs ist haben sich die hinterhältigen Neandertaler vor Deiner Siedlung versammelt. Führe Deine Garnison aus deiner Siedlung heraus in die Schlacht und zerschmettere sie. Wähle hierzu zunächst Deine Siedlung aus. Drücke jetzt den Angriffsknopf und wähle dann die Neandertaler aus, um den Angriff zu starten.</p>",
  
            :en_US => "<p>A bunch of ferocious neanderthals has gathered outside your settlement while your army is out in the field. We have to stop them. Lead our garrison out to battle and smash them to bits! To do so, first select your settlement. Then press the attack button and select the neandertals to beginn the attack.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Der Kampf wird noch eine Weile toben, aber wir werden mit Sicherheit Siegen! Vielleicht kehrt unsere Armee auch zurück und kommt uns zur Unterstützung.",
  
            :en_US => "The battle is gona keep going for a while but we will surely win! Especially if the army returns and supports us.",
                
          },
          :reward_text => {
            
            :de_DE => "Auf die selbe Art greifst Du auch mit Armeen an. Armeen, die auf der Seite von Siedlungen oder Festungen kämpfen erhalten einen Kampfbonus. Während ein Kampf läuft können beliebig viele Armeen auf beiden Seiten dazukommen.",
  
            :en_US => "You attack the same way with armies. Armies fighting on the same side as settlements or fortresses get a boost. While a battle is going on armies can join it on either side. ",
                
          },

          :successor_quests => [],

          :rewards => {
            
            :unit_rewards => [

              {
                :unit => :unit_clubbers,
                :amount => 10,
              },

            ],

            :experience_reward => 250,

            :action_point_reward => true,

          },          

          :reward_tests => {
            
            :kill_test => {
              :min_units => 2,
            },

          },          

          :uimarker => ['mark_map', 'mark_select_own_army', 'mark_select_other_army', 'mark_attack_button', ],

        },              #   END OF quest_npc_battle
        {               #   quest_assignment1
          :id                => 128,
          :symbolic_id       => :quest_assignment1,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "First Assignment",
  
            :de_DE => "Der erste Auftrag",
                
          },
          :task => {
            
            :en_US => "Start your first Assignment.",
  
            :de_DE => "Beginne deinen ersten Auftrag.",
                
          },
          :flavour => {
            
            :de_DE => "Krempel die Ärmel hoch, wir haben Arbeit zu verrichten.",
  
            :en_US => "Pull up those sleeves, looks like we got work to do.",
                
          },
          :description => {
            
            :de_DE => "<p>In der Taverne gibt es jede Menge Leute, die Aufträge zu vergeben haben. Betritt sie und beginne einen Auftrag.</p>",
  
            :en_US => "<p>The tavern is full of people giving out assignments. Go there and start doing one.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Nach einem Auftrag gibt es doch nichts besseres als ein kühles Bier.",
  
            :en_US => "After we finish that assignment, let's go back to the tavern for a drink.",
                
          },
          :reward_text => {
            
            :de_DE => "Je größer die Taverne wird, desto mehr Aufträge werden verfügbar. Schau regelmäßig rein um zu sehen, was es zu tun gibt.",
  
            :en_US => "The bigger the tavern becomes the more jobs you can do. Check it out regularly to see what's new.'",
                
          },

          :requirement => {
            
            :quest => 'quest_build_tavern',

          },

          :successor_quests => [16, ],

          :rewards => {
            
            :experience_reward => 250,

          },          

          :reward_tests => {
            
            :standard_assignment_test => {},

          },          

          :uimarker => ['mark_first_standard_assignment', ],

        },              #   END OF quest_assignment1
        {               #   quest_build_tavern
          :id                => 129,
          :symbolic_id       => :quest_build_tavern,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "The Tavern",
  
            :de_DE => "Die Taverne",
                
          },
          :task => {
            
            :en_US => "Build the tavern.",
  
            :de_DE => "Baue die Taverne.",
                
          },
          :flavour => {
            
            :de_DE => "Ein Ort zum trinken? Ganz mein Geschmack.",
  
            :en_US => "Finally a place where i can have a pint in peace.",
                
          },
          :description => {
            
            :de_DE => "<p>Jetzt wo Deine Siedlung wächst und gedeiht brauchen Deine Bewohner einen Ort, um sich bei kühlen Getränken von der harten Arbeit zu erholen.</p>",
  
            :en_US => "<p>Now that our settlement has grown considerably people are wanting for a place to relax. I suppose a tavern of some sort would do the trick, after all who can refuse a cold beer?</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Netter Laden, man hat mir sogar schon einen Job angeboten.",
  
            :en_US => "Nice place, already earned a coupple of stones aswell.",
                
          },
          :reward_text => {
            
            :de_DE => "In der Taverne werden viele Aufträge vergeben. Schau doch einfach ab und zu rein.",
  
            :en_US => "There are many people looking for favors in the tavern. Maybe you can get something out of that.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_cottagelvl1',

          },

          :successor_quests => [128, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 125,
              },

              {
                :resource => :resource_wood,
                :amount => 125,
              },

              {
                :resource => :resource_fur,
                :amount => 125,
              },

            ],

            :experience_reward => 100,

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
        {               #   quest_build_1campfirelvl2
          :id                => 130,
          :symbolic_id       => :quest_build_1campfirelvl2,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "A bigger campfire",
  
            :de_DE => "Ein größeres Lagerfeuer",
                
          },
          :task => {
            
            :en_US => "Upgrade your campfire to level 2.",
  
            :de_DE => "Baue Dein Lagerfeuer auf Level 2 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Das Lagerfeuer brennt. Aber mal ehrlich, was sollen denn die anderen Halbgöttern von so einem kleinen Feuer halten?",
  
            :en_US => "This fire is nice and all, but not nearly big enough, dont you think?
      ",
                
          },
          :description => {
            
            :de_DE => "<p>Baue Dein Lagerfeuer aus, um weitere Allianz-Optionen freizuschalten.</p>",
  
            :en_US => "<p>Upgrade your campfire to unlock more alliance options.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schau nur wie es lodert, das nenn ich mal ein Feuer.",
  
            :en_US => "Now thats what I call a fire!",
                
          },
          :reward_text => {
            
            :de_DE => "Ab jetzt kannst Du eine eigene Allianzen gründen. Lade Deine Freunde und benachbarte Spieler in Deine Allianz ein.",
  
            :en_US => "From now on you can found your own alliance. Try getting other players and your friends to join you.",
                
          },

          :requirement => {
            
            :quest => 'quest_profile',

          },

          :successor_quests => [19, 20, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 125,
              },

              {
                :resource => :resource_wood,
                :amount => 125,
              },

              {
                :resource => :resource_cash,
                :amount => 1,
              },

            ],

            :experience_reward => 150,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_campfire',

                :min_level => 2,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1campfirelvl2
        {               #   quest_alliance_members
          :id                => 131,
          :symbolic_id       => :quest_alliance_members,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Alliance Members",
  
            :de_DE => "Allianzmitglieder",
                
          },
          :task => {
            
            :en_US => "Be a Member of an alliance with atleast 3 others.",
  
            :de_DE => "Sei Mitglied in einer Allianz mit mindestens 4 Mitgliedern.",
                
          },
          :flavour => {
            
            :de_DE => "Schöne Allianz hast Du da, aber größer könnte sie schon noch werden, nicht?",
  
            :en_US => "Nice alliance you have there but it could be a little bigger, dont you think?",
                
          },
          :description => {
            
            :de_DE => "<p>Deine Allianz muss wachsen, wenn ihr euch in dieser grausamen Welt durchsetzten wollt. Sucht nach geeigneten Mitgliedern und nehmt sie bei euch auf, dann könnt ihr bald schon bei den Mächtigen mitmischen.</p>",
  
            :en_US => "<p>Your alliance needs to grow if you want to survive in this cruel world. Search for more members amongst your neighbours and friends and soon you may count yourselves amongst the powerfull.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Jetzt wirds langsam!",
  
            :en_US => "If we keep up like this we're gona go places.",
                
          },
          :reward_text => {
            
            :de_DE => "Desto mehr Mitglieder ihr in eurer Allianz habt, desto größer kann euer Einfluss werden und desto mehr könnt ihr einander unterstützen.",
  
            :en_US => "The more members your alliance has, the more influence it may wield. You also may be able to support each other more efficiently.",
                
          },

          :requirement => {
            
            :quest => 'quest_alliance',

          },

          :successor_quests => [132, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_clubbers,
                :amount => 10,
              },

            ],

            :experience_reward => 550,

          },          

          :reward_tests => {
            
            :alliance_members_test => {
              :min_count => 4,
            },

          },          

        },              #   END OF quest_alliance_members
        {               #   quest_alliance_members2
          :id                => 132,
          :symbolic_id       => :quest_alliance_members2,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Alliance Members",
  
            :de_DE => "Allianzmitglieder",
                
          },
          :task => {
            
            :en_US => "Be a Member of an alliance with atleast 12 others.",
  
            :de_DE => "Sei Mitglied in einer Allianz mit mindestens 13 Mitgliedern.",
                
          },
          :flavour => {
            
            :de_DE => "Schöne Allianz hast Du da, aber größer könnte sie schon noch werden, nicht?",
  
            :en_US => "Nice alliance you have there but it could be a little bigger, dont you think?",
                
          },
          :description => {
            
            :de_DE => "<p>Deine Allianz muss wachsen, wenn ihr euch in dieser grausamen Welt durchsetzten wollt. Sucht nach geeigneten Mitgliedern und nehmt sie bei euch auf, dann könnt ihr bald schon bei den Mächtigen mitmischen.</p>",
  
            :en_US => "<p>Your alliance needs to grow if you want to survive in this cruel world. Search for more members amongst your neighbours and friends and soon you may count yourselves amongst the powerfull.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Jetzt wirds langsam!",
  
            :en_US => "If we keep up like this we're gona go places.",
                
          },
          :reward_text => {
            
            :de_DE => "Desto mehr Mitglieder ihr in eurer Allianz habt, desto größer kann euer Einfluss werden und desto mehr könnt ihr einander unterstützen.",
  
            :en_US => "The more members your alliance has, the more influence it may wield. You also may be able to support each other more efficiently.",
                
          },

          :requirement => {
            
            :quest => 'quest_alliance_members',

          },

          :successor_quests => [133, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 4,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_clubbers_2,
                :amount => 20,
              },

            ],

            :experience_reward => 850,

          },          

          :reward_tests => {
            
            :alliance_members_test => {
              :min_count => 13,
            },

          },          

        },              #   END OF quest_alliance_members2
        {               #   quest_alliance_members3
          :id                => 133,
          :symbolic_id       => :quest_alliance_members3,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Alliance Members",
  
            :de_DE => "Allianzmitglieder",
                
          },
          :task => {
            
            :en_US => "Be a Member of an alliance with atleast 22 others.",
  
            :de_DE => "Sei Mitglied in einer Allianz mit mindestens 23 Mitgliedern.",
                
          },
          :flavour => {
            
            :de_DE => "Schöne Allianz hast Du da, aber größer könnte sie schon noch werden, nicht?",
  
            :en_US => "Nice alliance you have there but it could be a little bigger, dont you think?",
                
          },
          :description => {
            
            :de_DE => "<p>Deine Allianz muss wachsen, wenn ihr euch in dieser grausamen Welt durchsetzten wollt. Sucht nach geeigneten Mitgliedern und nehmt sie bei euch auf, dann könnt ihr bald schon bei den Mächtigen mitmischen.</p>",
  
            :en_US => "<p>Your alliance needs to grow if you want to survive in this cruel world. Search for more members amongst your neighbours and friends and soon you may count yourselves amongst the powerfull.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Jetzt wirds langsam!",
  
            :en_US => "If we keep up like this we're gona go places.",
                
          },
          :reward_text => {
            
            :de_DE => "Desto mehr Mitglieder ihr in eurer Allianz habt, desto größer kann euer Einfluss werden und desto mehr könnt ihr einander unterstützen.",
  
            :en_US => "The more members your alliance has, the more influence it may wield. You also may be able to support each other more efficiently.",
                
          },

          :requirement => {
            
            :quest => 'quest_alliance_members2',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 8,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_clubbers_3,
                :amount => 30,
              },

            ],

            :experience_reward => 1100,

          },          

          :reward_tests => {
            
            :alliance_members_test => {
              :min_count => 23,
            },

          },          

        },              #   END OF quest_alliance_members3
        {               #   quest_crossplatform
          :id                => 134,
          :symbolic_id       => :quest_crossplatform,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          :tutorial_end_quest => false,
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Cross-Platform",
  
            :de_DE => "Cross-Platform",
                
          },
          :task => {
            
            :en_US => "Log into the HTML version of Wack-A-Doo at https://wack-a-doo.com or into the facebook-App.",
  
            :de_DE => "Logge Dich in die HTML-Version von Wack-A-Doo unter https://wack-a-doo.de oder in die Facebook-App von Wack-A-Doo ein.",
                
          },
          :flavour => {
            
            :de_DE => "Cross-Platform? Klingt nützlich.",
  
            :en_US => "Cross-Platform? Sounds reasonable.",
                
          },
          :description => {
            
            :de_DE => "<p>Du kannst den selben Wack-A-Doo Account auch über Deinen Webbrowser oder im Spiel anmelden und dort das selbe Spiel spielen!</p>",
  
            :en_US => "<p>Wack-A-Doo is not only an App, you can also play the same game in your browser or as facebook-app!</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Herzlich Willkommen im Browserspiel!",
  
            :en_US => "Welcome to the browser game!",
                
          },
          :reward_text => {
            
            :de_DE => "Wack-A-Doo im Browser funktioniert genauso wie die App, nur mit anderem Interface.",
  
            :en_US => "Wack-A-Doo in your browser works exactly the same as the App, just with a different interface.",
                
          },

          :requirement => {
            
            :quest => 'quest_resourcescore_0',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 20,
              },

            ],

            :experience_reward => 1500,

          },          

          :reward_tests => {
            
            :cross_platform_test => {},

          },          

        },              #   END OF quest_crossplatform
        {               #   quest_found_home_base
          :id                => 135,
          :symbolic_id       => :quest_found_home_base,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => true,
          :tutorial_end_quest => false,
          :priority          => 1,
          :blocking          => true,

          :name => {
            
            :en_US => "Settle Down",
  
            :de_DE => "Lass Dich nieder",
                
          },
          :task => {
            
            :en_US => "Found a Settlement",
  
            :de_DE => "Gründe Deine Hauptsiedlung.",
                
          },
          :flavour => {
            
            :de_DE => "Willkommen Halbgott. Wir sind so weit gelaufen, lass uns hier siedeln!",
  
            :en_US => "Welcome Demigod! We've walked so far, let's found a settlement!",
                
          },
          :description => {
            
            :de_DE => "<p>Wähle den großen Häuptling aus und drücke den blauen Siedlungsknopf.</p>",
  
            :en_US => "<p>Select your Great Chief and press the blue settle button.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hey, der erste Jäger und Sammler ist eingezogen. So sieht es doch schon viel besser aus, findest Du nicht?",
  
            :en_US => "Hey – that looks much better, don't you think? ",
                
          },
          :reward_text => {
            
            :de_DE => "Der Jäger und Sammler sammelt Steine, Holz und Felle für Deinen Rohstoffvorrat.",
  
            :en_US => "The job of a Hunter Gatherer is to collect small quantities of stone, wood and fur - all the raw materials you need to succeed. ",
                
          },

          :successor_quests => [0, ],

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

              {
                :resource => :resource_fur,
                :amount => 25,
              },

            ],

            :experience_reward => 25,

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

          :uimarker => ['mark_map', 'mark_select_own_army', 'mark_found_settlement', ],

        },              #   END OF quest_found_home_base
      ],                # END OF QUESTS

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts Tutorial::Tutorial.the_tutorial.to_json
#Tutorial.tutorial.quests.each do |value| 
#  puts value[:name][:de_DE] 
#end

