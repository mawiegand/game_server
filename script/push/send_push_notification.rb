#!/usr/bin/env ruby
# encoding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

STDOUT.sync = true

puts
puts "This script sends push notifications."

APNS.host = 'gateway.push.apple.com'
# gateway.sandbox.push.apple.com is default

APNS.pem  = './script/push/apns-prod.pem'
# this is the file you just created

APNS.port = 2195

device_token = 'c6e55543ffc00c85cf235e481b7b78e074c3a1d6c2d5a5f5b743cac9ecfbf5c1'

APNS.send_notification(device_token, 'Nur noch ') #2 Tage! Unterstütze das Crowdfunding von Wack-A-Doo jetzt und sichere Dir die einmaligen Dankeschöns. www.startnext.dewackadoo')

device_token = '0127655a7d1859916e56ab8126102a0e63eb3d91d2332958ca3a407ab01827fc'

APNS.send_notification(device_token, 'Nur noch 2') # Tage! Unterstütze das Crowdfunding von Wack-A-Doo jetzt und sichere Dir die einmaligen Dankeschöns. www.startnext.dewackadoo')

puts "Done."