#!/usr/bin/env ruby
#coding: utf-8

#
# Copyright (c) 2012 David Unger
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

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))


#require 'yaml'
#require "dbi"
#require 'xmpp4r'
#require 'xmpp4r/muc'
#require 'xmpp4r/muc/helper/mucbrowser'
require './include/patch.rb'
require './include/xmpp.rb'

# Konfig einlesen
raw_config = File.read("./config/configBot.yml")
APP_CONFIG = YAML.load(raw_config)

# Init Xmpp
Xmpp.init

# connect to the MySQL server
begin
  @dbh = DBI.connect("DBI:Mysql:#{APP_CONFIG['mysql']['database']}:#{APP_CONFIG['mysql']['host']}", APP_CONFIG['mysql']['username'], APP_CONFIG['mysql']['password'])
  # get server version string and display it
  row = @dbh.select_one("SELECT VERSION()")
  puts "Server version: " + row[0]
rescue DBI::DatabaseError => e
  @dbh.disconnect if @dbh

  @logger.info "Fehler beim Verbinden zur Datenbank"
  @logger.error "Error code: #{e.err}"
  @logger.error "Error message: #{e.errstr}"
  exit
end

begin
  loop do
    puts "loooop"
    # Auslesen der nächsten Aktionen aus der Datenbank
    sth = @dbh.prepare("SELECT id, type, room, data FROM jabber WHERE blocked = 0")
    sth.execute()

    rows = sth.fetch_all

    if rows.size > 0
      # Verbindung zum Jabber Server herstellen
      Xmpp.connect

      rows.each do |row|
        case row[1]
          when "muc_create"
            Xmpp.muc_create row[0], row[2], row[3]
          when "muc_delete"
            Xmpp.muc_delete row[0], row[2], row[3]
          when "auth_add"
            Xmpp.auth_add row[0], row[2], row[3]
          when "auth_delete"
            Xmpp.auth_delete row[0], row[2], row[3]
          else
            @logger.error "Unbekannter Befehl "+row[1]
        end
      end
    end
    sth.finish

    # Da wir nicht wissen wann das nächste mal was passiert erstmal die Jabber Session schließen.
    Xmpp.close

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