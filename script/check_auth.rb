#!/usr/bin/env ruby

require 'logger'
require 'httparty'

$stdout.sync = true
$stdin.sync = true

path = "./log/auth.log"
file = File.open(path, File::WRONLY | File::APPEND | File::CREAT)
file.sync = true
logger = Logger.new(file)
logger.level = Logger::DEBUG

@logger = logger  # we also need the logger in the methods

def get_with_auth_token(path, token)
  HTTParty.get(path, :headers => { 'Accept' => 'application/json', 'Authorization' => "Bearer #{ token }"})
end

def auth(username, password)
  begin
    @logger.debug "Starting call to game server."
    response = get_with_auth_token("https://wack-a-doo.de/game_server/fundamental/characters/self", password)
    @logger.debug "Response code #{response.code} with content: #{ response.inspect }."
    
    if response.code == 200
      identity = response.parsed_response
      return true    if !identity["identifier"].nil? && identity["identifier"] == username
    end
  rescue => e
    return false
  end
  false
end

logger.info "Starting ejabberd authentication service"

loop do
  begin
#   Simple test with saschas user data. expires at about 18 am on 9/2
#    if auth('olKldimGqJxfqtCD', 'eyJ0b2tlbiI6eyJpZGVudGlmaWVyIjoib2xLbGRpbUdxSnhmcXRDRCIsInNjb3BlIjpbIjVkZW50aXR5Iiwid2Fja2Fkb28iLCJwYXltZW50Il0sInRpbWVzdGFtcCI6IjIwMTItMDktMDJUMTM6MzM6NTIrMDI6MDAifSwic2lnbmF0dXJlIjoiY2EzN2VkNDAyNWZhZDcwODkxY2E0MDk1MDAzZjVlNTdhNzQxNGM3ZSJ9')
#      puts "Valid authentication!"
#    else
#      puts "Invalid authentication!"
#    end
#    exit
    $stdin.eof? # wait for input
    start = Time.now

    msg = $stdin.read(2)
    length = msg.unpack('n').first

    msg = $stdin.read(length)
    cmd, *data = msg.split(":")

    logger.info "Incoming Request: '#{cmd}'"
    success = case cmd
    when "auth"
      logger.info "Authenticating #{data[0]}@#{data[1]}"
      auth(data[0], data[2])
    else
      false
    end

    bool = success ? 1 : 0
    $stdout.write [2, bool].pack("nn")
    logger.info "Response: #{success ? "success" : "failure"}"
  rescue => e
    logger.error "#{e.class.name}: #{e.message}"
    logger.error e.backtrace.join("\n\t")
  end
end