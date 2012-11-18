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

class BotMailer < ActionMailer::Base
  default from: Rails.env.production? ?  "watchguard@gs02.wack-a-doo.de" : "watchguard@test1.wack-a-doo.de"
  
  def breach_report(uid, domain, nickname, presence)
    mail(:to => 'sascha@5dlab.com', 
         :subject => "CHAT BOT: possible security breach by #{uid}.",
         :body => "#{uid}@#{domain} tried to access the chat as #{nickname}.\n\n#{presence}"
        )
  end
  
  def missing_report(presence)
    mail(:to => 'sascha@5dlab.com', 
         :subject => "CHAT BOT: missing user item.",
         :body => "Original Presence: #{presence}"
        )
  end

  def exception_report(presence, e)
    mail(:to => 'sascha@5dlab.com', 
         :subject => "CHAT BOT: exception.",
         :body => "Original Presence: #{presence}\nException #{e.message}, #{e.backtrace.inspect}"
        )
  end
end


def is_valid(uid, nickname, domain)
  return false  if domain.nil? || APP_CONFIG['jabber']['host'] != domain.downcase
  return true   if nickname == APP_CONFIG['jabber']['name']
  return true   if nickname.starts_with? "WackyUser"    # most common reason are name changes...

  characters = Fundamental::Character.case_insensitive_identifier(uid)

  characters.each do |character|
    correct = character.name + (character.alliance.nil? ? "" : " | #{ character.alliance.tag }")
    return true if nickname == correct
  end
  
  return false
end


def handle_new_presence(p)
  begin
    if p.x && p.x.kind_of?(Jabber::MUC::XMUCUser) && p.x.items && p.x.items.size > 0

      uid      = p.x.items[0].jid.node      # the character's unique id used to login as part of the JID
      nickname = p.from.resource            # the nickname set by the user (client)
      domain   = p.x.items[0].jid.domain    # the domain (host) of the JID
    
      if !is_valid(uid, nickname, domain)
        Rails.logger.error "CHAT SECURITY: ERROR OR POSSIBLE BREACH: INVALID PRESENCE #{uid} on #{domain} as #{nickname}"
        puts "POSSIBLE BREACH: INVALID PRESENCE #{uid} on #{domain} as #{nickname}"
        BotMailer.breach_report(uid, domain, nickname, p).deliver
      end
    else 
      Rails.logger.error "CHAT SECURITY: ERROR: MISSING USER ITEM: #{p}"
      puts "ERROR: MISSING USER ITEM: #{p.x}"      
      BotMailer.missing_report(p).deliver
    end  
  rescue => e
    Rails.logger.error  "CHAT SECURITY: ERROR: CATCHED EXCEPTION WHILE HANDLING PRESENCE #{e.message}, #{e.backtrace}."
    puts  "EXCEPTION WHILE HANDLING PRESENCE #{e.message}, #{e.backtrace}."
    BotMailer.exception_report(p, e).deliver
  end
end

class Jabber::MUC::WatchGuard < Jabber::MUC::MUCClient
  
  def initialize(stream)
    super(stream)

    self.add_message_callback  { |m|  }
    self.add_presence_callback { |p| handle_new_presence(p) }
    self.add_join_callback     { |p| handle_new_presence(p) }    
  end
  
end


begin
  
  @client = Jabber::Client::new(Jabber::JID::new(APP_CONFIG['jabber']['botJid']))
  @client.connect
  @client.auth(APP_CONFIG['jabber']['password'])
  @client.send(Jabber::Presence.new.set_show(:away))
  
  public_room_jids = [
    "global@#{APP_CONFIG['jabber']['muc']}/Wächter | 5D",
    "plauderhöhle@#{APP_CONFIG['jabber']['muc']}/Wächter | 5D",
    "help@#{APP_CONFIG['jabber']['muc']}/Wächter | 5D",
    "handel@#{APP_CONFIG['jabber']['muc']}/Wächter | 5D",
  ]
  
  public_room_jids.each do |room|
    @muc_client = Jabber::MUC::WatchGuard.new(@client)
    @muc_client.join(Jabber::JID.new(room))  
  end


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
  
rescue => e
  RAILS.logger.error "CHAT SECURITY: error in security script #{e.message}, #{e.backtrace.inspect}"
  puts "Error message: #{e.message}"
  puts "Error backtrace: #{e.backtrace.inspect}"
end

#@client.close