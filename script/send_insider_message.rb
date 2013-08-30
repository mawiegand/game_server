#!/usr/bin/env ruby
# encoding: utf-8
#
# Helper script that makes all non-deleted characters insider.
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

STDOUT.sync = true

puts
puts "This script sends all players a notification about their new insider status."

 sender = Fundamental::Character.find_by_name('Sascha')
 
if !sender.nil? 

 Fundamental::Character.non_npc.not_deleted.each do |character|
   if character.insider
     
     male = character.male?

     Messaging::Message.create({
       type_id:    Messaging::Message::INDIVIDUAL_ANNOUNCEMENT_TYPE_ID,
       sender_id:  sender.id,
       recipient_id: character.id,
       subject:   "Start Next, Rundenende & Entwicklerchat",
       body:      "<h2>Hallo #{ character.name },</h2>

        <p>wir möchten Dir als Insider weitere Informationen zukommen lassen. Im iOS Client gibt es bereits den 'experimentellen' Modus, den Du an- und abschalten kannst. Wir entwickeln gerade die ersten Geofunktionen und wollen Euch über diesen Schalter einen frühzeitigen Zugriff geben und an der Entwicklung teilhaben lassen.</p>

        <p>Bereits jetzt ist im experimentellen Modus die reale Weltkarte zu sehen; in Kürze werden auch die ersten 'aktiven' Geofunktionen im Spiel erscheinen; ihr werdet Euren Character sowie andere Spieler in Eurer Umgebung sehen und könnt schätze Einsammeln. Das ganze kommt noch mit einigen Ecken und Kanten, wird aber einen ersten Eindruck geben, wo wir im nächsten halben Jahr hinwollen. Wenn Ihr Eure Position nicht mitteilen und die Features nicht testen wollt, schaltet die experimentellen Features einfach aus; es werden dann absolut keine Daten preisgegeben. Zu finden wird der Schalter unter 'Einstellungen' im Characterprofil sein.</p>

        <p>Im HTML-Client werden wir experimentelle Features samt Schalter nachziehen, sobald dort Geofunktionen eingebaut werden. </p>

        <p>Außerdem werden wir Dir mit der kommenden Runde auch den Zugang zu unserer 'internen' Testrunde ermöglichen; Du wirst sie über ein Auswahlmenü beim Öffnen der App anwählen und beide Runden (Test + Öffentlich) parallel spielen können. Generell planen wir ab Runde 4 mit einer Rundendauer von 3-5 Monaten, bis eine Allianz gewinnt. Die nachfolgende Runde werden wir dann in Zukunft bereits zu ungefähr der Halbzeit der gerade laufenden Runde starten. So sollte die Spannung zu jederzeit und sowohl für alte Hasen als auch Neuankömmlinge hoch sein.</p>

        <p>Wir hoffen, Euch damit einen spannenden Einblick zu geben und freuen uns immer über Euer Feedback; gerne auch zu den ersten experimentellen Funktionen.</p>

        <p>Viele Grüße</p>

        <p>Sascha</p>",
       send_at:   DateTime.now,
       reported:  false,
       flag:      0,
     })
          
     puts character.name
   end
 end
end

puts "Done."