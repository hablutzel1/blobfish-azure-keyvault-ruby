require 'blobfish/keyvault/authenticated_requestor'
require 'blobfish/keyvault/api_version'
require 'json'
require 'base64'

module Blobfish
  module Keyvault
    class PrivateKey
      # @param [AuthenticatedRequestor] requestor
      def initialize(key_id, requestor)
        @key_id = key_id
        @requestor = requestor
      end
      def sign(digest, data)
        raise NotImplementedError, 'Only SHA-256 digest signature algorithm is currently supported.' unless digest.instance_of? OpenSSL::Digest::SHA256
        sha256 = Digest::SHA256.new
        base64_digest = Base64.strict_encode64(sha256.digest(data))
        url = @key_id + '/sign?api-version=' + ApiVersion::DEFAULT_API_VERSION
        response = @requestor.execute(:post, url, {alg: 'RS256', value: base64_digest}.to_json, {'Content-Type': "application/json"})
        base64_signature = JSON.parse(response)['value']
        base64_signature.tr!('-_', '+/')
        # TODO check: the previous 'base64_signature' could be missing padding '=' (equals) chars. Confirm that it is never required to complete the padding chars before decoding.
        Base64.decode64(base64_signature)
      end
    end
  end
end