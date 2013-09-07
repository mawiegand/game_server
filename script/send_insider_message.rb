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
    #if character.insider

      Messaging::Message.create({
        type_id:    Messaging::Message::INDIVIDUAL_ANNOUNCEMENT_TYPE_ID,
        sender_id:  sender.id,
        recipient_id: character.id,
        subject:   "Start Next, Rundenende & Entwicklerchat",
        body:      "<h2>Hallo #{ character.name },</h2>
          <p>nur noch 3 Tage bis zum 09.09. läuft unsere  <a href='http://www.startnext.de/wack-a-doo' target='_blank'>Crowdfunding-Kampagne auf Startnext</a>.</p>
          <p>Wir haben bisher circa 90% des anvisierten Ziels erreicht und werden mit Eurer Hilfe auch den Rest schaffen.</p>
          <p>Unterstützt uns jetzt und sichert Euch die einmaligen Dankeschöns wie das <b>Starterpaket</b> für 15 Euro oder den <b>lebenslangen Platinum-Account</b> für 99 Euro. Oder sucht Euch die Varianten mit den tollen <b>Wack-A-Doo Tassen</b> oder <b>Wack-A-Doo T-Shirt</b> aus.</p>
          <p>Wir freuen uns über jede Unterstützung und werden weiterhin daran arbeiten Wack-A-Doo laufend zu verbessern.</p>
          <p>Viel Spass bei Wack-A-Doo<br/>
          Wack On!</p>
          <p>Hajo</p>",
        send_at:   DateTime.now,
        reported:  false,
        flag:      0,
      })
          
      puts character.name
    #end
  end
end

puts "Done."