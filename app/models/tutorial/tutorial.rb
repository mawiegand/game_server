# encoding: utf-8  

require 'active_model'

# A module containing the tutorial quests of a particular game instance using the
# Augmented Worlds Engine.
#
# This particular file does hold the following set of rules:
# Game:    Wack-A-Doo
# Branch:  development (alpha)
# Version: 1.0.0
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
    
          :priority          => 1,
          :blocking          => true,

          :name => {
            
            :en_US => "The first building",
  
            :de_DE => "Der Sammler",
                
          },
          :task => {
            
            :en_US => "Give an order to a Level 1 Hunter Gatherer.",
  
            :de_DE => "Willkommen Halbgott! Baue einen Sammler.",
                
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
            
            :de_DE => "Der Sammler sammelt Steine und Holz für Deinen Rohstoffvorrat. Als nächstes solltest Du die Häuptlingshütte ausbauen.",
  
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
            
            :de_DE => "Im Ausbildungsgelände kannst Du Deine erste Einheit, den Krieger rekrutieren.",
  
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
            
            :en_US => "Build a warrior.",
  
            :de_DE => "Rekrutiere einen Krieger.",
                
          },
          :flavour => {
            
            :de_DE => "Hmm? Keine Einheiten weit und breit. Da sollte sich mal jemand drum kümmern, sonst wird diese Siedlung demnächst niedergebrannt.",
  
            :en_US => "What? Not a unit to be seen anywhere. Someone should pay attention to that or the settlement will soon be burned to the ground.",
                
          },
          :description => {
            
            :de_DE => "<p>Gehe in das Ausbildungsgelände, wähle dort in der Rekrutierungsliste ganz unten den Krieger aus.</p>",
  
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
            
            :de_DE => "Deine erste Armee wartet auf Befehle. Zeig gleich mal den Neandertaler wo die Keule hängt.",
  
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
            
            :de_DE => "Ein Kampf läuft meist über mehrere Runden, dabei können beliebig viele Armeen auf beiden Seiten dazukommen.",
  
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
            
            :en_US => "Move your army.",
  
            :de_DE => "Bewege Deine Armee.",
                
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
                :finish_quest_trigger => 'quest_army_move',
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
  
          :advisor           => :chef,
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
            
            :en_US => "More Ressources",
  
            :de_DE => "Mehr Rohstoffe",
                
          },
          :task => {
            
            :en_US => "Enter an alliance, or start your own alliance.",
  
            :de_DE => "Baue Sammler, Steinbruch und Holzfäller auf Level 3.",
                
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
            
            :de_DE => "Du solltest Deine Rohstoffproduktion laufend erhöhen.",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
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
  
            :de_DE => "Sammler Level 3",
                
          },
          :task => {
            
            :en_US => "Give an order to a Level 3 Hunter Gatherer.",
  
            :de_DE => "Verbessere Deinen Sammler auf Level 3.",
                
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
            
            :en_US => "Enter an alliance, or start your own alliance.",
  
            :de_DE => "Gründe eine oder trete einer Allainz bei.",
                
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
            
            :de_DE => "Du kannst das Profil der Allianz im Allianzmenü einsehen.",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
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
            
            :de_DE => "Jetzt kannst Du ein Lagerfeuer bauen und Dich einer Allianz anschließen.",
  
            :en_US => "Upgrading the chieftan's hut gives you the option to construct a wider range of buildings.",
                
          },

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
                :amount => 175,
              },

              {
                :resource => :resource_wood,
                :amount => 175,
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
            
            :de_DE => "Im Allianzmenü kannst Du auch sehen wie aktiv Deine Mitstreiter sind.",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
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
            
            :en_US => "Build a storage and start a trade",
  
            :de_DE => "Baue ein Rohstofflager und beginne einen Handel",
                
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
            
            :de_DE => "Je höher das Rostofflager, desto mehr Karren hast Du.",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
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
  
            :de_DE => "Rohstofflager",
                
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
            
            :de_DE => "Die Handelskarren im Rohstofflager erlauben Dir den Handel mit anderen Spielern.",
  
            :en_US => "The tradings carts in the raw material store let you trade with other players. Each trading cart can transport ten resources.",
                
          },

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
            
            :en_US => "First trade",
  
            :de_DE => "Erster Handel",
                
          },
          :task => {
            
            :en_US => "Start a trade.",
  
            :de_DE => "Beginne Deinen ersten Handel.",
                
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
            
            :de_DE => "Die Handelskarren benötigen eine Stunde für jeden Weg.",
  
            :en_US => "The tradings carts in the raw material store let you trade with other players. Each trading cart can transport ten resources.",
                
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
            
            :en_US => "Build a storage and start a trade",
  
            :de_DE => "Baue eine Kleine Hütte.",
                
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
            
            :de_DE => "Je höher die Baugeschwindigkeit, desto kürzer die Bauzeiten aller Gebäude.",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "Die Kleinen Hütten verkürzen die Bauzeit. Du kannst mehrere bauen.",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
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
            
            :en_US => "An even bigger chieftain's hut",
  
            :de_DE => "Häuptlingshütte Level 6",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 6",
  
            :de_DE => "Verbessere die Häuptlingshütte auf Level 6.",
                
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
                :resource => :resource_cash,
                :amount => 3,
              },

            ],

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
            
            :de_DE => "Du kannst jeden Ausbau sofort abschließen.",
  
            :en_US => "Boost your raw materials production by building a new Hunter Gatherer.",
                
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

            ],

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
  
            :de_DE => "Die kleinen Hütten",
                
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
            
            :de_DE => "<p>Kleine Hütten verkürzen die Bauzeit von Gebäuden. Du kannst mehrere bauen, um die Bauzeit deutlich zu senken.</p>",
  
            :en_US => "<p>Having small huts reduces the time it takes to construct other buildings.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut gemacht. Deine Arbeiter freuen sich und bauen schneller.",
  
            :en_US => "Well done! Your workers are happy and they're building things faster because of it.",
                
          },
          :reward_text => {
            
            :de_DE => "Kleine Hütten verringern die Bauzeit aller Ausbauten.",
  
            :en_US => "choose a Hunter Gatherer. A window will open showing the current status of your development, including the next upgrade level. Press Upgrade to get started.",
                
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 225,
              },

              {
                :resource => :resource_wood,
                :amount => 225,
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
            
            :en_US => "Build a storage and start a trade",
  
            :de_DE => "Sammel Erfahrung.",
                
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
            
            :de_DE => "Erfahrung erhälst Du in der Trainingshöhle, für Ausbauten und vor allem für Kämpfe.",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "Erfahrung erhälst Du in der Trainingshöhle, für Ausbauten und vor allem für Kämpfe.",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
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
            
            :en_US => "An even bigger chieftain's hut",
  
            :de_DE => "Häuptlingshütte Level 7",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 7",
  
            :de_DE => "Verbessere die Häuptlingshütte auf Level 7.",
                
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
            
            :de_DE => "Du hast die Trainingshöhle freigeschaltet.",
  
            :en_US => "Upgrading the chieftan's hut gives you the option to construct a wider range of buildings.",
                
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
            
            :de_DE => "In der Trainingshöhle kannst Du ungestört trainieren und Erfahrung sammeln.",
  
            :en_US => "You can do your workout in the training cave without any interruptions.",
                
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 120,
              },

              {
                :resource => :resource_wood,
                :amount => 120,
              },

            ],

            :experience_reward => 4500,

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
            
            :en_US => "Fur production",
  
            :de_DE => "Starte die Fellproduktion.",
                
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
            
            :de_DE => "Fell ist der wichtigste Rohstoff zur Produktion von Einheiten..",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "Baue mehr und verbesserte Kürschner. Deine Armee wird es dir danken!",
  
            :en_US => "Baue mehr und verbesserte Kürschner. Deine Armee wird es dir danken!",
                
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
            
            :en_US => "An even bigger chieftain's hut",
  
            :de_DE => "Häuptlingshütte Level 8",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 8",
  
            :de_DE => "Verbessere die Häuptlingshütte auf Level 8.",
                
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
  
            :de_DE => "Der Kürschner",
                
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
            
            :de_DE => "<p>Eine hohe Fellproduktion ist die Grundlage jeder größeren Armee. In den Kämpfen werden immer mal wieder Armeen aufgerieben, die gilt es nachzubauen.</p>",
  
            :en_US => "<p>You need good fur production if you want to recruit an impressive army.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Fell wird vor allem für den Aufbau einer schlagkräftigen Armee benötigt.",
  
            :en_US => "Nice! Now you can build a new army.",
                
          },
          :reward_text => {
            
            :de_DE => "Steigere Deine Fellproduktion um viele Einheiten bauen zu können.",
  
            :en_US => "Increase your fur production so that you can defend your settlements with more armies.",
                
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_fur,
                :amount => 250,
              },

            ],

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
            
            :en_US => "Recruit your first thrower.",
  
            :de_DE => "Rekrutiere Deinen ersten Fernkämpfer.",
                
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
            
            :de_DE => "Fell ist der wichtigste Rohstoff zur Produktion von Einheiten..",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "Fernkämpfer könne großen Schaden verursachen, sind aber anfällig im Nahkampf.",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
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
                :resource => :resource_fur,
                :amount => 500,
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
            
            :en_US => "An even bigger chieftain's hut",
  
            :de_DE => "Häuptlingshütte Level 9",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 9",
  
            :de_DE => "Verbessere die Häuptlingshütte auf Level 9.",
                
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
            
            :de_DE => "Du kannst jetzt einen Schießstand bauen und dort Fernkämpfer rekrutieren.",
  
            :en_US => "Upgrading the chieftan's hut gives you the option to construct a wider range of buildings.",
                
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
                :amount => 1000,
              },

            ],

            :experience_reward => 250,

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
  
            :de_DE => "Der Schießstand",
                
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
            
            :de_DE => "<p>Bau die Kupferschmelze weiter aus, auf Level 5 steht dir der stinkende Stall zur Verfügung.</p>",
  
            :en_US => "<p>Keep upgrading the copper smelter. At Level 5, you can unlock the smelly barn.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Muhaha, I don't like the smell, but I've got admit… those riders know what they're doing.",
  
            :en_US => "Muhaha, I don´t like the smell, but the riders know thier business.",
                
          },
          :reward_text => {
            
            :de_DE => "Ein höherer oder mehrere Schießstände beschleunigen die Rekrutierung von Fernkämpfern.",
  
            :en_US => "A cavalry can flank the melee and attack throwers directly. A riding army is also quicker than normal warriors.",
                
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 1500,
              },

              {
                :resource => :resource_wood,
                :amount => 3000,
              },

              {
                :resource => :resource_fur,
                :amount => 250,
              },

            ],

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
  
            :de_DE => "Kieselsteinwerfer",
                
          },
          :task => {
            
            :en_US => "Build a thrower.",
  
            :de_DE => "Rekrutiere einen Kieselsteinwerfer.",
                
          },
          :flavour => {
            
            :de_DE => "Hmm? Keine Einheiten weit und breit. Da sollte sich mal jemand drum kümmern, sonst wird diese Siedlung demnächst niedergebrannt.",
  
            :en_US => "What? Not a unit to be seen anywhere. Someone should pay attention to that or the settlement will soon be burned to the ground.",
                
          },
          :description => {
            
            :de_DE => "<p>Gehe in den Schießstand, wähle dort in der Rekrutierungsliste den Kieselsteinwerfer aus.</p>",
  
            :en_US => "<p>Go to the Training Grounds, select a warrior from the recruiting list at the bottom and then start training. Recruited units end up in the settlement´s garrison.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Aller Anfang ist schwer, aber da musst Du noch dran arbeiten. Fürs Erste stell ich Dir ein paar meiner Krieger zur Verfügung.",
  
            :en_US => "Everything's always difficult at first. You just have to stick with it. For now, I'll let you have some of my warriors.",
                
          },
          :reward_text => {
            
            :de_DE => "Fernkämpfer sollten immer von Nahkämpfern geschützt werden.",
  
            :en_US => "You can train several units at the same time. Just select the number of units you want.",
                
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

            :unit_rewards => [

              {
                :unit => :unit_thrower,
                :amount => 30,
              },

            ],

            :experience_reward => 250,

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
            
            :en_US => "Build a storage and start a trade",
  
            :de_DE => "Entwickle Dich in die Kupferzeit.",
                
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
            
            :de_DE => "Fell ist der wichtigste Rohstoff zur Produktion von Einheiten..",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "In der Kupferzeit stehen Dir neue und verbesserte Versionen bestehender Gebäude zur Verfügung.",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
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
            
            :en_US => "An even bigger chieftain's hut",
  
            :de_DE => "Häuptlingshütte Level 10",
                
          },
          :task => {
            
            :en_US => "Upgrade your chieftan's hut to level 10",
  
            :de_DE => "Verbessere die Häuptlingshütte auf Level 10.",
                
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
                :amount => 4000,
              },

              {
                :resource => :resource_wood,
                :amount => 4000,
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

            :experience_reward => 1500,

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
            
            :de_DE => "<p>Mit einer Allianz kannst Du die Weltherrschaft erringen! Um einer Allianz beizutreten benötigst Du ein Lagerfeuer.</p>",
  
            :en_US => "<p>From now on, you can enter an alliance. This has many advantages: you can exchange raw materials, help each other with defense and coordinate attacks. Only an alliance can hold a large territory.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Fell ist der wichtigste Rohstoff zur Produktion von Einheiten..",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "Fernkämpfer könne großen Schaden verursachen, sind aber anfällig im Nahkampf.",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
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
                :resource => :resource_fur,
                :amount => 1000,
              },

            ],

            :experience_reward => 500,

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
            
            :de_DE => "<p>Die Kupferschmelze Level 5 schaltet den Stall frei.</p>",
  
            :en_US => "<p>A copper smelter can be created in a small building slot. It gives you acces to buildings from the Copper Age.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Wow, eine neues Zeitalter! So viele Möglichkeiten.",
  
            :en_US => "Wow, a new age! So many opportunities! ",
                
          },
          :reward_text => {
            
            :de_DE => "Mit der verbesserten Kupferschmelze können wir endlich einen Stall bauen.",
  
            :en_US => "So, should we leave the Stone Age and move forward to the Copper Age?",
                
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
                :amount => 3000,
              },

            ],

            :experience_reward => 1500,

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
            
            :de_DE => "<p>Bau die Kupferschmelze weiter aus, auf Level 5 steht dir der stinkende Stall zur Verfügung.</p>",
  
            :en_US => "<p>Keep upgrading the copper smelter. At Level 5, you can unlock the smelly barn.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Muhaha, I don't like the smell, but I've got admit… those riders know what they're doing.",
  
            :en_US => "Muhaha, I don´t like the smell, but the riders know thier business.",
                
          },
          :reward_text => {
            
            :de_DE => "Ein höherer oder mehrere Schießstände beschleunigen die Rekrutierung von Fernkämpfern.",
  
            :en_US => "A cavalry can flank the melee and attack throwers directly. A riding army is also quicker than normal warriors.",
                
          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 3000,
              },

              {
                :resource => :resource_wood,
                :amount => 1500,
              },

              {
                :resource => :resource_fur,
                :amount => 250,
              },

            ],

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
            
            :de_DE => "<p>Gehe in den Stall, wähle dort in der Rekrutierungsliste den Straußenreiter aus.</p>",
  
            :en_US => "<p>Go to the Training Grounds, select a warrior from the recruiting list at the bottom and then start training. Recruited units end up in the settlement´s garrison.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Aller Anfang ist schwer, aber da musst Du noch dran arbeiten. Fürs Erste stell ich Dir ein paar meiner Krieger zur Verfügung.",
  
            :en_US => "Everything's always difficult at first. You just have to stick with it. For now, I'll let you have some of my warriors.",
                
          },
          :reward_text => {
            
            :de_DE => "Fernkämpfer sollten immer von Nahkämpfern geschützt werden.",
  
            :en_US => "You can train several units at the same time. Just select the number of units you want.",
                
          },

          :rewards => {
            
            :resource_rewards => [

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

            :experience_reward => 500,

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
            
            :en_US => "Found a encampment",
  
            :de_DE => "Gründe eine Lagerstätte.",
                
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
            
            :de_DE => "Fell ist der wichtigste Rohstoff zur Produktion von Einheiten..",
  
            :en_US => "Wow, that's some alliance! I'm sure they're going to go far.",
                
          },
          :reward_text => {
            
            :de_DE => "Jede Lagerstätte kannst Du ganz durch ein Spezialgebäude (Ritualstein, Feldlager oder Handelplatz) individuell gestalten.",
  
            :en_US => "You can see an alliance's profile by clicking on the alliance pennant on the top right, next to the raw materials overview.",
                
          },

          :subquests => [49, 50, 51, ],

          :triggers => {
            
            :mundane_rank_trigger => 2,
  
          },

          :rewards => {
            
            :resource_rewards => [

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
  
            :de_DE => "Lagerfeuer Level 10",
                
          },
          :task => {
            
            :en_US => "Build a campfire level 10.",
  
            :de_DE => "Vernessere das Lagerfeuer auf Level 10.",
                
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
            
            :de_DE => "Mit Level 10 des Lagerfeuers kannst Du einen Kleinen Häuptling rekrutieren.",
  
            :en_US => "Try to contact your neighbors and form an alliance with them.",
                
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

            ],

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
            
            :en_US => "Build a little chief.",
  
            :de_DE => "Rekrutiere einen Kleinen Chef.",
                
          },
          :flavour => {
            
            :de_DE => "Hmm? Keine Einheiten weit und breit. Da sollte sich mal jemand drum kümmern, sonst wird diese Siedlung demnächst niedergebrannt.",
  
            :en_US => "What? Not a unit to be seen anywhere. Someone should pay attention to that or the settlement will soon be burned to the ground.",
                
          },
          :description => {
            
            :de_DE => "<p>Bild am Lagerfeuer einen Kleinen Chef aus.</p>",
  
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

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_fur,
                :amount => 500,
              },

            ],

            :experience_reward => 500,

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
            
            :de_DE => "Lagerstätten können jederzeit von anderen Halbgöttern erobert werden. Als möglicher Schutz dient der Ritualstein.",
  
            :en_US => "Camps can be taken over be other demigods. You can protect the camp by building an altar.",
                
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
                :amount => 500,
              },

            ],

            :experience_reward => 1000,

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
            
            :en_US => "Name and profile",
  
            :de_DE => "Dein Name",
                
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
            
            :de_DE => "Im Profil kannst Du Deinen Fortschritt sehen und Dein Avatar gestalten.",
  
            :en_US => "In your profile you can see your progress and make other changes.",
                
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
            
            :de_DE => "<p>Weitere Steinbrüche erhöhen Deine Steinproduktion.</p>",
  
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
            
            :de_DE => "<p>Weitere Steinbrüche produzieren viel mehr Steine.</p>",
  
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
          :hide_start_dialog => true,
  
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
            
            :en_US => "Build two furrier level 4.",
  
            :de_DE => "Baue zwei Kürschner bis Level 4.",
                
          },
          :flavour => {
            
            :de_DE => "Hey cool, Du kannst Steinbrüche bauen.",
  
            :en_US => "Cool - you can now build quarries.",
                
          },
          :description => {
            
            :de_DE => "<p>Weitere Kürschner produzieren noch mehr Fell..</p>",
  
            :en_US => "<p>Build a quarry to improve your production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "So viel Stein, wie toll.",
  
            :en_US => "Wow – that's a lot of stone. Fantastic!",
                
          },
          :reward_text => {
            
            :de_DE => "Steigere Deine Fellproduktion durch weitere und verbesserte Kürschner.",
  
            :en_US => "Quarries are very effective. Build more quarries!",
                
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
            
            :de_DE => "Hey cool, Du kannst Steinbrüche bauen.",
  
            :en_US => "Cool - you can now build quarries.",
                
          },
          :description => {
            
            :de_DE => "<p>Mehr Fell ist immer besser.</p>",
  
            :en_US => "<p>Build a quarry to improve your production.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "So viel Stein, wie toll.",
  
            :en_US => "Wow – that's a lot of stone. Fantastic!",
                
          },
          :reward_text => {
            
            :de_DE => "Steigere Deine Fellproduktion durch weitere und verbesserte Kürschner.",
  
            :en_US => "Quarries are very effective. Build more quarries!",
                
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
            
            :de_DE => "Hey, Deine Siedlungen sehen schon toll aus, aber es wäre gut wenn sie mehr produzieren würden. Könntest Du Dich bitte darum kümmern?",
  
            :en_US => "Hey, so your settlements look okay, but they'd be even better if they produced more resources. Maybe you should do something about that.",
                
          },
          :description => {
            
            :de_DE => "<p>Die Festung kassiert bis zu 15% der Rohstoffproduktion jeder Siedlung in der Region als Steuer.</p>",
  
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
            
            :en_US => "Barracks Level 5",
  
            :de_DE => "Ausblidungsgelände Level 5",
                
          },
          :task => {
            
            :en_US => "Build barracks level 5.",
  
            :de_DE => "Verbessere das Ausbildungsgelände auf Level 5.",
                
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
            
            :de_DE => "Die Keulenkriger sind die ersten echten Einheiten.",
  
            :en_US => "A cavalry can flank the melee and attack throwers directly. A riding army is also quicker than normal warriors.",
                
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
            
            :en_US => "Build a clubber.",
  
            :de_DE => "Rekrutiere einen Keulenkrieger.",
                
          },
          :flavour => {
            
            :de_DE => "Hmm? Keine Einheiten weit und breit. Da sollte sich mal jemand drum kümmern, sonst wird diese Siedlung demnächst niedergebrannt.",
  
            :en_US => "What? Not a unit to be seen anywhere. Someone should pay attention to that or the settlement will soon be burned to the ground.",
                
          },
          :description => {
            
            :de_DE => "<p>Gehe in das Ausbilsungsgelände, wähle dort in der Rekrutierungsliste den Keulenkrieger aus.</p>",
  
            :en_US => "<p>Go to the Training Grounds, select a warrior from the recruiting list at the bottom and then start training. Recruited units end up in the settlement´s garrison.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Aller Anfang ist schwer, aber da musst Du noch dran arbeiten. Fürs Erste stell ich Dir ein paar meiner Krieger zur Verfügung.",
  
            :en_US => "Everything's always difficult at first. You just have to stick with it. For now, I'll let you have some of my warriors.",
                
          },
          :reward_text => {
            
            :de_DE => "Endlich vernüftige Keulen. Jetzt tut das Hauen wenigstens weh!",
  
            :en_US => "You can train several units at the same time. Just select the number of units you want.",
                
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
            
            :en_US => "Fortress",
  
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
            
            :en_US => "Infantry tower",
  
            :de_DE => "Knüppler Gelände",
                
          },
          :task => {
            
            :en_US => "Built an infantry tower.",
  
            :de_DE => "Baue ein Knüppler Gelände in Deiner Festung.",
                
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
            
            :de_DE => "Höhere Level beschleunigen die Einheitenrekrutierung der Nahkämpfer.",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "In der Festung kannst Du Steuern erheben und den Steuersatz ändern. Die Festung ist auch Standort einer weiteren Armee.",
  
            :en_US => "You can edit the tax rate in the fortress. A fortress is another army garrison.",
                
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
            
            :en_US => "Fortress fortification level 5",
  
            :de_DE => "Festungsanlage Level 5",
                
          },
          :task => {
            
            :en_US => "Built a fortress fortification level 5.",
  
            :de_DE => "Verbessere die Festungsanlagen auf Level 5.",
                
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
            
            :de_DE => "Höhere Level verbessern die Kampfkraft von Festungen.",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "In der Festung kannst Du Steuern erheben und den Steuersatz ändern. Die Festung ist auch Standort einer weiteren Armee.",
  
            :en_US => "You can edit the tax rate in the fortress. A fortress is another army garrison.",
                
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
  
            :de_DE => "Werfer Gelände",
                
          },
          :task => {
            
            :en_US => "Built an infantry tower.",
  
            :de_DE => "Baue ein Werfer Gelände in Deiner Festung.",
                
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
            
            :de_DE => "Höhere Level beschleunigen die Einheitenrekrutierung der Fernkämpfer.",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "In der Festung kannst Du Steuern erheben und den Steuersatz ändern. Die Festung ist auch Standort einer weiteren Armee.",
  
            :en_US => "You can edit the tax rate in the fortress. A fortress is another army garrison.",
                
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
            
            :en_US => "Fortress fortification level 7",
  
            :de_DE => "Festungsanlage Level 7",
                
          },
          :task => {
            
            :en_US => "Built a fortress fortification level 7.",
  
            :de_DE => "Verbessere die Festungsanlagen auf Level 7.",
                
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
            
            :de_DE => "Höhere Level verbessern die Kampfkraft von Festungen.",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "In der Festung kannst Du Steuern erheben und den Steuersatz ändern. Die Festung ist auch Standort einer weiteren Armee.",
  
            :en_US => "You can edit the tax rate in the fortress. A fortress is another army garrison.",
                
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
  
            :de_DE => "Reiteranlage",
                
          },
          :task => {
            
            :en_US => "Built an infantry tower.",
  
            :de_DE => "Baue eine Reiteranlage in Deiner Festung.",
                
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
            
            :de_DE => "Höhere Level beschleunigen die Einheitenrekrutierung der Reiter.",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "In der Festung kannst Du Steuern erheben und den Steuersatz ändern. Die Festung ist auch Standort einer weiteren Armee.",
  
            :en_US => "You can edit the tax rate in the fortress. A fortress is another army garrison.",
                
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
  
            :de_DE => "Versammlungsplatz Levle 6",
                
          },
          :task => {
            
            :en_US => "Built an infantry tower.",
  
            :de_DE => "Verbessere den Versammlungsplatz Deiner Lagerstätte auf Level 6.",
                
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
            
            :de_DE => "Du kannst jetzt eins der drei Spezialgebäude bauen. Entscheide Dich weise!",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "In der Festung kannst Du Steuern erheben und den Steuersatz ändern. Die Festung ist auch Standort einer weiteren Armee.",
  
            :en_US => "You can edit the tax rate in the fortress. A fortress is another army garrison.",
                
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
            
            :en_US => "Haunt level",
  
            :de_DE => "Spezialgebäude Ritualstein",
                
          },
          :task => {
            
            :en_US => "Built an infantry tower.",
  
            :de_DE => "Entscheide Dich für den Bau eines Ritualsteins.",
                
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
            
            :de_DE => "Der Ritualstein schützt Deine Lagerstätte vor feindlichen Übernahmen.",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "In der Festung kannst Du Steuern erheben und den Steuersatz ändern. Die Festung ist auch Standort einer weiteren Armee.",
  
            :en_US => "You can edit the tax rate in the fortress. A fortress is another army garrison.",
                
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
            
            :en_US => "Field camp",
  
            :de_DE => "Spezialgebäude Feldlager",
                
          },
          :task => {
            
            :en_US => "Built an infantry tower.",
  
            :de_DE => "Entscheide Dich für den Bau eines Feldlager.",
                
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
            
            :de_DE => "Das Feldlager vergrößert Deine Armee und liefert auf Level 10 einen zusätzlichen Kommandopunkt.",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "In der Festung kannst Du Steuern erheben und den Steuersatz ändern. Die Festung ist auch Standort einer weiteren Armee.",
  
            :en_US => "You can edit the tax rate in the fortress. A fortress is another army garrison.",
                
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
            
            :en_US => "Trade center",
  
            :de_DE => "Spezialgebäude Handelszentrum",
                
          },
          :task => {
            
            :en_US => "Built an infantry tower.",
  
            :de_DE => "Entscheide Dich für den Bau eines Handelszentrum.",
                
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
            
            :de_DE => "Das Handelszentrum verbessert Deine Rohstoffproduktion, läßt Deine Lagerstätte aber fast wehrlos.",
  
            :en_US => "You conquered a fortress? That´s great!",
                
          },
          :reward_text => {
            
            :de_DE => "In der Festung kannst Du Steuern erheben und den Steuersatz ändern. Die Festung ist auch Standort einer weiteren Armee.",
  
            :en_US => "You can edit the tax rate in the fortress. A fortress is another army garrison.",
                
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

