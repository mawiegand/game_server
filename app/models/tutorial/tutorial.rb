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

  attr_accessor :version, :quests, :updated_at, :num_tutorial_quests
  
  def attributes 
    { 
      'version'             => version,
      'quests'              => quests,
      'updated_at'          => updated_at,
      'num_tutorial_quests' => num_tutorial_quests,
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
      
      :updated_at => File.ctime(__FILE__),
  
# ## QUESTS ##########################################################
  
      :num_tutorial_quests => 4,
  
      :quests => [  # ALL QUESTS

        {               #   quest_queue_1gathererlvl1
          :id                => 0, 
          :symbolic_id       => :quest_queue_1gathererlvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          
          :name => {
            
            :en_US => " the first building",
  
            :de_DE => "Das erste Gebäude",
                
          },
          :task => {
            
            :en_US => "Build one Gatherer",
  
            :de_DE => " Gib einen Jäger und Sammler Level 1 in Auftrag. ",
                
          },
          :flavour => {
            
            :de_DE => "Willkommen Halbgott. Schau Dir Deine Siedlung an, ist sie nicht wundervoll? Vielleicht noch ein bisschen leer. Wenn Du einen Jäger und Sammler bauen würdest, sähe das bestimmt viel besser aus und er gibt Dir einen Teil der Rohstoffe ab, die er findet.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Um einen Jäger und Sammler in Auftrag zu geben, klicke auf einen Bauplatz, und klicke dort auf Jäger und Sammler. Du kannst jederzeit alle laufenden Quests sehen, indem Du oben rechts auf den Quests Knopf drückst.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut gemacht. Jetzt müssen wir kurz warten, während Deine Arbeiter den Auftrag fertigstellen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Der Jäger und Sammler taucht rechts in der Gebäudeproduktion auf. Dort kannst Du sehen, wie lange es dauert, bis das Gebäude fertiggestellt wird. Du kannst Aufträge abbrechen oder beschleunigen. Bauaufträge laufen auch weiter, wenn Du nicht im Spiel bist. ",
  
            :en_US => " ",
                
          },

          :successor_quests => [1, ],

          :reward_tests => {
            
            :construction_queue_tests => [

              {
                :building => 'building_gatherer',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_queue_1gathererlvl1
        {               #   quest_end_1gathererlvl1
          :id                => 1, 
          :symbolic_id       => :quest_end_1gathererlvl1,
          :advisor           => :girl,
          :hide_start_dialog => true,
          :tutorial          => true,
          
          :name => {
            
            :en_US => " the first building",
  
            :de_DE => "Auf den Bauauftrag warten.",
                
          },
          :task => {
            
            :en_US => "Build one Gatherer",
  
            :de_DE => " Warte bis der Jäger und Sammler Level 1 fertiggestellt wurde.",
                
          },
          :flavour => {
            
            :de_DE => "Mehr als warten können wir grad nicht.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Bauaufträge brauchen Zeit. Sie werden allerdings auch weiter ausgeführt, wenn Du nicht im Spiel bist.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => " Hey, dass sieht doch schon viel besser aus, findest Du nicht?  Der nette Sammler will Dir sogar ein paar Rohstoffe schenken.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Der Jäger und Sammler sammelt alle verschiedenen Rohstoffe in geringen Mengen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_queue_1gathererlvl1',

          },

          :successor_quests => [2, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 35,
              },

              {
                :resource => :resource_wood,
                :amount => 35,
              },

              {
                :resource => :resource_fur,
                :amount => 10,
              },

            ],

            :experience_reward => 350,

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

        },              #   END OF quest_end_1gathererlvl1
        {               #   quest_build_1gathererlvl1
          :id                => 2, 
          :symbolic_id       => :quest_build_1gathererlvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          
          :name => {
            
            :en_US => "Ein zweiter Jäger und Sammler",
  
            :de_DE => "",
                
          },
          :task => {
            
            :en_US => "Baue einen zweiten Jäger und Sammler Level 1, um Deine Produktion zu erhöhen.",
  
            :de_DE => "Baue einen zweiten Jäger und Sammler Level 1, um Deine Produktion zu erhöhen.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Rohstoffproduktion ist noch sehr niedrig. Du siehst sie in den drei Felder oben links. Lass uns einen zweiten Sammler bauen, um das zu verbessern.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Deine Sammler produziert die drei Rohstoffe Stein, Holz und Fell. Die großen Zahlen in den drei Feldern oben links zeigen Dir Deinen aktuellen Lagerbestand. Ganz wichtig sind die Zahlen hinter dem '+'. Sie zeigen Dir Deine Rohstoffproduktion pro Stunde.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Cool, jetzt hast Du zwei Sammler und Deine Produktion steigt. Mit dieser Belohnung erhöht sich Dein Lagerbestand.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Sammler erhöhen Deine Rohstoffproduktion.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_end_1gathererlvl1',

          },

          :successor_quests => [53, ],

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
                :amount => 30,
              },

            ],

            :experience_reward => 200,

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
        {               #   quest_build_2gathererlvl1
          :id                => 3, 
          :symbolic_id       => :quest_build_2gathererlvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Noch mehr Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue zwei weitere Jäger und Sammler Level 1.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Häuptlingshütte ist jetzt größer, dadurch hast Du auch mehr Bauplätze frei. Hey, wusstest Du, dass Du Deinen Arbeitern zwei Aufträge erteilen kannst? Sie können zwar nur an einem arbeiten, aber sie merken sich den anderen. Wie wäre es, wenn Du das mal versuchst?",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Es wäre schlau noch zwei weitere Jäger und Sammler in Auftrag zu geben. Rohstoffe sind die Grundlage jeder Herrschaft!</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, Deine Siedlung sieht mit jeder Minute besser aus.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Du solltest darauf achten, dass Du immer etwas baust oder ausbaust. Jäger und Sammler bauen ist nie verkehrt.",
  
            :en_US => " ",
                
          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 65,
              },

              {
                :resource => :resource_wood,
                :amount => 55,
              },

              {
                :resource => :resource_fur,
                :amount => 25,
              },

            ],

            :experience_reward => 100,

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
          :id                => 4, 
          :symbolic_id       => :quest_build_1gathererlvl2,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Ausbau",
                
          },
          :task => {
            
            :en_US => "Baue einen Jäger und Sammler auf Level 2 aus.",
  
            :de_DE => " Baue einen Jäger und Sammler auf Level 2 aus. ",
                
          },
          :flavour => {
            
            :de_DE => "Siehst Du, so weit bist Du schon gekommen. Könntest Du bitte einen Jäger und Sammler auf Level 2 ausbauen? Dann fühlt er sich wohler und bringt Dir mehr Ressourcen.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Wähle dazu einen Jäger und Sammler aus. Das Grundstück, das Du bei einem Klick auswählen würdest, erkennst Du am orangenen Rahmen. Im sich öffnenden Fenster siehst Du oben den derzeitigen Stand Deines Vorhabens, darunter die nächste Ausbaustufe. Klicke auf 'Ausbauen', um den Ausbau zu beginnen.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Wie nett von Dir. Der Sammler freut sich wie verrückt. Er hat mir ein paar Rohstoffe für Dich mitgegeben.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Denke daran, Deine Gebäude auszubauen. Jedes Level bringt eine höhere Produktion. Gebäude auf kleinen Bauplätzen können maximal bis Level 10 ausgebaut werden.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_quest_button',

          },

          :successor_quests => [54, 55, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 40,
              },

              {
                :resource => :resource_wood,
                :amount => 45,
              },

              {
                :resource => :resource_fur,
                :amount => 15,
              },

            ],

            :experience_reward => 150,

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
        {               #   quest_build_chiefcottagelvl2
          :id                => 5, 
          :symbolic_id       => :quest_build_chiefcottagelvl2,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 2",
  
            :de_DE => "Ausbau der Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 2 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Halbgott? Und was soll das da sein? Meine Häuptlingshütte? Da kann ja niemand drin leben! Ändere das sofort! Bau sie aus und ich gebe Dir eine Belohnung.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Die Häuptlingshütte ist das große Gebäude in der Mitte der Siedlung.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Endlich fertig hm? Hat ja ewig gedauert. Wie Belohnung? Wofür? Reicht es Dir nicht, dass Deine Siedlung größer ist und Du ein neues Gebäude bauen kannst? Manche haben auch nie genug. Hier, nimm das und verschwinde.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Der Ausbau der Häuptlingshütte schaltet neue Gebäudearten frei und erlaubt Dir mehr Gebäude zu bauen. Zusätzliche Level der Häuptlingshütte lassen Dich mehr Gebäude bauen.",
  
            :en_US => " ",
                
          },

          :successor_quests => [],

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

              {
                :resource => :resource_cash,
                :amount => 1,
              },

            ],

            :experience_reward => 400,

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

        },              #   END OF quest_build_chiefcottagelvl2
        {               #   quest_profile
          :id                => 6, 
          :symbolic_id       => :quest_profile,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Namen und Profil",
  
            :de_DE => "Namen und Profil",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Ändere Deinen Namen.",
                
          },
          :flavour => {
            
            :de_DE => "Achte nicht auf den Chef, der ist immer so drauf. Jetzt haben wir schon so viel zusammen erlebt und ich weiß immer noch nicht wie Du heißt. Bitte sag mir Deinen Namen. ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Klicke dazu auf den Profil-Knopf (der mit dem Kopf) oben rechts. Klicke dann auf Reiter 'Anpassung' und wähle dort 'Namen ändern'. Die ersten zwei Namensänderungen sind kostenlos.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Danke. Ich denke wir werden viel Spass miteinander haben.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Im Profil kannst Du Deinen Fortschritt sehen und weitere Änderungen vornehmen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_queue_chiefcottagelvl2_V2',

          },

          :successor_quests => [8, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 35,
              },

              {
                :resource => :resource_wood,
                :amount => 50,
              },

              {
                :resource => :resource_fur,
                :amount => 15,
              },

            ],

            :experience_reward => 200,

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_change_profile',
            },

          },          

        },              #   END OF quest_profile
        {               #   quest_settlement_button1
          :id                => 7, 
          :symbolic_id       => :quest_settlement_button1,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Karte",
  
            :de_DE => "Auf die Karte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Begib Dich auf die Weltkarte.",
                
          },
          :flavour => {
            
            :de_DE => "Was? Dir ist es hier zu klein? Es gibt eine riesige Welt zu erobern. Wenn Du mal aus diesem Loch rauskommen würdest, wüsstest Du das auch. Worauf wartest Du? Geh!",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Drücke dazu den Siedlungsknopf. Das ist der große Knopf, mit den Häusern, oben rechts in der Ecke.</p><p>Der Knopf wechselt auf die Weltkarte und zentriert sie auf die Region mit Deiner Siedlung, egal wo Du bist.</p><p>Wenn Du zurück in Deine Siedlung willst, wähle Deine Siedlung aus und klicke auf 'Betreten'.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na, was gelernt? Hier hast Du noch ein paar Ressourcen, bevor Du wieder nach einer Belohnung fragst.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Auf der Weltkarte kannst Du andere Spieler um Dich herum sehen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_2cottagelvl1',

          },

          :successor_quests => [9, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 40,
              },

              {
                :resource => :resource_wood,
                :amount => 30,
              },

              {
                :resource => :resource_fur,
                :amount => 25,
              },

            ],

            :experience_reward => 200,

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_settlement_button1',
            },

          },          

        },              #   END OF quest_settlement_button1
        {               #   quest_rank
          :id                => 8, 
          :symbolic_id       => :quest_rank,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Rang",
  
            :de_DE => "Rang",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Suche Deinen derzeitigen Rang heraus.",
                
          },
          :flavour => {
            
            :de_DE => "So so, fühlst Dich nicht mehr so groß? Sag mir, wie stehst Du eigentlich im Vergleich zu den ganzen anderen Halbgöttern da?",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Klicke dazu auf den Ranglisten-Knopf, oben rechts. Die Rangliste öffnet sich in einem neuen Fenster. Suche dort Deinen Namen und trage Deinen Rang in das Textfeld ein.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Oh, Du kleiner Halbgott. Das ist ja schrecklich. Das muss besser werden! Hier sind ein paar Rohstoffe, verschwende sie nicht.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Die Rangliste ist nach der Bevölkerung sortiert. Baue Deine Siedlung aus, um Deine Bevölkerung zu erhöhen und in der Rangliste zu steigen.",
  
            :en_US => "",
                
          },

          :requirement => {
            
            :quest => 'quest_profile',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 55,
              },

              {
                :resource => :resource_wood,
                :amount => 45,
              },

              {
                :resource => :resource_fur,
                :amount => 15,
              },

            ],

            :experience_reward => 200,

          },          

          :reward_tests => {
            
            :textbox_test => {
              :id => 'test_army_rank',
            },

          },          

        },              #   END OF quest_rank
        {               #   quest_settlementowner
          :id                => 9, 
          :symbolic_id       => :quest_settlementowner,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Festungen",
  
            :de_DE => "Festungsbesitzer",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Trage den Besitzer der Festung in Deiner Region ein.",
                
          },
          :flavour => {
            
            :de_DE => "Festungen sind die Zentren der Macht. Hol sie Dir! Wie? Du weißt nicht, dass die Festung die Region beherrscht? Ich glaub' es einfach nicht, dass Du so etwas einfaches nicht weißt. Sieh sofort nach, wem die Festung in Deiner Region gehört!",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Die Festung ist in der Mitte der Region, wenn Du die Karte auf Deiner Region zentriert hast. Wer der Besitzer der Festung ist, steht direkt unter der Festung.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Aha, dem sollten wir eine Lektion erteilen!",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Festungen ziehen Steuern aus der Region ein, die sie beherrschen. Der Steuersatz liegt bei 5-15% und wird von der Rohstoffproduktion der Siedlungen in dem Gebiet abgezogen und an den Besitzer der Festung übergeben.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_settlement_button1',

          },

          :successor_quests => [11, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 50,
              },

              {
                :resource => :resource_wood,
                :amount => 55,
              },

              {
                :resource => :resource_fur,
                :amount => 15,
              },

            ],

            :experience_reward => 150,

          },          

          :reward_tests => {
            
            :textbox_test => {
              :id => 'test_fortress_owner',
            },

          },          

        },              #   END OF quest_settlementowner
        {               #   quest_message
          :id                => 10, 
          :symbolic_id       => :quest_message,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Nachrichten",
  
            :de_DE => "Nachrichten",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Lies die Nachricht.",
                
          },
          :flavour => {
            
            :de_DE => "Um die Nachricht zu lesen, klicke auf den Nachrichten-Knopf oben rechts und wähle dann die Nachricht auf der rechten Seite aus.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Um mit anderen Halbgöttern zu kommunizieren, kannst Du ihnen Nachrichten schicken. Ich hab Dir eine Nachricht geschickt, lies sie doch bitte.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ich hoffe, sie hat Dir gefallen. Hier, diese Kröten hab ich gerade gefunden. Ich glaube Du kannst sie ganz gut gebrauchen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Du hast gerade Kröten bekommen. Mit Kröten kannst Du den Ausbau von Gebäuden und die Ausbildung von Truppen beschleunigen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1barrackslvl2',

          },

          :successor_quests => [12, 19, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_wood,
                :amount => 200,
              },

              {
                :resource => :resource_stone,
                :amount => 200,
              },

              {
                :resource => :resource_fur,
                :amount => 100,
              },

              {
                :resource => :resource_cash,
                :amount => 2,
              },

            ],

            :experience_reward => 150,

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_open_message',
            },

          },          

          :message => {
            
            :en => {
              :subject => 'Subject',
              :body => "Message with content",
            },

            :de => {
              :subject => 'Nachricht vom Questgeber',
              :body => "Hey, toll Du hast die Nachricht gefunden. Wenn Du wieder auf die Karte willst, drücke wie überall auf oben rechts auf den Siedlung-Knopf.<br/>Als Belohnung habe ich drei Kröten für Dich. Mit Kröten kannst Du den Ausbau eines Gebäudes sofort fertig stellen. Versuche es doch bei der Häuptlingshütte.",
            },

          },          

        },              #   END OF quest_message
        {               #   quest_settlement_button2
          :id                => 11, 
          :symbolic_id       => :quest_settlement_button2,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Karte",
  
            :de_DE => "Zurück in die Siedlung",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Begib Dich zurück in Deine Siedlung.",
                
          },
          :flavour => {
            
            :de_DE => "Du findest Deine Siedlung nicht mehr? Das ist ganz einfach, ich erklär's Dir. Dann kannst Du es versuchen.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Benutze den Siedlungsknopf, um die Karte über Deiner Siedlung zu zentrieren. Gehe dann in die Siedlung. Drücke dazu oben rechts auf den Siedlungsknopf um die Karte auf Deiner Siedlung zu zentrieren. Zurück in Deine Siedlung kommst Du, indem Du die Siedlung anwählst und auf Enter drückst.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na? Ging doch ganz einfach, oder?",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Alle Deine Siedlungen und Festungen kannst Du betreten, indem Du sie auswählst und Enter drückst.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_settlementowner',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 45,
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

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_settlement_button2',
            },

          },          

        },              #   END OF quest_settlement_button2
        {               #   quest_encyclopedia
          :id                => 12, 
          :symbolic_id       => :quest_encyclopedia,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Enzyklopädie",
  
            :de_DE => " Enzyklopädie ",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Trage die Holzkosten eines Ausbildungsgeländes auf Level 2 ein.",
                
          },
          :flavour => {
            
            :de_DE => " Hey, der Chef hat mich gefragt, wie viel Holz der Ausbau eines Ausbildungsgeländes kostet, aber ich finde es einfach nicht in der Enzyklopädie. Schau mal. Kannst Du bitte gucken, ob Du es findest? ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Gehe auf die Karte und klicke auf den Enzyklopädie-Knopf unten links. Wähle dann 'Gebäude' aus und klicke auf Ausbildungsgelände. Suche dort die Holzkosten von Level 2 und gib sie hier ein.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Du hast es gefunden? Super, ich geh gleich zum Chef.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " In der Enzyklopädie stehen die Kosten und Bauzeiten aller Einheiten und Gebäude und andere nützliche Informationen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_message',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 35,
              },

              {
                :resource => :resource_wood,
                :amount => 55,
              },

              {
                :resource => :resource_fur,
                :amount => 25,
              },

            ],

            :experience_reward => 200,

          },          

          :reward_tests => {
            
            :textbox_test => {
              :id => 'test_costs',
            },

          },          

          :message => {
            
            :en => {
              :subject => 'Welcome to Wack-a-Doo',
              :body => "<h2>Welcome to the half-offical testround of Wack-a-Doo</h2>
                <p>With this round we will be testing our software and our servers. Nevertheless, we hope you'll enjoy playing Wack-a-Doo.</p>
                <p>Presently, there's no tutorial. To get started, please have a look at these screenshots explaining the interface:</p>
                <p style='margin-left: 32px;'><a href='http://wiki.wack-a-doo.de/Benutzeroberfläche' target='_blank'>http://wiki.wack-a-doo.de/Benutzeroberfläche</a></p>
                <p>Wack-a-Doo is still under construction. In this testround we will fix bugs on the fly, and also introduce new features while you're playing. So please expect changes and more interesting stuff to come.</p>
                <p>We would be pleased to get your feedback, either via email or by posting in the forum (German):</p>
                <p style='margin-left: 32px;'><a href='http://forum.uga-agga.de' target='_blank'>http://forum.uga-agga.de</a></p>
                <p>A more detailed description of game mechanics and attributes of buildings and units can be found in our wiki (presently only in German):</p>
                <p style='margin-left: 32px;'><a href='http://wiki.wack-a-doo.de' target='_blank'>http://wiki.wack-a-doo.de</a></p>
                <p>We wish you a pleasent time in Wack-a-Doo.</p>
                <p>The Wack-a-Doo Team</p>",
            },

            :de => {
              :subject => 'Willkommen bei Wack-a-Doo',
              :body => "<h2>Willkommen in der öffentlichen Betarunde.</h2>
                <p>Unser Spiel 'Wack-a-doo' befindet sich mitten in der Entwicklung. In der jetzigen Form ist Wack-a-doo bereits als vollständiges Spiel spielbar und hat im Rahmen der ersten Tests sehr viel Spass gemacht.</p>  
                <p>Im Laufe dieser Runde werden wir viele neue Erweiterungen und Spielmechaniken einführen und das Spielerlebnis verbessern. Lass Dich überraschen!</p>
                <p>Zur besseren Orientierung empfehlen wir Dir die Übersichten in der Enzyklopädie und die Erklärungen zur Benutzeroberfläche anzuschauen:</p>
                <p style='margin-left: 32px;'><a href='http://wiki.wack-a-doo.de/Benutzeroberfläche' target='_blank'>http://wiki.wack-a-doo.de/Benutzeroberfläche</a></p>
                <p>Dort werden alle wesentlichen Menüfunktionen anhand von Screenshots erklärt.</p>
                <p>Wir bitten Dich uns Feedback zu geben oder Fehlermeldungen zu melden. Dafür wurde uns von Shadow-Dragon ein Forumsbereich im Uga-Agga Forum eingerichtet:</p>
                <p style='margin-left: 32px;'><a href='http://forum.uga-agga.de' target='_blank'>http://forum.uga-agga.de</a></p>
                <p>Bitte melde jeden Fehler, damit wir entsprechend schnell reagieren können. Auch Feedback, Ideen oder konstruktive Meinungen sind dort sehr gerne gesehen.</p>
                <p>Wesentliche Spielmechanismen, Übersichten und Erklärungen findest Du in der Enzykloädie und in unserem Wiki zusammengefasst:</p>
                <p style='margin-left: 32px;'><a href='http://wiki.wack-a-doo.de' target='_blank'>http://wiki.wack-a-doo.de</a></p>
                <p>Das Wiki ist lange nicht vollständig und befindet sich wie alles andere in Wack-a-Doo noch im Aufbau. Du bist eingeladen uns durch Mitarbeit am Wiki zu unterstützen und das Wiki auf einem aktuellen Niveau zu halten. Zur Zeit können im Wiki ohne Anmeldungen Inhalte eingetragen oder abgeändert werden.</p>
                <p>Wir wünschen Dir viel Spass an Wack-a-Doo.</p>
                <p>Das Wack-a-Doo Team</p>",
            },

          },          

        },              #   END OF quest_encyclopedia
        {               #   quest_build_1cottagelvl1
          :id                => 13, 
          :symbolic_id       => :quest_build_1cottagelvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Hütten",
  
            :de_DE => "Die kleine Hütte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue eine kleine Hütte.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Arbeiter haben ja noch keine Unterkunft. Bitte baue ihnen doch eine kleine Hütte. Je besser es Deinen Arbeitern geht, desto schneller bauen sie auch.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Kleine Hütten verkürzen die Bauzeit von Gebäuden. </p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut gemacht. Deine Arbeiter freuen sich und bauen schneller.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Dir die Bauaufträge zu lange dauern, kannst Du mehr kleine Hütten bauen und weiter ausbauen.",
  
            :en_US => " ",
                
          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 60,
              },

              {
                :resource => :resource_wood,
                :amount => 50,
              },

              {
                :resource => :resource_fur,
                :amount => 25,
              },

            ],

            :experience_reward => 100,

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
          :id                => 14, 
          :symbolic_id       => :quest_build_chiefcottagelvl3,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Chief Cottage l3",
  
            :de_DE => "Eine noch größere Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 3 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Siedlung kommt ganz schön voran. Aber Du muss jetzt die Häuptlingshütte ausbauen um weiterzukommen, das bringt Dir nämlich einen großen Bauplatz.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Mit Ausbau der Häuptlingshütte kannst Du mehr Gebäude und auch neue Gebäude bauen.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll. Wenn Du willst, kannst Du dein nächstes Gebäude auf einen großen Bauplatz stellen. Auf diesen Bauplätzen kannst Du Gebäude viel weiter ausbauen, als auf kleinen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Auf großen Bauplätzen können Gebäude bis auf Level 20 ausgebaut werden. Gebäude des Levels 11 bis 20 geben spezielle Boni.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_2cottagelvl1',

          },

          :successor_quests => [15, ],

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

            :experience_reward => 400,

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
          :id                => 15, 
          :symbolic_id       => :quest_build_1barrackslvl1,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Barracks",
  
            :de_DE => "Ausbildungsgelände",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue ein Ausbildungsgelände.",
                
          },
          :flavour => {
            
            :de_DE => "Du kannst ein Ausbildungsgelände bauen machst es aber nicht? Bau sofort eins und ich gebe Dir etwas aus meiner Schatzkiste.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Ein Ausbildungsgelände bildet Nahkampfeinheiten aus. Die besten Einheiten werden auf Level 20 freigeschaltet, dafür müsstest Du aber auf einen großen Bauplatz bauen.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Fertig? Na endlich! Da, Deine Belohnung, mehr gibt's nicht. Verschwinde.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Das Ausbildungsgelände verkürzt auch die Rekrutierungszeit der Nahkampfeinheiten.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl3',

          },

          :successor_quests => [16, 56, ],

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
                :amount => 90,
              },

            ],

            :experience_reward => 150,

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
          :id                => 16, 
          :symbolic_id       => :quest_recruit_1clubbers,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Einheiten",
  
            :de_DE => "Deine erste Einheit",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue einen Keulenkrieger.",
                
          },
          :flavour => {
            
            :de_DE => "Hmm? Keine Einheiten weit und breit. Da sollte sich mal jemand drum kümmern, sonst wird diese Siedlung demnächst niedergebrannt.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Gehe in das Ausbildungsgelände, wähle dort den Keulenkrieger in der Rekrutierungsliste ganz unten aus und klicke auf 'Rekrutiere Keulenkrieger'. Die rekrutierten Einheiten landen in der Garnison der Siedlung und werden in der Häuptlingshütte angezeigt. </p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Aller Anfang ist schwer, aber da musst Du noch dran arbeiten. Fürs erste stell ich Dir drei meiner Keulenkrieger zur Verfügung.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Nachdem Du Einheiten in Auftrag gegeben hast, kannst Du das Gebäudefenster schließen, der Auftrag läuft trotzdem weiter. Wenn Du wissen willst, wie weit der Auftrag ist, klickst Du einfach wieder auf das Ausbildungsgelände. Du kannst auch mehrere Einheiten gleichzeitig trainieren, dazu gibst Du die gewünschte Zahl anstatt der 1 ein und klickst dann auf 'Rekrutiere'. Neue Einheiten werden auf höheren Gebäudelevel freigeschaltet.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1barrackslvl1',

          },

          :successor_quests => [17, ],

          :rewards => {
            
            :unit_rewards => [

              {
                :unit => :unit_clubbers,
                :amount => 3,
              },

            ],

            :experience_reward => 200,

          },          

          :reward_tests => {
            
            :training_queue_tests => [

              {
                :unit => 'unit_clubbers',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_recruit_1clubbers
        {               #   quest_army_create
          :id                => 17, 
          :symbolic_id       => :quest_army_create,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Armee",
  
            :de_DE => "Deine erste Armee",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Stelle eine Armee auf.",
                
          },
          :flavour => {
            
            :de_DE => "Einheiten in Garnisonen können sich nicht bewegen. Um Einheiten zu bewegen müssen sie aus der Garnison in eine Armee verschoben werden. Ich habe Dir ja gerade drei Keulenkrieger zur Verfügung gestellt. Mit denen müsste das jemand mal machen.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Gehe auf die Karte und wähle Deine Siedlung aus. Wähle unten rechts im Inspektor 'Neue Armee'.</p><p>Der Dialog zeigt Dir auf der linken Seite die Einheiten der Garnison und auf der rechten Seite die Einheiten in der Armee. Mit den Pfeilen kannst Du die Einheiten in die Armee verschieben.</p><p>Gib Deiner Armee einen Namen und drücke zum Bestätigen auf 'Erzeugen'.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Das soll eine Armee sein? Ziemlich klein, oder? Trotzdem hier Deine Belohnung.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jede Armee benötigt einen Kommandopunkt in der Siedlung, aus der sie erstellt wird. Außerdem hat sie ein Einheitenlimit.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_recruit_1clubbers',

          },

          :successor_quests => [57, ],

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
                :amount => 25,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_clubbers,
                :amount => 6,
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

        },              #   END OF quest_army_create
        {               #   quest_army_move
          :id                => 18, 
          :symbolic_id       => :quest_army_move,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Armeebewegung",
  
            :de_DE => "Armeebewegung",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Bewege Deine Armee zur Festung",
                
          },
          :flavour => {
            
            :de_DE => "Eine Armee kann mehr als nur herumstehen. Sie ist dazu da die Feinde des Stammes zu vernichten. Aber natürlich sollte ein Angriff nicht überstürzt sein. Vorsicht ist geboten, erst wenn eine Armee stark genug ist, sollte sie sich auf den Weg zu einer feindlichen Festung machen.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Wenn Du bereit bist, wähle Deine Armee aus, klicke auf 'Bewegen' und dann auf das Ziel. Mögliche Ziele sind mit einem grünen Pfeil markiert. Bewegungen zu von Spielern kontrollierten Festungen sollten nur mit Einverständnis des Spielers oder mit genügender Kampfstärke erfolgen.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hm? Die Armee ist unterwegs? Sicher, dass Du genug Truppen hast? Na okay, ich glaub Dir ja, hier hast Du ein paar Rohstoffe, für Verstärkungen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Unter Deiner Armee siehst Du die verfügbaren Aktionspunkte. Jede Bewegung und jeder Angriff kostet Dich einen Aktionspunkt. Über Zeit regenerieren Armeen ihre Aktionspunkte wieder.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_army_reinforce',

          },

          :successor_quests => [],

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
                :amount => 120,
              },

            ],

            :experience_reward => 250,

          },          

          :reward_tests => {
            
            :movement_test => {},

          },          

        },              #   END OF quest_army_move
        {               #   quest_build_chiefcottagelvl4
          :id                => 19, 
          :symbolic_id       => :quest_build_chiefcottagelvl4,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 4",
  
            :de_DE => " Und wieder die Häuptlingshütte ",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 4 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Ich denke, es ist mal wieder Zeit für eine größere Häuptlingshütte. Baue sie doch bitte aus, dann haben wir mehr Platz.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Du kannst die Häuptlingshütte beschleunigen, indem Du Kröten einsetzt. Drücke dazu auf 'hurtig!'. Probiere es doch einmal aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ist es nicht toll, wie Deine Siedlung wächst? Ich habe sogar Chef dazu überreden können, Dir etwas von seinem Rohstoffberg abzugeben.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Erhöhe Deine Rohstoffproduktion durch den Bau neuer Jäger und Sammler.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_message',

          },

          :successor_quests => [22, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 235,
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
        {               #   quest_build_1campfirelvl1
          :id                => 20, 
          :symbolic_id       => :quest_build_1campfirelvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Lagerfeuer",
  
            :de_DE => "Lagerfeuer",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => " Baue ein Lagerfeuer.",
                
          },
          :flavour => {
            
            :de_DE => "Hey wie wär's mit einem Lagerfeuer für Deine Siedlung? An Lagerfeuern treffen sich die Diplomaten, tauschen Nachrichten aus und schmieden Allianzen. Wäre doch schön, so etwas zu haben, oder?",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Lagerfeuer werden benötigt um Nachrichten zu schreiben und Allianzen zu gründen oder ihnen beizutreten. Außerdem wird hier der Kleine Häuptling rekrutiert.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ach, wie das Feuer knistert. So schön warm.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Ab jetzt kannst Du Nachrichten verschicken. Nutze dies, um mit Deinen Nachbarn zu kommunizieren.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1storagelvl1',

          },

          :successor_quests => [21, 28, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 80,
              },

              {
                :resource => :resource_wood,
                :amount => 75,
              },

              {
                :resource => :resource_fur,
                :amount => 50,
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

                :min_level => 1,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1campfirelvl1
        {               #   quest_alliance
          :id                => 21, 
          :symbolic_id       => :quest_alliance,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Allianzen",
  
            :de_DE => "",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Tritt einer Allianz bei oder gründe Deine eigene.",
                
          },
          :flavour => {
            
            :de_DE => "Feindliche Armeen mit Deinen eigenen Armeen zu bekämpfen ist ja nett. Aber viel besser wäre es doch, wenn ihr zusammenarbeiten würdet oder wenn Deine Freunde Dir helfen würden. Du solltest in einer Allianz sein, da hilft man sich gegenseitig.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Ab jetzt kannst Du einer Allianz beitreten. Eine Allianz hat viele Vorteile, man tauscht Rohstoffe, hilft sich gegenseitig bei der Verteidigung und koordiniert Angriffe. Nur eine Allianz kann ein großes Territorium halten. Wenn Du Dich bereit fühlst, tritt doch einer bei.</p><p>Eine eigene Allianz kannst Du erst mit Lagerfeuer Level 5 gründen.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hui, das ist aber eine tolle Allianz. Ich bin sicher, dass ihr sehr weit kommen werdet.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Du kannst das Profil der Allianz einsehen, indem Du auf den Allianzwimpel oben rechts neben der Rohstoffübersicht klickst.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1campfirelvl1',

          },

          :successor_quests => [],

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

            :experience_reward => 300,

          },          

          :reward_tests => {
            
            :alliance_test => {},

          },          

        },              #   END OF quest_alliance
        {               #   quest_build_1storagelvl1
          :id                => 22, 
          :symbolic_id       => :quest_build_1storagelvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Rohstofflager",
  
            :de_DE => " Rohstofflager ",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue ein Rohstofflager.",
                
          },
          :flavour => {
            
            :de_DE => "Stört es Dich nicht auch, dass der Lagerplatz so gering ist? Baue doch bitte ein Rohstofflager, damit wir mehr Platz haben.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Rohstofflager erhöhen die maximale Menge an Rohstoffen, die Du lagern kannst. Wenn Du die Grenze erreichst, verfällt die überschüssige Produktion. Außerdem erlauben die Karren den Handel mit anderen Spielern.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll, sieht das aus. Endlich hab ich genug Platz für meine ganzen Schu - äh Sachen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jeder Handelskarren kann zehn Ressourcen befördern.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl4',

          },

          :successor_quests => [20, ],

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
                :amount => 200,
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

        },              #   END OF quest_build_1storagelvl1
        {               #   quest_build_chiefcottagelvl5
          :id                => 23, 
          :symbolic_id       => :quest_build_chiefcottagelvl5,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 5",
  
            :de_DE => "Häuptlingshütte die Vierte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 5 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Du bist wieder so weit Deine Häuptlingshütte auszubauen. Ein wenig Prunk kann nicht schaden, oder?",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll wie weit Du schon gekommen bist. Weiter so!",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_2gathererlvl4',

          },

          :successor_quests => [24, 38, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 220,
              },

              {
                :resource => :resource_wood,
                :amount => 220,
              },

              {
                :resource => :resource_fur,
                :amount => 100,
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

        },              #   END OF quest_build_chiefcottagelvl5
        {               #   quest_build_1quarrylvl1_1loggerlvl1
          :id                => 24, 
          :symbolic_id       => :quest_build_1quarrylvl1_1loggerlvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Holzfäller und Steinbruch",
  
            :de_DE => "Steinbrüche und Holzfäller",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue einen Steinbruch und einen Holzfäller.",
                
          },
          :flavour => {
            
            :de_DE => "Hast Du gesehen, dass Du jetzt spezielle Rohstoffgebäude bauen kannst? Ja genau, Steinbrüche und Holzfäller. Die bringen zwar nur einen bestimmten Rohstoff, aber dafür davon viel mehr als der Sammler. Wäre toll wenn Du einen Steinbruch und einen Holzfäller bauen würdest.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "So viel Stein und Holz, wie toll.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "Steinbruch und Holzfäller erhöhen Deine Stein und Holzproduktion stärker als Jäger und Sammler. ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl5',

          },

          :successor_quests => [36, 41, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 75,
              },

              {
                :resource => :resource_wood,
                :amount => 65,
              },

              {
                :resource => :resource_fur,
                :amount => 15,
              },

            ],

            :experience_reward => 100,

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
        {               #   quest_build_4quarrylvl5_4loggerlvl5
          :id                => 25, 
          :symbolic_id       => :quest_build_4quarrylvl5_4loggerlvl5,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Noch mehr Holzfäller und Steinbrüche",
  
            :de_DE => "Noch mehr Holzfäller und Steinbrüche",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Je drei Steinbrüche und  Holzfäller auf Level 4 ausbauen",
                
          },
          :flavour => {
            
            :de_DE => "Wenn Du Deine Rohstoffproduktion steigern willst, musst Du mehr Steinbrüche und Holzfäller bauen und diese dann weiter ausbauen.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue je drei Steinbrüche und Holzfäller auf Level 4 aus, um Deine Produktion weiter zu erhöhen.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Wow, guck mal wie viel Rohstoffe Du produzierst. Ist ja cool.",
  
            :en_US => "Achte auf Deine Lagerkapazität, sonst laufen die Lager in Deiner Abwesenheit über.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_2quarrylvl3_2loggerlvl3',

          },

          :successor_quests => [],

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
                :amount => 40,
              },

            ],

            :experience_reward => 125,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_quarry',

                :min_level => 4,

                :min_count => 3,

              },

              {
                :building => 'building_logger',

                :min_level => 4,

                :min_count => 3,

              },

            ],

          },          

        },              #   END OF quest_build_4quarrylvl5_4loggerlvl5
        {               #   quest_build_1campfirelvl10
          :id                => 26, 
          :symbolic_id       => :quest_build_1campfirelvl10,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Lagerfeuer Level 10",
  
            :de_DE => "Lagerfeuer Level 10",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue dein Lagerfeuer auf Level 10 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Ich würde gern eine Lagerstätte gründen, aber dafür brauchen wir zuerst einen Kleinen Häuptling. Der Kleine Häuptling kann nur an einem ausgebauten Lagerfeuer trainiert werden. Baust Du es bitte für mich aus?",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut. Jetzt kannst Du einen Kleinen Häuptling trainieren. Schau dafür am Lagerfeuer vorbei.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Kleine Häuptlinge sind teuer und haben eine lange Rekrutierungszeit. Außerdem sind sie trotz ihrer wichtigen Stellung Teil der Nahkampfeinheiten. Versuche sie deswegen nicht in Kämpfe zu verwickeln.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl6',

          },

          :successor_quests => [27, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 240,
              },

              {
                :resource => :resource_wood,
                :amount => 180,
              },

              {
                :resource => :resource_fur,
                :amount => 450,
              },

            ],

            :experience_reward => 350,

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

        },              #   END OF quest_build_1campfirelvl10
        {               #   quest_outpost
          :id                => 27, 
          :symbolic_id       => :quest_outpost,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Lagerstätte gründen",
  
            :de_DE => "Lagerstätte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Gründe eine Lagerstätte.",
                
          },
          :flavour => {
            
            :de_DE => "Wie? Nur eine Siedlung? Du musst Dich mehr ausbreiten. Gründe eine Lagerstätte, aber flott! Dann findet sich bei mir vielleicht auch etwas, das ich Dir überlassen kann.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Um eine Lagerstätte zu gründen, musst Du einen Kleinen Häuptling am Lagerfeuer ausbilden und diesen mit einer Armee zu einem freien Feld bewegen. Du kannst allerdings nur eine Lagerstätte pro Region haben.</p><p>Du kannst nur weitere Siedlungen gründen, wenn Du Erfahrungen sammelst und im Rang aufsteigst.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Du hast eine Lagerstätte gegründet? Brauchst Du immer so lange für einfache Aufgaben? Hier, nimm die Rohstoffe und geh mir aus den Augen. Dein Anblick macht mich krank. ",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => ".",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1campfirelvl10',

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
                :amount => 250,
              },

            ],

            :experience_reward => 500,

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
        {               #   quest_build_2gathererlvl3
          :id                => 28, 
          :symbolic_id       => :quest_build_2gathererlvl3,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Weitere Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Baue insgesamt vier Jäger und Sammler auf Level 2 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => "Du findest Dich schon gut zurecht. Deine Jäger und Sammler solltest Du weiter ausbilden.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Du hast das Tutorial durchlaufen, ab jetzt kommen Aufgaben, die Deinen Ausbau etwas anleiten. Du kannst aber auch Deinen eigene n Weg gehen.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Wunderbar! Ich halte es für eine gute Idee, alle Deine Sammler auszubauen, dann werden die Rohstoffe nicht so schnell knapp.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Behalte Deine Rohstoffproduktion im Auge. Die Jäger und Sammler auszubauen lohnt sich auf jeden Fall.",
  
            :en_US => "Das Tutorial ist zu Ende! Du solltest jetzt Deinen eigenen Ausbauweg einschlagen.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1campfirelvl1',

          },

          :successor_quests => [29, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 70,
              },

              {
                :resource => :resource_wood,
                :amount => 60,
              },

              {
                :resource => :resource_fur,
                :amount => 30,
              },

            ],

            :experience_reward => 150,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 2,

                :min_count => 4,

              },

            ],

          },          

        },              #   END OF quest_build_2gathererlvl3
        {               #   quest_build_1cottagelvl3
          :id                => 29, 
          :symbolic_id       => :quest_build_1cottagelvl3,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Mehr Hütten",
  
            :de_DE => "Kleine Hütten, ganz groß!",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue eine kleine Hütte auf Level 3.",
                
          },
          :flavour => {
            
            :de_DE => "Die Kleinen Hütten sind ganz toll. Nur leider jetzt schon zu klein! Baue die Hütte weiter aus, es warten schon weitere zukünftige Bewohner vor den Toren Deiner Siedlung.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Die ersten Bewohner sind in die Hütten gezogen, doch schon wird der Platz knapp. Erweitere die Kleinen Hütten auf Level 3.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Klasse! Schon kommen neue Bewohner, die Dich beim Ausbau unterstützen werden.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Dir die Bauaufträge immer noch zu lange dauern, kannst Du mehr kleine Hütten bauen und diese weiter ausbauen.",
  
            :en_US => "Hütten beschleunigen Deinen Ausbau. Wenn Dir die Bauzeiten zu lang sind, erweitere Deine Hütten!",
                
          },

          :requirement => {
            
            :quest => 'quest_build_2gathererlvl3',

          },

          :successor_quests => [30, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 95,
              },

              {
                :resource => :resource_wood,
                :amount => 75,
              },

              {
                :resource => :resource_fur,
                :amount => 45,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_cottage',

                :min_level => 3,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1cottagelvl3
        {               #   quest_build_2gathererlvl4
          :id                => 30, 
          :symbolic_id       => :quest_build_2gathererlvl4,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Noch mehr Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Baue zwei Jäger und Sammler auf Level 3 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => "Ich bin ganz begeistert wie sich Deine Jäger und Sammler bemühen Dir Rohstoffe zu bringen. Gewähre ihnen doch bitte weitere Ausbildung.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>In Deinen Kleinen Hütten machen es sich die ersten Bewohner gemütlich. Sehr schön. Sorge doch bitte dafür, dass Deine Bewohner auch immer genügend Rohstoffe haben. Verbessere dafür mindestens zwei Deiner Jäger und Sammler auf Level 3.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Danke Halbgott, sehr vorausschauend Deine Rohstoffproduktion weiter zu erhöhen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jäger und Sammler bauen ist immer eine gute Idee.",
  
            :en_US => "Jäger und Sammler sind lange Zeit die einzige Quelle für Fell. Bedenke dies bei Deinem Ausbau.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1cottagelvl3',

          },

          :successor_quests => [23, ],

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
                :amount => 15,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 3,

                :min_count => 2,

              },

            ],

          },          

        },              #   END OF quest_build_2gathererlvl4
        {               #   quest_build_4gathererlvl5
          :id                => 31, 
          :symbolic_id       => :quest_build_4gathererlvl5,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Immer mehr Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Baue vier Jäger und Sammler auf Level 5 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => "Hey, toll was die Jäger und Sammler alles finden. Aus den Fellen lasse ich mir ein neues Höschen schneidern. Bist Du so nett und kümmerst Dich um ihre weitere Ausbildung.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Behalte Deine Jäger und Sammler im Auge, sie sollten stetig weiter ausgebildet werden.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Juhu, nicht nur Fell für ein Höschen, sondern ein Top ist auch noch drin! Klasse!",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jäger und Sammler solltest Du immer nebenbei mit aufwerten.",
  
            :en_US => " ",
                
          },

          :successor_quests => [32, ],

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
                :amount => 55,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 5,

                :min_count => 4,

              },

            ],

          },          

        },              #   END OF quest_build_4gathererlvl5
        {               #   quest_build_3gathererlvl7
          :id                => 32, 
          :symbolic_id       => :quest_build_3gathererlvl7,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Jäger und Sammler weiter ausbauen",
                
          },
          :task => {
            
            :en_US => "Baue drei Jäger und Sammler auf Level 7 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => "Hmm, mein Kleiderschrank ist leer und in meine Hütte zieht es rein. Vielleicht brauchen wir mehr Rohstoffe?",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Die Jäger und Sammler mögen nicht die besten Produzenten von Rohstoffen sein, aber sie bringen von allem etwas. Das lohnt sich.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Vielen Dank, mit den Jägern und Sammler sollten wir bald ausreichend Rohstoffe haben.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Verbessere die Jäger und Sammler noch weiter.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_4gathererlvl5',

          },

          :successor_quests => [],

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

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 7,

                :min_count => 3,

              },

            ],

          },          

        },              #   END OF quest_build_3gathererlvl7
        {               #   quest_build_1barrackslvl2
          :id                => 33, 
          :symbolic_id       => :quest_build_1barrackslvl2,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "More Barracks",
  
            :de_DE => "Ausbildungsgelände Level 2",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue ein Ausbildungsgelände auf Level 2.",
                
          },
          :flavour => {
            
            :de_DE => "Was soll das hier werden? Gänseblümchenzucht? Pilze sammeln im Mondschein? Du sollst eine furchterregende Armee aufstellen! Mach schon!",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Je weiter das Ausbildungsgelände ausgebaut ist, desto schneller kannst Du Nahkämpfer ausbauen.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "War das jetzt so schwer? Hier ein paar Kleinigkeiten, damit Du nicht wieder Deine militärische Schlagkraft vernachlässigst! ",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Das Ausbildungsgelände verkürzt auch die Rekrutierungszeit der Nahkampfeinheiten.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1cottagelvl2',

          },

          :successor_quests => [10, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 160,
              },

              {
                :resource => :resource_wood,
                :amount => 95,
              },

              {
                :resource => :resource_fur,
                :amount => 90,
              },

            ],

            :experience_reward => 150,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_barracks',

                :min_level => 2,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1barrackslvl2
        {               #   quest_build_1barrackslvl5
          :id                => 34, 
          :symbolic_id       => :quest_build_1barrackslvl5,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Even more Barracks",
  
            :de_DE => "Ausbildungsgelände Level 5",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue ein Ausbildungsgelände auf Level 5.",
                
          },
          :flavour => {
            
            :de_DE => "Der Chef hat gerade das Ausbildungsgelände inspiziert. Er ist unzufrieden mit meiner Ausbildung der Krieger! Kannst Du Dir das vorstellen? Mit MEINER Ausbildung? Wie soll ich eine schlagkräftige Truppe aufbauen, wenn wir kaum Platz zum Keulenschwingen haben? Bau für mich das Ausbildungsgelände aus.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Mit jedem Level des Ausbildungsgebäudes sinkt die Zeitdauer der Rekrutierung einer Nahkampfeinheit.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Sehr schön, das erzähle ich gleich dem Chef! Hier hast Du ein paar Rohstoffe für meine Jungs mit der Keule.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Der Dickhäutige Keulenkrieger! Mehr Kraft für Deine Nahkämpfer.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl7',

          },

          :successor_quests => [35, ],

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

            :experience_reward => 150,

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
        {               #   quest_build_1barrackslvl10
          :id                => 35, 
          :symbolic_id       => :quest_build_1barrackslvl10,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Barracks",
  
            :de_DE => "Ausbildungsgelände Level 10",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue ein Ausbildungsgelände auf Level 10.",
                
          },
          :flavour => {
            
            :de_DE => "Nur mit Keulenkriegern können wir uns nicht behaupten! Wir brauchen auch die Dickhäutigen Keulenkrieger. Es mag lange dauern, aber sorge für den Ausbau des Ausbildungsgeländes.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Auf Level 10 können im Ausbildungsgelände neue Einheiten ausgebildet werden.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Danke Halbgott. Zwar nicht die schlausten, aber einstecken und draufhauen können die Dickhäuter wirklich.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Der Dickhäutige Keulenkrieger! Mehr Kraft für Deine Nahkämpfer.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1barrackslvl5',

          },

          :successor_quests => [],

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
                :amount => 150,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_clubbers_2,
                :amount => 10,
              },

            ],

            :experience_reward => 300,

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
        {               #   quest_build_2quarrylvl3_2loggerlvl3
          :id                => 36, 
          :symbolic_id       => :quest_build_2quarrylvl3_2loggerlvl3,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Mehr Holzfäller und Steinbrüche",
  
            :de_DE => "",
                
          },
          :task => {
            
            :en_US => "Bau je 2 Steinbrüche und Holzfäller auf Level 3 aus, damit Deine Produktion steigt.",
  
            :de_DE => "Zwei Steinbrüche und Holzfäller auf Level 3 ausbauen",
                
          },
          :flavour => {
            
            :de_DE => "Deine Rohstoffproduktion zu unterstützen, baue je zwei Steinbrüche und Holzfäller auf Level 3 aus.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Die Steinbrüche und Holzfäller ergänzen sich in den Kosten. Baue sie abwechselnd.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Wow, guck mal wie viel Rohstoffe Du produzierst. Ist ja cool.",
  
            :en_US => "",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1quarrylvl1_1loggerlvl1',

          },

          :successor_quests => [25, 37, ],

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

              {
                :resource => :resource_fur,
                :amount => 40,
              },

            ],

            :experience_reward => 125,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_quarry',

                :min_level => 3,

                :min_count => 2,

              },

              {
                :building => 'building_logger',

                :min_level => 3,

                :min_count => 2,

              },

            ],

          },          

        },              #   END OF quest_build_2quarrylvl3_2loggerlvl3
        {               #   quest_build_1storagelvl5
          :id                => 37, 
          :symbolic_id       => :quest_build_1storagelvl5,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Rohstofflager Level 3",
  
            :de_DE => " Rohstofflager Level 3 ",
                
          },
          :task => {
            
            :en_US => "Baue Dein Rohstofflager auf Level 3 aus, damit das Lager mit der Produktion mithalten kann.",
  
            :de_DE => "Baue ein Rohstofflager Level 3.",
                
          },
          :flavour => {
            
            :de_DE => "Denkst Du eigentlich mit, oder muss ich hier wirklich alles selber machen? Du musst auch ausreichend Lager für die Rohstoffe bauen!",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Rohstofflager erhöhen die maximale Menge an Rohstoffen, die Du lagern kannst. Wenn Du die Grenze erreichst, verfällt die überschüssige Produktion. Außerdem erlauben die Karren den Handel mit anderen Spielern.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Was willst Du? Soll ich Dich loben, oder gar drücken? Zieh ab und baue mir endlich eine Armee!",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Mit jedem Rohstofflager kannst Du auch mehr Rohstoffe transportieren.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_2quarrylvl3_2loggerlvl3',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 45,
              },

              {
                :resource => :resource_wood,
                :amount => 45,
              },

              {
                :resource => :resource_fur,
                :amount => 35,
              },

            ],

            :experience_reward => 75,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_storage',

                :min_level => 3,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1storagelvl5
        {               #   quest_build_1campfirelvl5
          :id                => 38, 
          :symbolic_id       => :quest_build_1campfirelvl5,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Lagerfeuer auf Level 5",
  
            :de_DE => "Lagerfeuer Level 5",
                
          },
          :task => {
            
            :en_US => "Baue Dein Lagerfeuer auf 5 aus, um die Möglichkeit zu haben eine eigene Allianz zu gründen.",
  
            :de_DE => "Baue dein Lagerfeuer auf Level 5, damit Du die Möglichkeit hast, eine eine eigene Allianz zu gründen.",
                
          },
          :flavour => {
            
            :de_DE => "Halbgott? Gib mir mehr Macht! Vergrößere das Lagerfeuer, damit ich meine eigene Allianz gründen kann! Los!",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Was? Wieso weckst Du mich? Ah, endlich fertig mit dem Lagerfeuer? Wurde ja auch Zeit!",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Manchmal muss ein Häuptling auch eigene Ziele verfolgen. Eine eigene Allianz zu Ruhm und Ehren zu führen ist so etwas.",
  
            :en_US => "Mit dem Lagerfeuer kannst Du jetzt eine eigene Allianz gründen.",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl5',

          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 275,
              },

              {
                :resource => :resource_wood,
                :amount => 250,
              },

              {
                :resource => :resource_fur,
                :amount => 70,
              },

            ],

            :experience_reward => 250,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_campfire',

                :min_level => 5,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1campfirelvl5
        {               #   quest_build_6gathererlvl2
          :id                => 39, 
          :symbolic_id       => :quest_build_6gathererlvl2,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Immer mehr Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Baue insgesamt sechs Jäger und Sammler auf Level 2 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => "Hey, toll was die Jäger und Sammler alles finden. Aus den Fellen lasse ich mir ein neues Höschen schneidern. Bist Du so nett und kümmerst Dich um ihre weitere Ausbildung.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Behalte Deine Jäger und Sammler im Auge, sie sollten stetig weiter ausgebildet werden.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Juhu, nicht nur Fell für ein Höschen, sondern ein Top ist auch noch drin! Klasse!",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jäger und Sammler solltest Du immer nebenbei mit aufwerten.",
  
            :en_US => " ",
                
          },

          :successor_quests => [],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 65,
              },

              {
                :resource => :resource_wood,
                :amount => 75,
              },

              {
                :resource => :resource_fur,
                :amount => 35,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 2,

                :min_count => 6,

              },

            ],

          },          

        },              #   END OF quest_build_6gathererlvl2
        {               #   quest_build_1gathererlvl4
          :id                => 40, 
          :symbolic_id       => :quest_build_1gathererlvl4,
          :advisor           => :girl,
          :hide_start_dialog => true,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Immer größere Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Baue einen Jäger und Sammler auf Level 4 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => "Dein Jäger und Sammler hat gar nicht genug Holz auf seinem Gelände. Bau es doch bitte aus, vorzugsweise in Richtung des Waldes.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Sorge doch bitte dafür, dass Deine Bewohner auch immer genügend Rohstoffe haben. Verbessere einen Deiner Jäger und Sammler auf Level 4.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Guck mal, dein Jäger und Sammler hat schon richtig Holz vor der Hütte.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jäger und Sammler bauen ist immer eine gute Idee.",
  
            :en_US => " ",
                
          },

          :successor_quests => [],

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
                :amount => 35,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 4,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1gathererlvl4
        {               #   quest_build_1gathererlvl5
          :id                => 41, 
          :symbolic_id       => :quest_build_1gathererlvl5,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Immer diese Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Baue einen Jäger und Sammler auf Level 5 aus.",
  
            :de_DE => "Baue einen Jäger und Sammler auf Level 5 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Diese Jäger und Sammler sind unersättlich. Ständig treiben sie sich vor meiner Häuptlingshütte rum. Sorg dafür, dass sie mich in Ruhe lassen.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Der Ausbau der Jäger und Sammler erhöht ihre Produktion. Verbessere einen Deiner Jäger und Sammler auf Level 5.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Was? Du hast ihr Gelände ausgebaut? Das wird sie doch höchstens einen Tag beschäftigt halten. Was bringen sie euch Halbgöttern denn heutzutage bei?!",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jäger und Sammler liefern alle drei Rohstoffe. Auch Fell!",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1quarrylvl1_1loggerlvl1',

          },

          :successor_quests => [42, 50, ],

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
                :amount => 50,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 5,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1gathererlvl5
        {               #   quest_build_1gathererlvl6
          :id                => 42, 
          :symbolic_id       => :quest_build_1gathererlvl6,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Und wieder Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Baue einen Jäger und Sammler auf Level 6 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Dein Jäger und Sammler langweilt sich schon wieder. Bau ihm doch bitte ein größeres Gelände.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Wenn Du nicht weiter weißt, baue Deine Gebäude aus.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Danke ich habe den Jäger und Sammler schon über sein neues Gelände wirbeln sehen. Ich glaube, er wird eine Weile beschäftigt sein.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jäger und Sammler bauen ist immer eine gute Idee.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl5',

          },

          :successor_quests => [],

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

              {
                :resource => :resource_fur,
                :amount => 75,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 6,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1gathererlvl6
        {               #   quest_build_1gathererlvl7
          :id                => 43, 
          :symbolic_id       => :quest_build_1gathererlvl7,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Das Jäger und Sammler Problem",
                
          },
          :task => {
            
            :en_US => "Baue einen Jäger und Sammler auf Level 7 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => "Die Jäger und Sammler rennen schon auf den Ausbildungsgeländen herum. Das verschlechtert die Ausbildung der Truppen und außerdem fehlen ständig Waffen. Jemand sollte sich um dieses Problem kümmern.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Verbessere einen Deiner Jäger und Sammler auf Level 7.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ich habe gehört, dass die Jäger und Sammler nicht mehr die Ausbildung stören. Hoffentlich bleibt das auch so.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Es ist ab einem bestimmten Zeitpunkt ratsam die Jäger und Sammler durch die Spezialisten Steinbruch. Holzfäller und Kürschner zu ersetzen. Du entscheidest selbst, wann es soweit ist.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl6',

          },

          :successor_quests => [34, 44, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 160,
              },

              {
                :resource => :resource_wood,
                :amount => 160,
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
                :building => 'building_gatherer',

                :min_level => 7,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1gathererlvl7
        {               #   quest_build_1gathererlvl8
          :id                => 44, 
          :symbolic_id       => :quest_build_1gathererlvl8,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Immer noch Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Baue einen Jäger und Sammler auf Level 8 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => "Ich weiß zwar nicht wie er es macht, aber dem Jäger und Sammler ist sein Gelände schon wieder zu klein. Sei doch so lieb und vergrößere es für ihn.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Jäger und Sammler sind die billigsten Gebäude. Deshalb können sie am schnellsten ausgebaut werden.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hast Du schon gesehen, wie sich der Jäger und Sammler freut? Er hat heute sogar eine Stunde lang versucht eine Kröte zu fangen. Geschafft hat er es aber nicht.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jäger und Sammler finden ab Level 11 auch ab und an eine Kröte .",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl7',

          },

          :successor_quests => [45, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 220,
              },

              {
                :resource => :resource_wood,
                :amount => 220,
              },

              {
                :resource => :resource_fur,
                :amount => 150,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 8,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1gathererlvl8
        {               #   quest_build_1gathererlvl9
          :id                => 45, 
          :symbolic_id       => :quest_build_1gathererlvl9,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Fast ausgebaute Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Baue einen Jäger und Sammler auf Level 9 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => "Diese Jäger und Sammler sind seltsam. Er sitzt da und bläst Trübsal. Vielleicht geht es ihm ja besser, wenn Du sein Gelände erweiterst.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Nur noch zwei Level. Verbessere einen Deiner Jäger und Sammler auf Level 9.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Danke, ich glaube, jetzt geht es dem Jäger und Sammler besser.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jäger und Sammler bauen ist immer eine gute Idee.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl8',

          },

          :successor_quests => [46, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 350,
              },

              {
                :resource => :resource_wood,
                :amount => 350,
              },

              {
                :resource => :resource_fur,
                :amount => 200,
              },

            ],

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_gatherer',

                :min_level => 9,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1gathererlvl9
        {               #   quest_build_1gathererlvl10
          :id                => 46, 
          :symbolic_id       => :quest_build_1gathererlvl10,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Ein letztes mal der Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "Baue einen Jäger und Sammler auf Level 10 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => "Tu dem Jäger und Sammler doch einen Gefallen und erweiter sein Gelände. Dann ist es auch so groß, dass ihm nie wieder langweilig wird.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Gebäude auf kleinen Bauplätzen können bis auf Level 10 ausgebaut werden. Verbessere einen Deiner Jäger und Sammler auf Level 10.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ach wie schön. Der Jäger und Sammler hat jetzt immer etwas zu tun..",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jäger und Sammler bauen ist immer eine gute Idee.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl9',

          },

          :successor_quests => [],

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
                :resource => :resource_fur,
                :amount => 400,
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

        },              #   END OF quest_build_1gathererlvl10
        {               #   quest_queue_chiefcottagelvl2
          :id                => 47, 
          :symbolic_id       => :quest_queue_chiefcottagelvl2,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 2",
  
            :de_DE => "Die Häuptlingshütte in der Bauschleife",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Gib den Ausbau der Häuptlingshütte in Auftrag.",
                
          },
          :flavour => {
            
            :de_DE => "Halbgott? Und was soll das da sein? Meine Häuptlingshütte? Da kann ja niemand drin leben! Ändere das sofort! Bau sie aus und ich gebe Dir eine Belohnung.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Die Häuptlingshütte ist das große Gebäude in der Mitte der Siedlung.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Fertig? Wie Du hast Deinen Arbeitern den Auftrag gegeben? Das hilft mir mal gar nicht. Geh mir aus den Augen, bis die Arbeiten fertig sind.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Der Ausbau der Häuptlingshütte schaltet neue Gebäudearten frei und erlaubt Dir mehr Gebäude zu bauen.",
  
            :en_US => " ",
                
          },

          :successor_quests => [],

          :reward_tests => {
            
            :construction_queue_tests => [

              {
                :building => 'building_chief_cottage',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_queue_chiefcottagelvl2
        {               #   quest_queue_chiefcottagelvl3
          :id                => 48, 
          :symbolic_id       => :quest_queue_chiefcottagelvl3,
          :advisor           => :girl,
          :hide_start_dialog => true,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Chief Cottage l3",
  
            :de_DE => "Der Anfang einer noch größeren Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Gib das nächste Level der Häuptlingshütte in Auftrag.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Siedlung kommt ganz schön voran. Aber Du muss jetzt die Häuptlingshütte ausbauen um weiterzukommen.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Die Häuptlingshütte liefert Dir für jedes Level vier weitere Bauplätze.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Während Du darauf wartest, dass der Auftrag fertig gestellt wird, kannst Du ja etwas anderes machen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Auf großen Bauplätzen können Gebäude bis auf Level 20 ausgebaut werden. Gebäude des Levels 11 bis 20 geben spezielle Boni.",
  
            :en_US => " ",
                
          },

          :successor_quests => [],

          :reward_tests => {
            
            :construction_queue_tests => [

              {
                :building => 'building_chief_cottage',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_queue_chiefcottagelvl3
        {               #   quest_queue_chiefcottagelvl4
          :id                => 49, 
          :symbolic_id       => :quest_queue_chiefcottagelvl4,
          :advisor           => :girl,
          :hide_start_dialog => true,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 4",
  
            :de_DE => " Und wieder der Häuptlingshüttenausbau ",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Gib den Ausbau der Häuptlingshütte in Auftrag.",
                
          },
          :flavour => {
            
            :de_DE => "Ich denke, es ist mal wieder Zeit für eine größere Häuptlingshütte. Gib doch bitte den Ausbau in Auftrag.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Der Ausbau ist in Arbeit, jetzt können wir erstmal nur warten.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => " ",
                
          },

          :successor_quests => [],

          :reward_tests => {
            
            :construction_queue_tests => [

              {
                :building => 'building_chief_cottage',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_queue_chiefcottagelvl4
        {               #   quest_build_chiefcottagelvl6
          :id                => 50, 
          :symbolic_id       => :quest_build_chiefcottagelvl6,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 6",
  
            :de_DE => "Häuptlingshütte Level 6",
                
          },
          :task => {
            
            :en_US => "Baue Deine Häuptlingshütte auf Level 6 aus.",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 6 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, bau doch Deine Häuptlingshütte weiter aus.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Oh wow, Du hast die Häutptlingshütte weiter ausgebaut. Toll wie weit Du schon gekommen bist. Weiter so!",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Auf Level 8 der Häuptlingshütte werden die wichtigen Kürschner freigeschaltet.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl5',

          },

          :successor_quests => [26, 43, ],

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
                :resource => :resource_fur,
                :amount => 300,
              },

            ],

            :experience_reward => 300,

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
        {               #   quest_queue_chiefcottagelvl5
          :id                => 51, 
          :symbolic_id       => :quest_queue_chiefcottagelvl5,
          :advisor           => :girl,
          :hide_start_dialog => true,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 5",
  
            :de_DE => " Und wieder der Häuptlingshüttenausbau ",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Gib den Ausbau der Häuptlingshütte in Auftrag.",
                
          },
          :flavour => {
            
            :de_DE => "Hey, Du bist wieder so weit Deine Häuptlingshütte auszubauen. Ein wenig Prunk kann nicht schaden, oder?",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Der Ausbau ist in Arbeit, jetzt können wir erstmal nur warten.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => " ",
                
          },

          :successor_quests => [],

          :reward_tests => {
            
            :construction_queue_tests => [

              {
                :building => 'building_chief_cottage',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_queue_chiefcottagelvl5
        {               #   quest_build_2cottagelvl1
          :id                => 52, 
          :symbolic_id       => :quest_build_2cottagelvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Hütten",
  
            :de_DE => "Die kleinen Hütten",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue zwei kleine Hütten.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Arbeiter haben ja noch keine Unterkunft. Bitte baue ihnen doch eine kleine Hütte oder zwei. Wusstest Du, dass Du Deinen Arbeitern zwei Aufträge erteilen kannst? Sie können zwar nur an einem arbeiten, aber sie merken sich den anderen. Wie wäre es, wenn Du das mal versuchst? Denn je besser es Deinen Arbeitern geht, desto schneller bauen sie auch.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Du kannst zwei Gebäude gleichzeitig in Auftrag geben. Diese werden dann nacheinander gebaut. Kleine Hütten verkürzen die Bauzeit von Gebäuden.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Gut gemacht. Deine Arbeiter freuen sich und bauen schneller.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Dir die Bauaufträge zu lange dauern, kannst Du mehr kleine Hütten bauen und weiter ausbauen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl2_V2',

          },

          :successor_quests => [7, 14, ],

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
                :amount => 50,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_cottage',

                :min_level => 1,

                :min_count => 2,

              },

            ],

          },          

        },              #   END OF quest_build_2cottagelvl1
        {               #   quest_quest_button
          :id                => 53, 
          :symbolic_id       => :quest_quest_button,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Finde und drücke den Questknopf",
  
            :de_DE => "Questknopf",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Finde und drücke den Questknopf. Schließe dann den Dialog und komm hierher zurück.",
                
          },
          :flavour => {
            
            :de_DE => "Du kannst Dir übrigens jederzeit die laufenden Quests in der Quest-Übersicht anschauen.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Der Questknopf ist oben rechts am Hauptmenü. Dort findest Du sowohl die aktuellen als auch bereits gelöste Quests, deren Belohnung Du noch nicht eingelöst hast.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Questknopf gefunden! Klasse, jetzt hast Du alle Quests auf einem Blick. ",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Schaue regelmäßig in die Questübersicht, dann verlierst Du nie den Überblick.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl1',

          },

          :successor_quests => [4, ],

          :rewards => {
            
            :experience_reward => 50,

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_quest_button',
            },

          },          

        },              #   END OF quest_quest_button
        {               #   quest_build_chiefcottagelvl2_V2
          :id                => 54, 
          :symbolic_id       => :quest_build_chiefcottagelvl2_V2,
          :advisor           => :chef,
          :hide_start_dialog => true,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 2",
  
            :de_DE => "Ausbau der Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue Deine Häuptlingshütte auf Level 2 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Ah endlich fertig? Nein? Was machst Du dann hier? Komm erst wieder, wenn der Ausbau der Häuptlingshütte abgeschlossen ist.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Die Häuptlingshütte ist das große Gebäude in der Mitte der Siedlung.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Endlich fertig hm? Hat ja ewig gedauert. Wie Belohnung? Wofür? Reicht es Dir nicht, dass Deine Siedlung größer ist und Du ein neues Gebäude bauen kannst? Außerdem hab ich Dir doch gerade schon eine Belohnung gegeben! Verschwinde Du gieriger Halbgott.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Zusätzliche Level der Häuptlingshütte lassen Dich mehr Gebäude bauen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl2',

          },

          :successor_quests => [52, ],

          :rewards => {
            
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

        },              #   END OF quest_build_chiefcottagelvl2_V2
        {               #   quest_queue_chiefcottagelvl2_V2
          :id                => 55, 
          :symbolic_id       => :quest_queue_chiefcottagelvl2_V2,
          :advisor           => :chef,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 2",
  
            :de_DE => "Beauftrage die Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Beauftrage den Ausbau der Häuptlingshütte auf Level 2.",
                
          },
          :flavour => {
            
            :de_DE => "Halbgott? Und was soll das da sein? Meine Häuptlingshütte? Da kann ja niemand drin leben! Ändere das sofort! Bau sie aus und ich gebe Dir eine Belohnung.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Die Häuptlingshütte ist das große Gebäude in der Mitte der Siedlung.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Endlich fertig hm? Nein? Und Du willst trotzdem eine Belohnung? Manche haben auch nie genug. Hier, nimm das und komm wieder wenn der Ausbau fertig ist.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Der Ausbau der Häuptlingshütte schaltet neue Gebäudearten frei und erlaubt Dir mehr Gebäude zu bauen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl2',

          },

          :successor_quests => [6, ],

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

            :experience_reward => 400,

          },          

          :reward_tests => {
            
            :construction_queue_tests => [

              {
                :building => 'building_chief_cottage',
                :min_count => 1,
              },

            ],

          },          

        },              #   END OF quest_queue_chiefcottagelvl2_V2
        {               #   quest_build_1cottagelvl2
          :id                => 56, 
          :symbolic_id       => :quest_build_1cottagelvl2,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Mehr Hütten",
  
            :de_DE => "Kleine Hütten, ganz groß!",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue eine kleine Hütte auf Level 2.",
                
          },
          :flavour => {
            
            :de_DE => "Die Kleine Hütte ist ganz toll. Nur leider jetzt schon zu klein! Baue die Hütte weiter aus, es warten schon weitere zukünftige Bewohner vor den Toren Deiner Siedlung.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Die ersten Bewohner sind in die Hütten gezogen, doch schon wird der Platz knapp. Erweitere die Kleinen Hütten auf Level 2.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Klasse! Schon kommen neue Bewohner, die Dich beim Ausbau unterstützen werden.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Wenn Dir die Bauaufträge immer noch zu lange dauern, kannst Du mehr kleine Hütten bauen und diese weiter ausbauen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1barrackslvl1',

          },

          :successor_quests => [33, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 95,
              },

              {
                :resource => :resource_wood,
                :amount => 75,
              },

              {
                :resource => :resource_fur,
                :amount => 45,
              },

            ],

            :experience_reward => 100,

          },          

          :reward_tests => {
            
            :building_tests => [

              {
                :building => 'building_cottage',

                :min_level => 2,

                :min_count => 1,

              },

            ],

          },          

        },              #   END OF quest_build_1cottagelvl2
        {               #   quest_army_reinforce
          :id                => 57, 
          :symbolic_id       => :quest_army_reinforce,
          :advisor           => :warrior,
          :hide_start_dialog => false,
          :tutorial          => false,
          
          :name => {
            
            :en_US => "Armee",
  
            :de_DE => "Verstärke Deine Armee",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Verstärke Deine Armee auf mindestens 5 Mann.",
                
          },
          :flavour => {
            
            :de_DE => "Drei Einheiten soll eine Armee sein? So kleine Armeen werden doch einfach überrant! Verstärke die Armee.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Wähle Deine gerade erstellte Armee aus. Wähle dann unten rechts im Inspektor 'Verstärken'. Benutze die Pfeile, um alle Einheiten in die Armee zu verschieben. Wenn Du fertig bist, drücke auf 'Ändern'.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Naja, besser als vorher, aber da geht noch mehr. Hier hast Du ein bisschen mehr Verstärkung.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Kleine Armeen werden von großen Armeen ohne einen Kampf überrannt.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_army_create',

          },

          :successor_quests => [18, ],

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 180,
              },

              {
                :resource => :resource_wood,
                :amount => 140,
              },

              {
                :resource => :resource_fur,
                :amount => 15,
              },

            ],

            :unit_rewards => [

              {
                :unit => :unit_clubbers,
                :amount => 6,
              },

            ],

            :experience_reward => 250,

          },          

          :reward_tests => {
            
            :army_tests => [

              {
                :type => 'visible',
                :min_count => 5,
              },

            ],

          },          

        },              #   END OF quest_army_reinforce
        {               #   quest_improve_production_1
          :id                => 58, 
          :symbolic_id       => :quest_improve_production_1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          :tutorial          => true,
          
          :name => {
            
            :en_US => "Produktionssteigerung",
  
            :de_DE => "Erhöhe Deine Rohstoffproduktion",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Erhöhe Deine Produktion von Steinen und Holz auf je mindestens 20 Einheiten pro Stunde.",
                
          },
          :flavour => {
            
            :de_DE => "Rohstoffe sind die halbe Miete. Wir brauchen dringend eine Produktion!",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Baue zusätzliche Sammler und baue die vorhandenen aus, um das Ziel zu erreichen. Die Produktionsrate pro Stunde siehst Du oben bei den Rohstoffanzeigen.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Super, tolle Leistung! So sieht es doch jetzt schon sehr viel besser aus.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Denk dran, wann immer möglich Deine Rohstoffproduktion auszubauen. Du solltest jeden freien und nicht anderweitig benötigten Bauplatz dafür verwenden.",
  
            :en_US => " ",
                
          },

          :successor_quests => [],

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

            :experience_reward => 200,

          },          

          :reward_tests => {
            
            :resource_production_tests => [

              {
                :resource => 'resource_wood',
                :minimum  => 20,
              },

              {
                :resource => 'resource_stone',
                :minimum  => 20,
              },

            ],

          },          

        },              #   END OF quest_improve_production_1
      ],                # END OF QUESTS

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts Tutorial::Tutorial.the_tutorial.to_json
#Tutorial.tutorial.quests.each do |value| 
#  puts value[:name][:de_DE] 
#end

