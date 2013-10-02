#!/usr/bin/env ruby
#
# Helper that extracts geo locations for all players.
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))
require 'geo_server/geo_ip'


STDOUT.sync = true

puts "## remote_ip, latitude, longitude"

Fundamental::Character.not_deleted.each do |character|
  sign_in = character.sign_ins.latest.first
  if !sign_in.nil? && !sign_in.remote_ip.nil?
    geo_coords = GeoServer::GeoIp.fetch_coords_for_ip(sign_in.remote_ip)
    puts "#{sign_in.remote_ip}, #{geo_coords['latitude']}, #{geo_coords['longitude']}"
  end
end

