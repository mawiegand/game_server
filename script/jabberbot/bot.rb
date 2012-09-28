#!/usr/bin/env ruby
#coding: utf-8


#
# Copyright (c) 2012 David Unger, Sascha Lange
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# Ruby Script zum ertellen & löschen von Räumen sowie hinzufügen & löschen der User die ihn betreten drüfen.
#
# benötigte gem Packete: xmpp4r, dbi, dbi-mysql
#
# SQL TABELLE:
# CREATE TABLE IF NOT EXISTS `jabber` (
#   `id` int(11) NOT NULL AUTO_INCREMENT,
#   `type` varchar(255) NOT NULL,
#   `room` varchar(255) NOT NULL,
#   `data` varchar(255) NOT NULL,
#   `blocked` tinyint(1) NOT NULL DEFAULT '0',
#   PRIMARY KEY (`id`)
# );

# Todo:
#       - Vor dem erstellen eines Raumes alle User kicken
#

require File.expand_path(File.join(File.dirname(__FILE__), '../..', 'config', 'environment'))


#require 'yaml'
#require "dbi"
require 'xmpp4r'
require 'xmpp4r/muc'
require 'xmpp4r/muc/helper/mucbrowser'
require './include/patch.rb'
require './include/xmpp.rb'

# Konfig einlesen
raw_config = File.read("./config/configBot.yml")
APP_CONFIG = YAML.load(raw_config)

# Init Xmpp
Xmpp.init

@logger = Rails.logger

begin
  loop do
    puts "loooop"
    # Auslesen der nächsten Aktionen aus der Datenbank
    
    commands = Messaging::JabberCommand.where(['processed = ? AND blocked_at IS NULL AND command="muc_create"', false]).order(:created_at)
    if commands.count == 0
      commands = Messaging::JabberCommand.where(['processed = ? AND blocked_at IS NULL', false]).order(:created_at)
    end
    
    commands.each { |command| puts command.inspect }
    
    if commands.count > 0
      # Verbindung zum Jabber Server herstellen
      Xmpp.connect

      commands.each do |command|
        command.blocked_at = Time.now
        command.blocked_by = "GAME SERVER BOT"
        command.save
        case command.command
          when "muc_create"
            Xmpp.muc_create  command
          when "muc_delete"
            Xmpp.muc_delete  command
          when "auth_add"
            Xmpp.auth_add    command
          when "auth_delete"
            Xmpp.auth_delete command
          else
            @logger.error "Unbekannter Befehl #{command.command}."
        end
        command.blocked_at = nil
        command.blocked_by = nil
        command.processed = true
        command.save
      end

      Xmpp.close
    end

    # Bis zur nächsten Prüfung warten
    sleep APP_CONFIG['sleep']
  end
rescue Exception => e
  @logger.info "Fehler im Script"
  @logger.error "Error message: #{e.message}"
  @logger.error "Error backtrace: #{e.backtrace.inspect}"
  exit
end


Thread.stop