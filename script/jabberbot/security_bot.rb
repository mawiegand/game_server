#!/usr/bin/env ruby
# encoding: utf-8
#
# Security chat bot
#

require File.expand_path(File.join(File.dirname(__FILE__), '../..', 'config', 'environment'))

require 'xmpp4r/muc'
require 'xmpp4r/muc/helper/mucbrowser'
require './include/patch.rb'
require './include/xmpp.rb'

require 'xmpp4r/muc/x/muc'
require 'xmpp4r/muc/iq/mucowner'
require 'xmpp4r/muc/iq/mucadmin'
require 'xmpp4r/dataforms'

raw_config = File.read("../jabberbot/config/configBot.yml")
APP_CONFIG = YAML.load(raw_config)

#Jabber::debug = true

begin
  
  @client = Jabber::Client::new(Jabber::JID::new(APP_CONFIG['jabber']['botJid']))
  @client.connect
  @client.auth(APP_CONFIG['jabber']['password'])
  @client.send(Jabber::Presence.new.set_show(:away))
  
  room_jid = Jabber::JID.new "global@#{APP_CONFIG['jabber']['muc']}/Wächter | 5D"
  @muc_client = Jabber::MUC::MUCClient.new(@client)
  
  @muc_client.add_message_callback do |m|
    puts "Message:  #{m.inspect}"
  end  
  
  @muc_client.add_presence_callback do |roster_item, oldp, newp|
    
    puts "Old:      #{oldp.inspect}  New: #{newp.inspect}."
  end
  
  @muc_client.add_join_callback do |p|
    puts p.type
    p.x
    puts p.x
    p.x.kind_of? Jabber::MUC::XMUCUser
  #  is_user = p.x and p.x.kind_of? XMUCUser
   # str = "INSP #{p.x}" if p.x and p.x.kind_of?(XMUCUser)
    #puts "Presence: #{p}."
#    hash = Hash.from_xml(p.to_s)
#    puts "JID: #{ hash['presence']['x']['item']['jid'] }"
  end

  @muc_client.join(room_jid)  



#  @muc_client.on_message { |time,nick,text|
#    puts (time || Time.new).strftime('%I:%M') + " <#{nick}> #{text}"
#  }
   
#  @muc_client.on_room_message { |time,nick,text|
#    puts (time || Time.new).strftime('%I:%M') + " <#{nick}> #{text}"
#  }   
    
  loop do
    puts "loooop"


    sleep APP_CONFIG['sleep']
  end
  
rescue Exception => e
  Rails.logger.info "Fehler im Script"
  puts "Error message: #{e.message}"
  puts "Error backtrace: #{e.backtrace.inspect}"
end

#@client.close