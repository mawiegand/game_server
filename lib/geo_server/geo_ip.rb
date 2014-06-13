require 'httparty'

module GeoServer

  class GeoIp
    
    def self.fetch_coords_for_ip(ip)
      
      return nil # presently the geo server is down!
      
      unless ip.nil?
        
        begin
          response = HTTParty.get("http://freegeoip.net/json/#{ip}", {timeout: 3})
          if response.code == 200
            return response.parsed_response
          end
        
        rescue Timeout::Error => e
          Rails.logger.error "ERROR: Could not fetch geocoordinates during signup."
          Backend::StatusMailer.send_ip_resolution_alert(ip).deliver  # relies on the presence of the mailer; should be solved in a different fashion
          
          return nil
        end 
        
      end
      nil
    end
  end
end