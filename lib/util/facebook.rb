require 'base64'

module Util
  class Facebook

    def self.parse_signed_request(signed_request, secret, max_age=3600)
      encoded_sig, encoded_envelope = signed_request.split('.', 2)
      envelope = JSON.parse(self.base64_url_decode(encoded_envelope))
      algorithm = envelope['algorithm']
      return nil if algorithm != 'HMAC-SHA256'
      return nil if envelope['issued_at'] < Time.now.to_i - max_age
      return nil if self.base64_url_decode(encoded_sig) != OpenSSL::HMAC.hexdigest('sha256', secret, encoded_envelope).split.pack('H*')
      envelope
    end

    private

      def self.base64_url_decode(str)
        str += '=' * (4 - str.length.modulo(4))
        Base64.decode64(str.tr('-_','+/'))
      end

  end
end