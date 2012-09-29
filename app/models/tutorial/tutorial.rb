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
          :id                => 0, 
          :symbolic_id       => :quest_queue_1gathererlvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => " the first building",
  
            :de_DE => "Das erste Gebäude",
                
          },
          :task => {
            
            :en_US => "Build one Gatherer",
  
            :de_DE => " Gib einen Jäger und Sammler Stufe 1 in Auftrag. ",
                
          },
          :flavour => {
            
            :de_DE => " Willkommen Halbgott. Schau dir deine Siedlung an, ist sie nicht wundervoll? Nunja, vielleicht noch ein bisschen leer. Wenn du einen Jäger und Sammler bauen würdest, sähe das bestimmt viel besser aus und er gibt dir einen Teil der Rohstoffe ab, die er findet. ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Um einen Jäger und Sammler in Auftrag zu geben, klicke auf einen Bauplatz, und klicke dort auf Jäger und Sammler. Du kannst jederzeit alle laufenden Quests sehen, indem du oben rechts auf den Quests Knopf drückst.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => " Gut gemacht. Jetzt müssen wir kurz warten, während deine Arbeiter den Auftrag fertigstellen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Der Jäger und Sammler taucht rechts in der Gebäudeproduktion auf. Dort kannst du sehen, wie lange es dauert, bis das Gebäude fertiggestellt wird, Aufträge abbrechen oder beschleunigen. Bauaufträge laufen auch weiter, wenn du nicht im Spiel bist. ",
  
            :en_US => " ",
                
          },

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
          
          :name => {
            
            :en_US => " the first building",
  
            :de_DE => "Auf den Bauauftrag warten.",
                
          },
          :task => {
            
            :en_US => "Build one Gatherer",
  
            :de_DE => " Warte bis der Jäger und Sammler Stufe 1 fertiggestellt wurde.",
                
          },
          :flavour => {
            
            :de_DE => " Mehr als warten können wir grad nicht machen. ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Bauaufträge brauchen Zeit. Sie bauen allerdings auch weiter, wenn du nicht im Spiel bist.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => " Hey das sieht doch schon viel besser aus, findest du nicht?  Der nette Sammler will dir sogar ein paar Rohstoffe schenken.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Der Jäger und Sammler sammelt alle verschiedenen Rohstoffe in geringen Mengen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_queue_1gathererlvl1',

          },

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
          
          :name => {
            
            :en_US => " Ein zweiter Jäger und Sammler",
  
            :de_DE => "",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue einen weiteren Sammler.",
                
          },
          :flavour => {
            
            :de_DE => "Wie wäre es mit einem zweiten Jäger und Sammler? Kannst du den für mich bauen?",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Cool jetzt sind sie schon zu zweit.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Du solltest versuchen deine Rohstoffproduktion auszubauen. 10 Jäger und Sammler wären zum Beispiel ein guter Start. ",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_end_1gathererlvl1',

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
                :amount => 30,
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
        {               #   quest_build_2gathererlvl1
          :id                => 3, 
          :symbolic_id       => :quest_build_2gathererlvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => "",
  
            :de_DE => "Noch mehr Jäger und Sammler",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue zwei weitere Jäger und Sammler Stufe 1.",
                
          },
          :flavour => {
            
            :de_DE => "Hey wusstest du, dass du deinen Arbeitern zwei Aufträge erteilen kannst? Sie können zwar nur an einem arbeiten, aber sie merken sich den anderen. Wie wäre es, wenn du das mal versuchst?",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Du kannst zwei Gebäude gleichzeitig in Auftrag geben. Es wird allerdings nur das erste gebaut, das andere geht in die Bauschleife und wird angefangen, sobald das erste fertiggestellt wurde. </p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Schön, deine Siedlung sieht mit jeder Minute besser aus.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Du solltest darauf achten, dass du immer etwas baust oder ausbaust. Jäger und Sammler bauen ist nie verkehrt. ",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl1',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 45,
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
          
          :name => {
            
            :en_US => "",
  
            :de_DE => " Ausbau ",
                
          },
          :task => {
            
            :en_US => "Baue einen Jäger und Sammler auf Level 2 aus.",
  
            :de_DE => "",
                
          },
          :flavour => {
            
            :de_DE => " Siehst du, du bist schon so weit gekommen. Könntest du bitte noch einen Jäger und Sammler ausbauen. Dann fühlt er sich wohler und bringt dir mehr Ressourcen. ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Wähle dazu einen Jäger und Sammler aus, das Gebäude, das du bei einem klick auswählen würdest, erkennst du am orangenen Rahmen. Im sich öffnenden Fenster siehst du oben den derzeitigen Stand des Gebäudes, darunter die nächste Ausbaustufe. Klicke auf Upgrade um den Ausbau zu beginnen. </p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => " Wie nett von dir. Der Sammler freut sich wie verrückt.  und hat mir ein paar Rohstoffe für dich mitgegeben.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Denke daran deine Gebäude auszubauen. Gebäude auf kleinen Bauplätzen können maximal auf Stufe 10 ausgebaut werden.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_2gathererlvl1',

          },

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
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 2",
  
            :de_DE => "Ausbau der Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue deine Häuptlingshütte auf Stufe 2 aus.",
                
          },
          :flavour => {
            
            :de_DE => " Halbgott? Und was soll das da sein? Meine Häuptlingshütte? Da kann ja niemand drin leben! Änder das sofort! Bau sie aus und ich geb dir eine Belohnung. ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Die Häuptlingshütte ist das große Gebäude in der Mitte der Siedlung. </p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Endlich fertig hm? Hat ja ewig gedauert. Wie Belohnung? Wofür? Reicht dir es nicht das deine Siedlung größer ist und du ein neues Gebäude bauen kannst? Manche haben auch nie genug. Hier nimm das und verschwinde.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Der Ausbau der Häuptlingshütte schaltet neue Gebäudearten frei und erlaubt dir mehr Gebäude zu bauen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1gathererlvl2',

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
                :resource => :resource_fur,
                :amount => 50,
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

        },              #   END OF quest_build_chiefcottagelvl2
        {               #   quest_profile
          :id                => 6, 
          :symbolic_id       => :quest_profile,
          :advisor           => :girl,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => "Profile",
  
            :de_DE => " Profil ",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Ändere deinen Namen.",
                
          },
          :flavour => {
            
            :de_DE => "Achte nicht ihn, der ist immer so drauf. Jetzt haben wir schon so viel zusammen gemacht und ich weiß immer noch nicht wie du heißt. Bitte sag mir deinen Namen. ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Klicke dazu auf den Profil-Knopf (der mit dem Kopf) oben rechts. Wähle dann choose Name. Die erste Namensänderung ist umsonst. </p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Danke. Ich denke wir werden viel Spass miteinander haben.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " ",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl2',

          },

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
          
          :name => {
            
            :en_US => "Karte",
  
            :de_DE => "Auf die Karte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Begib dich auf die Weltkarte.",
                
          },
          :flavour => {
            
            :de_DE => " Was? Dir ist es hier zu klein? Es hat eine riesige Welt zu erobern. Wenn du mal aus diesem Loch rauskommen würdest, wüsstest du das auch. Worauf wartest du? Geh!",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Drücke dazu den Siedlungsknopf. Das ist der große Knopf, mit den Häusern, oben rechts in der Ecke.</p><p>Der Knopf wechselt auf die Weltkarte und zentriert sie auf der Region mit deiner Siedlung, egal wo du bist.</p><p>Wenn du zurück in deine Siedlung willst, wähle deine Siedlung aus und klicke auf Enter.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na was gelernt? Da hast du sogar noch ein paar Ressourcen, bevor du wieder nach einer Belohnung fragst. ",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Auf der Weltkarte kannst du andere Spieler um dich herum sehen. ",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_profile',

          },

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

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_settlement_button',
            },

          },          

        },              #   END OF quest_settlement_button1
        {               #   quest_rank
          :id                => 8, 
          :symbolic_id       => :quest_rank,
          :advisor           => :chef,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => "Rang",
  
            :de_DE => "Rang",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Suche deinen derzeitigen Rang heraus.",
                
          },
          :flavour => {
            
            :de_DE => "Soso fühlst dich nicht mehr so groß nicht? Sag mir, wie stehst du eigentlich im Vergleich zu den ganzen anderen Halbgöttern.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Klicke dazu auf den Ranking Knopf, oben links. Das Ranking öffnet sich in einem neuen Fenster. Suche dort deinen Namen und trage deinen Rang in das Textfeld ein.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => " Oh Gott. Das ist ja schrecklich. Fang sofort an das zu verbessern. Hier sind ein paar Rohstoffe, verschwende sie nicht.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },

          :requirement => {
            
            :quest => 'quest_settlement_button1',

          },

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
          
          :name => {
            
            :en_US => "Festungen",
  
            :de_DE => "Festungsbesitzer",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Trage den Besitzer der Festung in deiner Region ein.",
                
          },
          :flavour => {
            
            :de_DE => " Die Festungen die du siehst, beherrschen die Regionen. Ich glaub es einfach nicht, dass du so etwas einfaches nicht weißt. Guck nach wem die Festung in deiner Region gehört. ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Aha, dem sollten wir eine Lektion erteilen. ",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Festungen ziehen Steuern aus der Region, die sie beherrschen ein. Der Steuersatz liegt bei 5-20% und wird von der Rohstoffproduktion der Siedlungen in dem Gebiet abgezogen und an den Besitzer der Festung übergeben.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_rank',

          },

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
          
          :name => {
            
            :en_US => "Nachrichten",
  
            :de_DE => "Nachrichten",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Lies die Nachricht.",
                
          },
          :flavour => {
            
            :de_DE => "Um die Nachricht zu lesen, klicke auf den Messages-Knopf oben rechts und wähle dann die Nachricht auf der rechten Seite aus.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Um mit anderen Halbgöttern zu kommunizieren, kannst du ihnen Nachrichten schicken. Ich hab dir eine geschickt, lies sie doch bitte.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ich hoffe sie hat dir gefallen. Hier diese Kröten hab ich gerade gefunden, ich glaube du kannst sie ganz gut gebrauchen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Du kannst zwar Nachrichten empfangen, aber noch keine schreiben.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_settlementowner',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_cash,
                :amount => 15,
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
              :body => "Message with content",
            },

            :de => {
              :subject => 'Nachricht vom Questgeber',
              :body => "Hey, toll du hast die Nachricht gefunden. Wenn du wieder auf die Karte willst, drücke wie überall auf oben rechts auf den Siedlung-Knopf.",
            },

          },          

        },              #   END OF quest_message
        {               #   quest_settlement_button2
          :id                => 11, 
          :symbolic_id       => :quest_settlement_button2,
          :advisor           => :girl,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => "Karte",
  
            :de_DE => "Zurück in die Siedlung",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Begib dich zurück in deine Siedlung.",
                
          },
          :flavour => {
            
            :de_DE => "Du findest deine Siedlung nicht mehr? Das ist ganz einfach, ich erklär's dir. Dann kannst du es versuchen.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Benutze den Siedlungsbutton um die Karte über deiner Siedlung zu zentrieren. Gehe dann in die Siedlung. Drücke dazu oben rechts auf den Siedlungbutton um die Karte auf deiner Siedlung zu zentrieren. Zurück in deine Siedlung kommst du, indem du die Siedlung anwählst und auf Enter drückst.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Na? Ging doch ganz einfach oder? ",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Du kannst in alle deine Siedlungen und Festungen, indem du sie auswählst und enter drückst. ",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_settlementowner',

          },

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

          },          

          :reward_tests => {
            
            :custom_test => {
              :id => 'test_settlement_button',
            },

          },          

        },              #   END OF quest_settlement_button2
        {               #   quest_encyclopedia
          :id                => 12, 
          :symbolic_id       => :quest_encyclopedia,
          :advisor           => :girl,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => "Enzyklopädie",
  
            :de_DE => " Enzyklopädie ",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Trage die Holzkosten eines Ausbildungsgeländes auf Level 2 ein.",
                
          },
          :flavour => {
            
            :de_DE => " Hey Chef hat mich gefragt wie viel Holz der Ausbau eines Ausbildungsgeländes kostet, aber ich finde es einfach nicht in der Enzyklopädie. guck mal. Kannst du bitte gucken ob du es findest? ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Gehe auf die Karte und klicke auf den Enzyklopädie-Knopf unten links. Wähle dann buildings aus und klicke auf Ausbildungsgelände. Suche dort die Holzkosten von Level 2 und gib sie hier ein. </p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Du hast es gefunden? Super, ich geh gleich zu Chef.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " In der Enzyklopädie stehen die Kosten und Bauzeiten aller Einheiten und Gebäude und andere nützliche Informationen.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_settlement_button2',

          },

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
              :body => "<h2>Willkommen in der halböffentlichen geschlossenen Erprobungsrunde</h2>
                <p>Mit dieser Runde wollen wir unser Spielsystem und unsere Server testen, und sind sehr gespannt auf Deine Interpretation von Wack-a-Doo.</p>
                <p>Zur besseren Orientierung empfehlen wir Dir die Erklärungen zur Benutzeroberfläche anzuschauen:</p>
                <p style='margin-left: 32px;'><a href='http://wiki.wack-a-doo.de/Benutzeroberfläche' target='_blank'>http://wiki.wack-a-doo.de/Benutzeroberfläche</a></p>
                <p>Dort werden alle wesentlichen Menüfunktionen anhand von Screenshots erklärt.</p>
                <p>Wack-a-Doo befindet sich gerade in der Entwicklungsphase. In dieser Erprobungsrunde werden wir natürlich auftretende Fehler beheben, wollen aber laufend Neuerungen oder Verbesserungen vornehmen. Jede Änderung werden wir entsprechend ankündigen.</p>
                <p>Wir bitten Dich uns Feedback zu geben oder Fehlermeldungen zu melden. Dafür wurde uns von Shadow-Dragon ein Forumsbereich im Uga-Agga Forum eingerichtet:</p>
                <p style='margin-left: 32px;'><a href='http://forum.uga-agga.de' target='_blank'>http://forum.uga-agga.de</a></p>
                <p>Bitte melde jeden Fehler, damit wir entsprechend schnell reagieren können. Auch Feedback, Ideen oder konstruktive Meinungen sind dort sehr gerne gesehen.</p>
                <p>Wesentliche Spielmechanismen, Übersichten und Erklärungen findest Du in unserem Wiki zusammengefasst:</p>
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
          
          :name => {
            
            :en_US => "Hütten",
  
            :de_DE => "Die kleine Hütte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue eine kleine Hütte.",
                
          },
          :flavour => {
            
            :de_DE => " Deine Arbeiter haben ja noch keine Unterkunft. Bitte baue ihnen doch eine kleine Hütte. Je besser es deinen Arbeitern geht, desto schneller bauen sie auch. ",
  
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
            
            :de_DE => " Wenn dir die Bauaufträge zu lange dauern, kannst du mehr kleine Hütten bauen und ausbauen. ",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_settlement_button2',

          },

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
          
          :name => {
            
            :en_US => "Chief Cottage l3",
  
            :de_DE => "Eine noch größere Häuptlingshütte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue deine Häuptlingshütte auf Level 3 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Deine Siedlung kommt ganz schön voran. Aber du muss jetzt die Häuptlingshütte ausbauen um weiterzukommen, das bringt dir nämlich einen großen Bauplatz.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Auf den Stufen 3, 6 und 9 schaltet die Häuptlingshütte einen großen Bauplatz frei.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll. Und guck, dein erster großer Bauplatz. Auf diesen Bauplätzen kannst du Gebäude viel weiter ausbauen, als auf kleinen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Auf großen Bauplätzen können Gebäude bis auf Level 20 ausgebaut werden. Gebäude des Levels 11 bis 20 geben spezielle Boni.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1cottagelvl1',

          },

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
                :amount => 110,
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
          :id                => 15, 
          :symbolic_id       => :quest_build_1barrackslvl1,
          :advisor           => :chef,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => "Barracks",
  
            :de_DE => "Ausbildungsgelände",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue ein Ausbildungsgelände.",
                
          },
          :flavour => {
            
            :de_DE => " Du kannst ein Ausbildungsgelände bauen machst es aber nicht? Bau sofort eins und ich geb dir etwas aus meiner Schatzkiste.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Ein Ausbildungsgelände bildet Infanterieeinheiten aus. Die besten Einheiten gibt es auf Level 15, dafür müsstest du es aber auf einen großen Bauplatz bauen.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => " Fertig? Na endlich. Da deine Belohnung, mehr gibt's nicht also verschwinde. ",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Das Ausbildungsgelände verkürzt auch die Rekrutierungszeit der Infanterie. ",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl3',

          },

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
          
          :name => {
            
            :en_US => "Einheiten",
  
            :de_DE => "Deine erste Einheit",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue einen Keulenkrieger.",
                
          },
          :flavour => {
            
            :de_DE => "Keine Einheiten weit und breit. Da sollte sich mal jemand drum kümmern, sonst wird diese Siedlung demnächst niedergebrannt.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Wähle dazu das Ausbildungsgelände aus, wähle dort den Keulenkrieger in der Rekrutierungsliste ganz unten aus und klicke Train Keulenkrieger. Die trainierten Einheiten landen in der Garnison der Siedlung. </p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Naja aller Anfang ist schwer, da musst du noch dran arbeiten. Fürs erste stell ich dir 3 meiner Keulenkrieger zur Verfügung. ",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Nachdem du Einheiten in Auftrag gegeben hast, kannst du das Gebäudefenster schließen, der Auftrag läuft trotzdem weiter. Wenn du wissen willst, wie weit der Auftrag ist, klickst du einfach wieder auf das Ausbildungsgelände. Du kannst auch mehrere Einheiten gleichzeitig trainieren, dazu gibst du die gewünschte Zahl anstatt der 1 ein und klickst dann auf Train. Neue Einheiten werden auf höheren Gebäudelevel freigeschaltet.",
  
            :en_US => " ",
                
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
          
          :name => {
            
            :en_US => "Armee",
  
            :de_DE => "Deine erste Armee",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Stelle eine Armee auf.",
                
          },
          :flavour => {
            
            :de_DE => "Einheiten in Garnisonen können sich nicht bewegen. Um Einheiten zu bewegen müssen sie aus der Garnison in eine Armee verschoben werden. Das müsste mal jemand machen.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Gehe auf die Karte und wähle deine Siedlung aus. Wähle unten rechts im Inspektor New Army. </p><p> Im nachfolgenden Dialog  siehst du die verfügbaren Einheitentypen. Auf der linken Seite ist die Einheitenzahl des Typs in der Garnison, auf der rechten, die Zahl, die in der Armee landen wird. </p><p> Benutze entweder die Pfeile, um alle oder einzelne Einheiten eines Typs in die Armee zu verschieben, oder gib direkt eine Zahl ins Textfeld ein. </p><p> Gib der Armee einen Namen und drücke auf Erzeugen. Zurücksetzen setzt die Zahlen wieder auf den Anfangszustand zurück.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Naja eine Armee ist das wohl, aber noch ziemlich klein oder? Trotzdem hier deine Belohnung. ",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Jede Armee benötigt einen Kommandopunkt in der Siedlung, aus der sie erstellt wird. Außerdem hat sie ein Einheitenlimit. ",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_recruit_1clubbers',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 65,
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
          
          :name => {
            
            :en_US => "Armeebewegung",
  
            :de_DE => "Armeebewegung",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Bewege deine Armee zur Festung",
                
          },
          :flavour => {
            
            :de_DE => " Eine Armee kann mehr als nur rumstehen. Sie ist dazu da die Feinde des Stammes zu vernichten. Aber natürlich sollte ein Angriff nicht überstürzt sein. Vorsicht ist geboten, erst wenn eine Armee stark genug ist, sollte sie sich auf den Weg zu einer feindlichen Festung machen. ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Wenn du bereit bist, wähle deine Armee aus, drücke auf Move und dann auf das Ziel. Mögliche Ziele sind mit einem grünen Pfeil markiert. Bewegungen zu von Spielern kontrollierten Festungen sollten nur mit Einverständnis des Spielers oder mit genügender Kampfstärke erfolgen.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hm? Die Armee ist unterwegs? Sicher das du genug Truppen hast? Na okay ich glaub dir ja, hier hast du ein paar Rohstoffe, für Verstärkungen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Unter deiner Armee siehst du die verfügbaren Aktionspunkte. Jede Bewegung und jeder Angriff kostet dich einen Aktionspunkt. Über Zeit regenerieren Armeen ihre Aktionspunkte wieder. ",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_army_create',

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
                :resource => :resource_fur,
                :amount => 100,
              },

            ],

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
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 4",
  
            :de_DE => " Und wieder die Häuptlingshütte ",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => " Baue deine Häuptlingshütte auf Level 4 aus. ",
                
          },
          :flavour => {
            
            :de_DE => "Ich denke es ist mal wieder Zeit für eine größere Häuptlingshütte. Bau sie doch bitte aus.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ist es nicht toll wie deine Siedlung wächst? Ich habe sogar Chef dazu überreden können dir etwas von seinem Rohstoffberg abzugeben.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1barrackslvl1',

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
          
          :name => {
            
            :en_US => "Lagerfeuer",
  
            :de_DE => "Lagerfeuer",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => " Baue ein Lagerfeuer.",
                
          },
          :flavour => {
            
            :de_DE => " Hey wie wär's mit einem Lagerfeuer für deine Siedlung? An Lagerfeuern treffen sich die Diplomaten, tauschen Nachrichten aus und schmieden Allianzen. Wäre doch schön so etwas zu haben oder? ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Lagerfeuer werden benötigt um Nachrichten zu schreiben und Allianzen zu gründen oder ihnen beizutreten. Außerdem wird es für die Rekrutierung von Verwalter und die Gründung von Lagerstätten gebraucht.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Ach wie das Feuer knistert. Wie schön.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl4',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 60,
              },

              {
                :resource => :resource_wood,
                :amount => 65,
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
          
          :name => {
            
            :en_US => "Allianzen",
  
            :de_DE => "",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => " Tritt einer Allianz bei oder gründe deine eigene. ",
                
          },
          :flavour => {
            
            :de_DE => "Feindliche Armeen mit deinen eigenen Armeen zu bekämpfen ist ja nett. Aber viel besser wäre es doch, wenn ihr zusammenarbeiten würdet oder wenn deine Freunde dir helfen würden. Du solltest in einer Allianz sein, da hilft man sich gegenseitig.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p> Ab jetzt kannst du einer Allianz beitreten. Eine Allianz hat viele Vorteile, man tauscht Rohstoffe, hilft sich gegenseitig bei der Verteidigung und koordiniert Angriffe. Nur eine Allianz kann ein großes Territorium halten. Wenn du dich bereit fühlst, tritt doch einer bei. </p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Hui das ist aber eine tolle Allianz. Ich bin sicher, dass ihr sehr weit kommen werdet.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Du kannst das Allianzprofil einsehen, indem du auf den Allianzwimpel oben rechts neben der Rohstoffübersicht klickst. ",
  
            :en_US => " ",
                
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
        {               #   quest_build_1storagelvl1
          :id                => 22, 
          :symbolic_id       => :quest_build_1storagelvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => "Rohstofflager",
  
            :de_DE => " Rohstofflager ",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue ein Rohstofflager.",
                
          },
          :flavour => {
            
            :de_DE => " Stört es dich nicht auch, dass das Lagerplatz so gering ist? Bau doch bitte ein Rohstofflager, damit wir mehr Platz haben. ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Rohstofflager erhöhen die maximale Menge an Rohstoffen, die du lagern kannst. Wenn du die Grenze erreichst, verfällt die überschüssige Produktion. Außerdem erlauben sie dir mit anderen Spielern zu handeln.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll sieht das aus. Endlich hab ich genug Platz für meine ganzen Sachen.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Jeder Handelskarren kann 10 Ressourcen befördern.",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_chiefcottagelvl4',

          },

          :rewards => {
            
            :resource_rewards => [

              {
                :resource => :resource_stone,
                :amount => 55,
              },

              {
                :resource => :resource_wood,
                :amount => 65,
              },

              {
                :resource => :resource_fur,
                :amount => 25,
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

        },              #   END OF quest_build_1storagelvl1
        {               #   quest_build_chiefcottagelvl5
          :id                => 23, 
          :symbolic_id       => :quest_build_chiefcottagelvl5,
          :advisor           => :girl,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => "Häuptlingshütte Level 5",
  
            :de_DE => "Häuptlingshütte die Vierte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Baue deine Häuptlingshütte auf Level 5 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Sieht so aus, als wärst du wieder so weit, deine Häuptlingshütte auszubauen.",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Toll wie weit du schon gekommen bist.",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "",
  
            :en_US => " ",
                
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
        {               #   quest_build_1quarrylvl1_1loggerlvl1
          :id                => 24, 
          :symbolic_id       => :quest_build_1quarrylvl1_1loggerlvl1,
          :advisor           => :girl,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => "Baumfäller und Steinbruch",
  
            :de_DE => " Steinbrüche und Holzfäller ",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => " Baue einen Steinbruch und einen Holzfäller ",
                
          },
          :flavour => {
            
            :de_DE => "Hast du gesehen, dass du jetzt spezielle Rohstoffgebäude bauen kannst? Ja genau Steinbrüche und Holzfäller. Die bringen zwar nur einen bestimmten Rohstoff, aber dafür davon viel mehr als der Sammler. Wäre toll wenn du einen Steinbruch und einen Holzfäller bauen würdest.",
  
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
  
            :en_US => " ",
                
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
          :id                => 25, 
          :symbolic_id       => :quest_build_5quarrylvl5_5loggerlvl5,
          :advisor           => :girl,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => "Noch mehr Holzfäller und Steinbrüche",
  
            :de_DE => "",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "5 Steinbruch und 5 Holzfäller auf Level 5 ausbauen",
                
          },
          :flavour => {
            
            :de_DE => " Wenn du deine Rohstoffproduktion steigern willst, musst du mehr Steinbrüche und Holzfäller bauen und die dann ausbauen. ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => " Wow, guck mal wie viel Rohstoffe du produzierst. Ist ja cool.",
  
            :en_US => " ",
                
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
        {               #   quest_build_1campfirelvl10
          :id                => 26, 
          :symbolic_id       => :quest_build_1campfirelvl10,
          :advisor           => :girl,
          :hide_start_dialog => false,
          
          :name => {
            
            :en_US => "Lagerfeuer",
  
            :de_DE => "Lagerfeuer Level 10",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => " Baue dein Lagerfeuer auf Level 10 aus.",
                
          },
          :flavour => {
            
            :de_DE => "Ich würde gern eine Lagerstätte gründen, aber dafür brauchen wir zuerst einen Verwalter und der kann nur an einem ausgebauten Lagerfeuer trainiert werden. Baust du es bitte für mich aus?",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p></p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => " Gut. Jetzt kannst du Verwalter trainieren. ",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => "Verwalter sind teuer und haben eine lange Rekrutierungszeit.. Außerdem sind sie Infanterieeinheiten. Versuche sie deswegen nicht in Kämpfe zu verwickeln.",
  
            :en_US => " ",
                
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
                :amount => 100,
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
          
          :name => {
            
            :en_US => "Dorf",
  
            :de_DE => "Lagerstätte",
                
          },
          :task => {
            
            :en_US => "",
  
            :de_DE => "Gründe eine Lagerstätte.",
                
          },
          :flavour => {
            
            :de_DE => " Du musst dich mehr ausbreiten. Gründe eine Lagerstätte aber flott. Dann findet sich bei mir vielleicht auch etwas, das ich dir überlassen kann.
Aufgabentext: Gründe eine Lagerstätte. ",
  
            :en_US => "flavor text english",
                
          },
          :description => {
            
            :de_DE => "<p>Um eine Lagerstätte zu gründen, musst du einen Verwalter am Lagerfeuer ausbilden und diesen mit einer Armee zu einem freien Feld bewegen. Du kannst allerdings nur eine Lagerstätte pro Region haben.</p><p>Außerdem kostet die Dorfgründung noch 10.000 Holz, 10.000 Stein und 5.000 Fell</p><p>Du kannst nur weitere Siedlungen gründen, wenn du im Rang aufsteigst.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          
          :reward_flavour => {
            
            :de_DE => "Du hast eine Lagerstätte gegründet? Brauchst du immer so lange für einfach Aufgaben? Hier nimm die Rohstoffe und geh mir aus den Augen. Dein Anblick macht mich krank. ",
  
            :en_US => "",
                
          },
          :reward_text => {
            
            :de_DE => ".",
  
            :en_US => " ",
                
          },

          :requirement => {
            
            :quest => 'quest_build_1campfirelvl10',

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

