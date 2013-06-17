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
       subject:   "Wack-A-Doo Insider!",
       body:      "<p><small>Please find an English summary at the end of this message.</small></p>\
<h1>Hallo #{ character.name },</h1>\
<p>als #{ male ? "einem Spieler" : "einer Spielerin" } der ersten Stunde haben wir Dir und allen anderen aktiven #{ male ? "Spielern" : "Spielerinnen" } den Status\
   <b>Insider</b> verliehen. Dies ist als Dankeschön für die frühe Teilnahme gedacht und bleibt\
   Dir dauerhaft erhalten. Nachfolgende #{ male ? "Spieler" : "Spielerinnen" } können ebenfalls in diesen erlauchten Kreis\
   aufrücken, indem sie eine Runde von Wack-A-Doo gewinnen oder mindestens drei Runden\
   überleben.</p>\
<p>Als Insider kannst Du ab sofort einen gesonderten Chatraum betreten und wirst
   in Zukunft regelmäßig News über die Spielentwicklung in einem (optionalen) Newsletter 
   beziehen können. Der Chatraum ist als ruhiges Refugium für erfahrene Spieler gedacht,
   ab sofort im Browser (https://wack-a-doo.de) verfügbar und wird auf iOS mit
   dem nächsten Update der App freigeschaltet. Über den Newsletter werden wir in den 
   nächsten Wochen gesondert informieren.</p> 
<p>Gerne lass uns Dein Feedback zukommen. Insbesondere die ersten 
   Erfahrungen unserer neuen App User interessieren uns brennend. Die App ist noch in einem
   recht frühen Stadium, aber wir arbeiten ununterbrochen an Verbesserungen und Erweiterungen
   - natürlich auch für den Browser.</p>
<p>Bitte wende Dich mit 
   Feedback oder auch im Falle von Fragen und Problemen einfach
   direkt an mich oder an meine Kollegen bei 5d lab (Allianz: 5D) oder per Email an 
   <a href=\"mailto:support@5dlab.com\">support@5dlab.com</a>.</p>
<p>Abschließend möchte ich Dich noch einmal herzlich in Wack-A-Doo willkommen heißen: 
   Wir freuen uns, dass Du da bist!</p>
<p>Viel Spaß<br/>und<br/>Whack On<br/><br/>Sascha.</p>
<br/><br/><br/><hr/>
<h1>Hi #{ character.name },</h1>\
<p>this message was sent to let you know about your new status \"Wack-A-Doo Insider\".
   We granted this status to all active players as a small thank you for joining and playing
   Wack-A-Doo that early. Your status allows you to access an exclusive chat room in the
   browser client and, in about a week, in the iOS client.</p>
<p>Furthermore, we'd like to welcome you again to the game and to encourage you to contact
   us in case of questions or problems - or just to give us some valuable feedback.</p>
<p>Have fun and Whack On<br>Sascha.</p> 
",
       send_at:   DateTime.now,
       reported:  false,
       flag:      0,
     })
          
     puts character.name
   end
 end
end

puts "Done."