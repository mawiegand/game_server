# encoding: utf-8  

require 'active_model'

# A module containing the tutorial quests of a particular game instance using the
# Augmented Worlds Engine.
#
# This particular file does hold the following set of rules:
# Game:    Wack-A-Doo
# Branch:  development (alpha)
# Version: 0.5.5
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
        :minor => 5, 
        :build => 5, 
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
  
      :num_tutorial_quests => 14,
  
      :quests => [  # ALL QUESTS

        {               #   quest_queue_1gathererlvl1
          :id                => 0,
          :symbolic_id       => :quest_queue_1gathererlvl1,
  
          :type              => :epic,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 1,
          :blocking          => true,

          :name => {
            
            :en_US => "The first building",
  
            :de_DE => "Der Sammler",
                
          },
          :task => {
            
            :en_US => "Give an order to a Level 1 Hunter Gatherer.",
  
            :de_DE => "Baue einen Sammler.",
                
          },
          :flavour => {
            
            :de_DE => "Willkommen Halbgott. Schau Dir Deine Siedlung an, ist sie nicht wundervoll?",
  
            :en_US => "Welcome Demigod! Look at your settlement – isn't it great? A bit empty, though.",
                
          },
          :description => {
            
            :de_DE => "<p>Um einen Sammler in Auftrag zu geben, drücke auf einen Bauplatz und wähle dort den Sammler.</p>",
  
            :en_US => "<p>To give an order to a Hunter Gatherer, press on an empty building site and click Hunter Gatherer.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hey, der erste Jäger und Sammler ist eingezogen. So sieht es doch schon viel besser aus, findest Du nicht?",
  
            :en_US => "Hey – that looks much better, don't you think? ",
                
          },
          :reward_text => {
            
            :de_DE => "Der Sammler sammelt Steine und Holz für Deinen Rohstoffvorrat.",
  
            :en_US => "The job of a Hunter Gatherer is to collect small quantities of stone, wood and fur - all the raw materials you need to succeed. ",
                
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
            
            :en_US => "Upgrade the chieftan's hut",
  
            :de_DE => "Ausbau der Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 2.",
  
            :de_DE => "Verbessere die Häuptlingshütte.",
                
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
            
            :de_DE => "Ein neuer Bauplatz! Baue dort eine Taverne.",
  
            :en_US => "At the moment you should build your building at the small building slots.",
                
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
            
            :de_DE => "Die Taverne ist fertig. Nimm gleich den ersten Auftrag an.",
  
            :en_US => "There are many people looking for favors in the tavern. Maybe you can get something out of that.",
                
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
            
            :en_US => "Start your first Assignment.",
  
            :de_DE => "Beginne Deinen ersten Auftrag.",
                
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
            
            :de_DE => "Je größer die Taverne ausgebaut wird, desto mehr Aufträge werden verfügbar.",
  
            :en_US => "The bigger the tavern becomes the more jobs you can do. Check it out regularly to see what's new.'",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_build_tavern',
              },

            ],
  
          },

          :rewards => {
            
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
  
          :advisor           => :girl,
          :hide_start_dialog => true,
  
          :tutorial          => true,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chieftain's hut",
  
            :de_DE => "Die Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 3",
  
            :de_DE => "Verbessere die Häuptlingshütte auf Level 3.",
                
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
            
            :de_DE => "Du kannst jetzt ein Ausbildungsgelände bauen.",
  
            :en_US => "Upgrading the chieftan's hut gives you the option to construct a wider range of buildings.",
                
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
            
            :de_DE => "Jetzt kannst Du Krieger ausbilden.",
  
            :en_US => "Having a Training Grounds speeds up the time it takes to recruit melee fighters.
  ",
                
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
        {               #   quest_recruit_clubber
          :id                => 6,
          :symbolic_id       => :quest_recruit_clubber,
  
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
            
            :en_US => "Build a warrior.",
  
            :de_DE => "Rekrutiere einen Krieger.",
                
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
            
            :de_DE => "Die ersten Krieger hast Du. Zeit sich die Nachbarschaft anzuschauen.",
  
            :en_US => "You can train several units at the same time. Just select the number of units you want.",
                
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

        },              #   END OF quest_recruit_clubber
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
            
            :de_DE => "Da ist Deine Siedlung. Jetzt brauchst Du nur noch eine Armee.",
  
            :en_US => "On the World Map you can also see the other gamers who are active arround you.",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_recruit_clubber',
              },

            ],
  
          },

          :rewards => {
            
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
            
            :de_DE => "Deine erste Armee wartet auf Befehle.",
  
            :en_US => "Every army needs a command point in the settlement - that's where they receive their commands from. You can only reinforce your army at their home settlement.",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_settlement_button1',
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
    
          :priority          => 1,
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
            
            :de_DE => "Ein Kampf läuft meist über mehrere Runden. In jeder Runde können beliebig viele Armeen auf beiden Seiten dazukommen.",
  
            :en_US => "You attack the same way with armies. Armies fighting on the same side as settlements or fortresses get a boost. While a battle is going on armies can join it on either side. ",
                
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
            
            :de_DE => "Jede Bewegung und jeder Angriff kostet Dich einen Aktionspunkt.",
  
            :en_US => "Below your army you'll see your available action points. Movements and attacks cost one action point and your army regenerates one action point every three hours.",
                
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
                :amount => 110,
              },

              {
                :resource => :resource_wood,
                :amount => 110,
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
            
            :de_DE => "Alle Deine Siedlungen und Festungen kannst Du über das Gebäudesymbol betreten.",
  
            :en_US => "You can enter all of your settlements and fortresses by selecting them and clicking Enter.",
                
          },

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest_army_create',
              },

            ],
  
          },

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
  
            :de_DE => "Rohstoffe",
                
          },
          :task => {
            
            :en_US => "Enter an alliance, or start your own alliance.",
  
            :de_DE => "Baue Steinbruch und Holzfäller.",
                
          },
          :flavour => {
            
            :de_DE => "Feindliche Armeen mit Deinen eigenen Armeen zu bekämpfen, ist ja nett. Aber viel besser wäre es doch, wenn ihr zusammenarbeiten würdet oder wenn Deine Freunde Dir helfen würden.",
  
            :en_US => "Fighting enemy armies with your own army is great, but it's even better if you have help from your friends or you can work together with other players. You should be in an alliance - allies are there to help each other.",
                
          },
          :description => {
            
            :de_DE => "<p>Der Steinbruch und der Holzfäller sind Deine Rohstoffproduzenten.</p>",
  
            :en_US => "<p>From now on, you can enter an alliance. This has many advantages: you can exchange raw materials, help each other with defense and coordinate attacks. Only an alliance can hold a large territory.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hui, das ist aber eine tolle Allianz. Ich bin sicher, dass Ihr sehr weit kommen werdet.",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "Baue weitere oder verbessere Steinbruch und Holzfäller, um Deine Produktion zu erhöhen. ",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
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
                :amount => 100,
              },

              {
                :resource => :resource_wood,
                :amount => 100,
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
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chieftain's hut",
  
            :de_DE => "Häuptlingshütte Level 4",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 4",
  
            :de_DE => "Verbessere Häuptlingshütte auf Level 4.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Siedlung kommt ganz schön voran. Aber Du musst jetzt die Häuptlingshütte ausbauen um weiterzukommen.",
  
            :en_US => "Your settlement is coming along nicely, but you're going to have to upgrade the chieftan's hut if you want to make some more progress.",
                
          },
          :description => {
            
            :de_DE => "<p>Mit Ausbau der Häuptlingshütte kannst Du Steinbruch und Holzfäller bauen.</p>",
  
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
    
          :priority          => 1,
          :blocking          => true,

          :name => {
            
            :en_US => "Quarry",
  
            :de_DE => "Steinbruch",
                
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
            
            :de_DE => "<p>Der Steinbruch produziert Steine.</p>",
  
            :en_US => "<p>Build a quarry to improve your production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "So viel Stein, wie toll.",
  
            :en_US => "Wow – that's a lot of stone. Fantastic!",
                
          },
          :reward_text => {
            
            :de_DE => "Erweitere den Steinbruch für eine höhere Steinproduktion.",
  
            :en_US => "Quarries are very effective. Build more quarries!",
                
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 250,
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
  
            :de_DE => "Holzfäller",
                
          },
          :task => {
            
            :en_US => "Build a logger.",
  
            :de_DE => "Baue einen Holzfäller.",
                
          },
          :flavour => {
            
            :de_DE => "Der Chef sagt immer: 'Ein Brett in Ehren kann niemand verwehren!'.",
  
            :en_US => "If you want to increase production, you'll need to build more quarries and logging camps and then upgrade them.",
                
          },
          :description => {
            
            :de_DE => "<p>Holzfäller erhöhen Deine Holzproduktion.</p>",
  
            :en_US => "<p>Upgrade the logger to increase your production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na, das nenne ich mal Holz vor der Hütte!",
  
            :en_US => "Wow – look at your wood production. That's massive! ",
                
          },
          :reward_text => {
            
            :de_DE => "Erweitere den Hozfäller für eine höhere Holzproduktion.",
  
            :en_US => "You will need more loggers.",
                
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_wood,
                :amount => 250,
              },

            ],

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
            
            :en_US => "Ressources",
  
            :de_DE => "Mehr Rohstoffe",
                
          },
          :task => {
            
            :en_US => "Enter an alliance, or start your own alliance.",
  
            :de_DE => "Baue Steinbruch und Holzfäller auf Level 3.",
                
          },
          :flavour => {
            
            :de_DE => "Feindliche Armeen mit Deinen eigenen Armeen zu bekämpfen, ist ja nett. Aber viel besser wäre es doch, wenn ihr zusammenarbeiten würdet oder wenn Deine Freunde Dir helfen würden.",
  
            :en_US => "Fighting enemy armies with your own army is great, but it's even better if you have help from your friends or you can work together with other players. You should be in an alliance - allies are there to help each other.",
                
          },
          :description => {
            
            :de_DE => "<p>Der Steinbruch und der Holzfäller sind Deine Rohstoffproduzenten.</p>",
  
            :en_US => "<p>From now on, you can enter an alliance. This has many advantages: you can exchange raw materials, help each other with defense and coordinate attacks. Only an alliance can hold a large territory.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hui, das ist aber eine tolle Allianz. Ich bin sicher, dass Ihr sehr weit kommen werdet.",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "Baue weitere oder verbessere Steinbruch und Holzfäller, um Deine Produktion zu erhöhen. ",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
          },

          :subquests => [17, 18, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'epic_ressources_',
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
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

          },          

          :reward_tests => {
            
          },          

          :place_npcs => 10,         

        },              #   END OF epic__more_ressources
        {               #   quest_build_quarry_lvl3
          :id                => 17,
          :symbolic_id       => :quest_build_quarry_lvl3,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Quarry",
  
            :de_DE => "Steinbruch Level 3",
                
          },
          :task => {
            
            :en_US => "Build a quarry.",
  
            :de_DE => "Baue einen Steinbruch Level 3.",
                
          },
          :flavour => {
            
            :de_DE => "Hey cool, Du kannst Steinbrüche bauen.",
  
            :en_US => "Cool - you can now build quarries.",
                
          },
          :description => {
            
            :de_DE => "<p>Der Steinbruch produziert Steine.</p>",
  
            :en_US => "<p>Build a quarry to improve your production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "So viel Stein, wie toll.",
  
            :en_US => "Wow – that's a lot of stone. Fantastic!",
                
          },
          :reward_text => {
            
            :de_DE => "Erweitere den Steinbruch für eine höhere Steinproduktion.",
  
            :en_US => "Quarries are very effective. Build more quarries!",
                
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 400,
              },

            ],

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
          :id                => 18,
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
  
            :de_DE => "Holzfäller Level 3",
                
          },
          :task => {
            
            :en_US => "Build a logger.",
  
            :de_DE => "Baue einen Holzfäller Level 3.",
                
          },
          :flavour => {
            
            :de_DE => "Der Chef sagt immer: 'Ein Brett in Ehren kann niemand verwehren!'.",
  
            :en_US => "If you want to increase production, you'll need to build more quarries and logging camps and then upgrade them.",
                
          },
          :description => {
            
            :de_DE => "<p>Holzfäller erhöhen Deine Holzproduktion.</p>",
  
            :en_US => "<p>Upgrade the logger to increase your production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na, das nenne ich mal Holz vor der Hütte!",
  
            :en_US => "Wow – look at your wood production. That's massive! ",
                
          },
          :reward_text => {
            
            :de_DE => "Erweitere den Hozfäller für eine höhere Holzproduktion.",
  
            :en_US => "You will need more loggers.",
                
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_wood,
                :amount => 400,
              },

            ],

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
        {               #   quest_build_2quarry_lvl4
          :id                => 19,
          :symbolic_id       => :quest_build_2quarry_lvl4,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Quarry",
  
            :de_DE => "Mehr Steinbrüche",
                
          },
          :task => {
            
            :en_US => "Build a quarry.",
  
            :de_DE => "Baue zwei Steinbrüche bis Level 4.",
                
          },
          :flavour => {
            
            :de_DE => "Hey cool, Du kannst Steinbrüche bauen.",
  
            :en_US => "Cool - you can now build quarries.",
                
          },
          :description => {
            
            :de_DE => "<p>Weitere Steinbrüche produziert Steine.</p>",
  
            :en_US => "<p>Build a quarry to improve your production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "So viel Stein, wie toll.",
  
            :en_US => "Wow – that's a lot of stone. Fantastic!",
                
          },
          :reward_text => {
            
            :de_DE => "Steigere Deine Steinproduktion durch weitere und verbesserte Steinbrüche.",
  
            :en_US => "Quarries are very effective. Build more quarries!",
                
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
          :id                => 20,
          :symbolic_id       => :quest_build_2logger_lvl4,
  
          :type              => :optional,
  
          :advisor           => :girl,
          :hide_start_dialog => true,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "Logger",
  
            :de_DE => "Mehr Holzfäller",
                
          },
          :task => {
            
            :en_US => "Build a logger.",
  
            :de_DE => "Baue zwei Holzfäller bis Level 4.",
                
          },
          :flavour => {
            
            :de_DE => "Der Chef sagt immer: 'Ein Brett in Ehren kann niemand verwehren!'.",
  
            :en_US => "If you want to increase production, you'll need to build more quarries and logging camps and then upgrade them.",
                
          },
          :description => {
            
            :de_DE => "<p>Weitere Holzfäller erhöhen Deine Holzproduktion.</p>",
  
            :en_US => "<p>Upgrade the logger to increase your production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na, das nenne ich mal Holz vor der Hütte!",
  
            :en_US => "Wow – look at your wood production. That's massive! ",
                
          },
          :reward_text => {
            
            :de_DE => "Steigere Deine Holzproduktion durch weitere und verbesserte Holzfäller.",
  
            :en_US => "You will need more loggers.",
                
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
        {               #   quest_alliance_epic
          :id                => 21,
          :symbolic_id       => :quest_alliance_epic,
  
          :type              => :epic,
  
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
            
            :de_DE => "Feindliche Armeen mit Deinen eigenen Armeen zu bekämpfen, ist ja nett. Aber viel besser wäre es doch, wenn ihr zusammenarbeiten würdet oder wenn Deine Freunde Dir helfen würden.",
  
            :en_US => "Fighting enemy armies with your own army is great, but it's even better if you have help from your friends or you can work together with other players. You should be in an alliance - allies are there to help each other.",
                
          },
          :description => {
            
            :de_DE => "<p>Mit einer Allianz kannst Du die Weltherrschaft erringen! Um einer Allianz beizutreten benötigst Du ein Lagerfeuer.</p>",
  
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

          :subquests => [22, 23, 24, ],

          :triggers => {
            
            :finish_quest_triggers => [
              
              {
                :finish_quest_trigger => 'quest__more_ressources_epic',
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

        },              #   END OF quest_alliance_epic
        {               #   quest_build_chiefcottagelvl5
          :id                => 22,
          :symbolic_id       => :quest_build_chiefcottagelvl5,
  
          :type              => :sub,
  
          :advisor           => :girl,
          :hide_start_dialog => false,
  
          :tutorial          => false,
          :tutorial_end_quest => false,
    
          :priority          => 0,
          :blocking          => false,

          :name => {
            
            :en_US => "An even bigger chieftain's hut",
  
            :de_DE => "Häuptlingshütte Level 5",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 5",
  
            :de_DE => "Verbessere die Häuptlingshütte auf Level 5.",
                
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
          :id                => 23,
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
          :id                => 24,
          :symbolic_id       => :quest_alliance,
  
          :type              => :sub,
  
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

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

          },          

          :reward_tests => {
            
            :alliance_test => {},

          },          

        },              #   END OF quest_alliance
        {               #   quest_charkills_1
          :id                => 25,
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

          :triggers => {
            
            :play_time_trigger => 600,
  
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
      ],                # END OF QUESTS

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts Tutorial::Tutorial.the_tutorial.to_json
#Tutorial.tutorial.quests.each do |value| 
#  puts value[:name][:de_DE] 
#end

