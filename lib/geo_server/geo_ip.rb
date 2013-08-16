require 'httparty'

module GeoServer

  class GeoIp
    
    def self.fetch_coords_for_ip(ip)
      unless ip.nil?
        response = HTTParty.get("http://freegeoip.net/json/#{ip}", {timeout: 6})
        if response.code == 200
          return response.parsed_response
        end
      end
      nil
    end
  end
end