#!/usr/bin/env ruby
# encoding: utf-8
#
# Helper script that makes all non-deleted characters insider.
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

STDOUT.sync = true

puts
puts "This script sends all players a notification about their new insider status."

 sender = Fundamental::Character.find_by_name('Hajo')
 
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

<p>wir möchten Euch heute auf unsere still und leise gestartete Crowdfunding-Kampagne auf <a href='http://www.startnext.de/wack-a-doo' target='_blank'>Startnext</a> aufmerksam machen. Bis zum 9.9. könnt Ihr mit Euer Teilnahme helfen, die kommende Runde zu starten und Wack-A-Doo weiter zu entwickeln.</p>

<p>Besonders hinweisen möchten wir auf das <b>Startpaket für Runde 4</b>, quasi das <b>Rundenticket</b> für die kommende Runde. Ihr erhaltet für eine Unterstützung in Höhe von 15 EUR einen Bonus von 6000 Startressourcen sowie 100 Credits. Dies ist ein kleiner Bonus in Runde 4 gegenüber den nicht unterstützende Spielern, der nur auf diese Weise bezogen werden kann. Namentlich verewigt (Nickname oder Realname) werdet Ihr natürlich auch!</p>

<p>Tassen und T-Shirts gibt‘s natürlich auch; in und ohne Verbindung mit einem lebenslangem Platinum-Account.</p>

<p>Die Teilnahme ist dabei absolut risikolos, wird das Finanzierungsziel nicht erreicht, bekommt Ihr Euer Geld automatisch zurückerstattet.</p>

<p>Wir sind sehr zuversichtlich das Ziel von 3.000 Euro zu erreichen. 100 Leute, die das Starterpaket erwerben, führen z.B. schon zum Erreichen der Finanzierungshürde. Mit Euer zahlreichen Unterstützung schaffen wir vielleicht sogar noch die nächste Stufe und können die Neugestaltung des Neandertalers bei <a href='http://www.alexanderpierschel.de' target='_blank'> Pikomi </a> in Auftrag geben.</p>


<h2>Rundenende aktuelle Runde</h2>

<p>Wir läuten in dieser Woche das Rundenende ein. Ab sofort wird der Prozentsatz für den <b>Herrschaftssieg</b> schneller sinken. Weitere Artefakte werden im Laufe der kommenden Tage im Spiel auftauchen. Genauere Infos gibt es beim freundlichen Neandertaler.</p>

<p>Wir vergeben zum Rundenende außerdem wieder verschiedene Belohnungen, die am Spielercharakter dauerhaft für <b>alle weiteren Runden</b> vermerkt bleiben:
</p>

<ul><li>Jeder Spieler der <b>Allianz</b>, die zuerst eine der beiden Siegbedingungen erfüllt, erhält neben dem Eintrag als Rundensieger einen dauerhaften <b>10% Bonus auf alle erhaltene Erfahrung</b>.</li>
<li>Alle Spieler der Top 100 erhalten einen <b>dauerhaften 5% Bonus auf die Erfahrung</b>. (Spieler der Siegerallianz in Summe 15% Bonus!)</li>
<li>Alle Spieler der Top 500 erhalten den Eintrag „Runde Erde überlebt“ in ihr Profil.</li>
<li>Wir speichern außerdem bereits seit Runde 0 alle Rankingpositionen und werden sie innerhalb der nächsten Runde am Profil einsehbar machen. D.h. jede Verbesserung im Ranking wird notiert und zählt ;-)</li>
</ul>
<h2>Chat</h2>
<p>Heute, am Dienstag um 20.00 Uhr findet ein allgemeiner, offener Entwicklerchat statt. Wenn Ihr Zeit habt, schaut in global vorbei; vielleicht bekommt Ihr Eure Frage unter.</p>

<p>Weiterhin viel Spaß<br/>
Wack On<br/>
<br/>
Hajo</p>",
       send_at:   DateTime.now,
       reported:  false,
       flag:      0,
     })
          
     puts character.name
   end
 end
end

puts "Done."