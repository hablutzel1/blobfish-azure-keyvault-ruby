require 'blobfish/keyvault/authenticated_requestor'
require 'blobfish/keyvault/api_version'
require 'json'
require 'base64'

module Blobfish
  module Keyvault
    class Certificate
      def initialize(certificate_id, requestor)
        url = certificate_id + '?api-version=' + ApiVersion::DEFAULT_API_VERSION
        response = requestor.execute(:get, url)
        @cert_b64 = JSON.parse(response)['cer']
      end
      def to_base64()
        @cert_b64
      end
      def public_key
        cert_as_der = Base64.decode64(@cert_b64)
        certificate = OpenSSL::X509::Certificate.new cert_as_der
        certificate.public_key
      end
    end
  end
end
