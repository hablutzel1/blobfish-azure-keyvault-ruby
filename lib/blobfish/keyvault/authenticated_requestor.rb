require 'rest-client'
require 'json'

module Blobfish
  module Keyvault
    class AuthenticatedRequestor
      @authorization_header = nil
      def initialize(client_id, client_secret)
        @client_id = client_id
        @client_secret = client_secret
      end
      def execute(method, url, payload = nil, headers = {})
        begin
          perform_request(method, url, payload, headers)
        rescue RestClient::Unauthorized => e
          renew_access_token(e.response.headers[:www_authenticate])
          perform_request(method, url, payload, headers)
        end
      end
      private
      def perform_request(method, url, payload, headers)
        RestClient::Request.execute(:method => method, :url => url, :payload => payload, :headers => {Authorization: @authorization_header}.merge!(headers))
      end
      # TODO check for possible concurrency problems around the calls to 'renew_access_token', for example, if two different threads end up in the first 'perform_request' call (the one before the 'rescue') with an expired token at the same time, both will end up in a call to 'renew_access_token' generating unnecessarily more than one 'access_token'.
      def renew_access_token(www_authenticate_header)
        # TODO look for an standard way to parse this WWW-Authenticate header content.
        auth_url = www_authenticate_header.match(/authorization="(.*?)"/i).captures.first
        auth_url << '/oauth2/token'
        # TODO extract the 'https://vault.azure.net' 'resource' from the WWW-Authenticate header. Could it really differ from 'https://vault.azure.net'?.
        response = RestClient::Request.execute(method: :post, url: auth_url, payload: {grant_type: 'client_credentials', client_id: @client_id, client_secret: @client_secret, resource: 'https://vault.azure.net'}, headers: {'Content-Type': 'application/x-www-form-urlencoded'})
        access_token = JSON.parse(response)['access_token']
        @authorization_header = "Bearer #{access_token}"
      end
    end
  end
end