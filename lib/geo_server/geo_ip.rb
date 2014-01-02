require 'httparty'

module GeoServer

  class GeoIp
    
    def self.fetch_coords_for_ip(ip)
      unless ip.nil?
        
        begin
          response = HTTParty.get("http://freegeoip.net/json/#{ip}", {timeout: 6})
          if response.code == 200
            return response.parsed_response
          end
        
        rescue Timeout::Error => e
          Rails.logger.error "ERROR: Could not fetch geocoordinates during signup."
          return nil
        end 
        
      end
      nil
    end
  end
end