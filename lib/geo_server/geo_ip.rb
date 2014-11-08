require 'httparty'

module GeoServer

  class GeoIp
    
    def self.fetch_coords_for_ip(ip)
            
      unless ip.nil?
        
        begin
          response = HTTParty.get("http://geoip.psiori.com/api/v01/ip/#{ip}.json", {timeout: 3})
          Rails.logger.debug "Code: #{response.code}."
          if response.code == 200
            return response.parsed_response
          end
        
        rescue Timeout::Error => e
          Rails.logger.error "ERROR: Could not fetch geocoordinates during signup in time."
          Backend::StatusMailer.send_ip_resolution_alert(ip).deliver  # relies on the presence of the mailer; should be solved in a different fashion
          return nil

        rescue 
          Rails.logger.error "ERROR: Could not fetch geocoordinates during signup due to an unkown error."
          Backend::StatusMailer.send_ip_resolution_alert(ip).deliver  # relies on the presence of the mailer; should be solved in a different fashion
          return nil          
        end 
        
      end
      nil
    end
  end
end